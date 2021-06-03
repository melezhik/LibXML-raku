#include <libxml/xpath.h>
#include <libxml/hash.h>
#include <string.h>
#include <assert.h>

#include "xml6.h"
#include "xml6_node.h"
#include "xml6_hash.h"
#include "dom.h"
#include "domXPath.h"

static void _xml6_get_key(void* value, const xmlChar*** keys, xmlChar* key) {
    *((*keys)++) = xmlStrdup(key);
}

static void _xml6_get_value(void* value, const void*** values, xmlChar* key) {
    *((*values)++) = value;
}

static void _xml6_get_pair(void* value, const void*** pairs, xmlChar* key) {
    *((*pairs)++) = (void*) xmlStrdup(key);
    *((*pairs)++) = value;
}

static void _xml6_scan(xmlHashTablePtr self, xmlHashScanner scanner, int n, void** buf) {
    void** p;
    assert(self != NULL);
    assert(buf != NULL);
    p = buf;
    xmlHashScan(self, scanner, (void*) &p);
    assert(p == &(buf[xmlHashSize(self) * n]));
}

DLLEXPORT void xml6_hash_keys(xmlHashTablePtr self, void** buf) {
    _xml6_scan(self, (xmlHashScanner) _xml6_get_key, 1, buf);
}

DLLEXPORT void xml6_hash_values(xmlHashTablePtr self, void** buf) {
    _xml6_scan(self, (xmlHashScanner) _xml6_get_value, 1, buf);
}

DLLEXPORT void xml6_hash_key_values(xmlHashTablePtr self, void** buf) {
    _xml6_scan(self, (xmlHashScanner) _xml6_get_pair, 2, buf);
}

DLLEXPORT void xml6_hash_add_pairs(xmlHashTablePtr self, void** pairs, unsigned int n, xmlHashDeallocator deallocator) {
    assert(self != NULL);
    assert((n % 2) == 0);

    if (n) {
        unsigned int i = 0;
        assert(pairs != NULL);
        for (i = 0; i < n; i += 2) {
            xmlChar* key = (xmlChar*) pairs[i];
            void* value  = pairs[i+1];
            xmlHashUpdateEntry(self, key, value, deallocator);
        }
    }
}

static void _hash_xpath_node(xmlHashTablePtr self, xmlNodePtr node) {
    assert(self != NULL);

    if (node != NULL) {
        xmlChar* key = domGetXPathKey(node);
        xmlNodeSetPtr bucket = (xmlNodeSetPtr) xmlHashLookup(self, key);

        if (bucket == NULL) {
            bucket = xmlXPathNodeSetCreate(NULL);
            xmlHashAddEntry(self, key, (void*) bucket);
        }

        domPushNodeSet(bucket, node, 0);
    }
}

static void _hash_xpath_node_siblings(xmlHashTablePtr self, xmlNodePtr node, int keep_blanks) {
    assert(self != NULL);

    if (node != NULL) {
        xmlChar* key = domGetXPathKey(node);
        xmlNodeSetPtr bucket = (xmlNodeSetPtr) xmlHashLookup(self, key);
        xmlNodePtr next = (node->type == XML_NAMESPACE_DECL)
            ? (xmlNodePtr) ((xmlNsPtr) node)->next
            : xml6_node_next(node, keep_blanks);

        if (bucket == NULL) {
            bucket = xmlXPathNodeSetCreate(NULL);
            xmlHashAddEntry(self, key, (void*) bucket);
        }

        domPushNodeSet(bucket, node, 1);
        xmlFree(key);

        _hash_xpath_node_siblings(self, next, keep_blanks);
    }
}

static void _hash_xpath_node_children(xmlHashTablePtr self, xmlNodePtr node, int keep_blanks) {
    assert(self != NULL);
    _hash_xpath_node_siblings(self, node->children, keep_blanks);
    _hash_xpath_node_siblings(self, (xmlNodePtr) node->properties, keep_blanks);
}

DLLEXPORT xmlHashTablePtr xml6_hash_xpath_node_children(xmlNodePtr node, int keep_blanks) {
    xmlHashTablePtr rv = xmlHashCreate(0);
    assert(rv != NULL);
    _hash_xpath_node_children(rv, node, keep_blanks);
    return rv;
}

DLLEXPORT xmlHashTablePtr xml6_hash_xpath_nodeset(xmlNodeSetPtr nodes, int deref) {
    xmlHashTablePtr rv = xmlHashCreate(0);
    assert(rv != NULL);

    if (nodes != NULL) {
        int i;
        for (i = 0; i < nodes->nodeNr; i++) {
            xmlNodePtr node = nodes->nodeTab[i];

            if (deref) {
                _hash_xpath_node_children(rv, node, 1);
            }
            else {
                _hash_xpath_node(rv, node);
            }
        }
    }
    return rv;
}

static void _xml6_build_hash_attrs(void* value, const void* _self, xmlChar* attr_name, xmlChar *attr_prefix, xmlChar *elem_name) {
    xmlHashTablePtr self = (xmlHashTablePtr) _self;
    xmlHashTablePtr bucket = (xmlHashTablePtr) xmlHashLookup(self, elem_name);

    if (bucket == NULL) {
        // Vivify sub-hash
        bucket = xmlHashCreate(0);
        xmlHashAddEntry(self, elem_name, (void*) bucket);
    }

    if (attr_prefix == NULL) {
        xmlHashAddEntry(bucket, attr_name, value);
    }
    else {
        xmlChar* key = xmlStrdup(attr_prefix);
        key = xmlStrcat(key, (const xmlChar*) ":" );
        key = xmlStrcat(key, attr_name );
        xmlHashAddEntry(bucket, key, value);
        xmlFree(key);
    }
}

// Build a HoH mapping from the dtd->attributes hash
DLLEXPORT xmlHashTablePtr xml6_hash_build_attr_decls(xmlHashTablePtr self) {
    xmlHashTablePtr rv = xmlHashCreate(0);
    assert(self != NULL);
    assert(rv != NULL);

    xmlHashScanFull(self, (xmlHashScannerFull) _xml6_build_hash_attrs, (void *) rv);
    return rv;
}

// Free the hash, leave contents intact
static void _keep_hash_contents(void *entry, const xmlChar *name ATTRIBUTE_UNUSED) {
    // do nothing
}
DLLEXPORT void xml6_hash_discard(xmlHashTablePtr self) {
    xmlHashFree(self, (xmlHashDeallocator) _keep_hash_contents );
}
