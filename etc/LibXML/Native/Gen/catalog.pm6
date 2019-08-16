use v6;
#  -- DO NOT EDIT --
# generated by: etc/generator.p6 

unit module LibXML::Native::Gen::catalog;
# interfaces to the Catalog handling system:
#    the catalog module implements the support for XML Catalogs and SGML catalogs 
use LibXML::Native::Defs :LIB, :XmlCharP;

enum xmlCatalogAllow is export {
    XML_CATA_ALLOW_ALL => 3,
    XML_CATA_ALLOW_DOCUMENT => 2,
    XML_CATA_ALLOW_GLOBAL => 1,
    XML_CATA_ALLOW_NONE => 0,
}

enum xmlCatalogPrefer is export {
    XML_CATA_PREFER_NONE => 0,
    XML_CATA_PREFER_PUBLIC => 1,
    XML_CATA_PREFER_SYSTEM => 2,
}

struct xmlCatalog is repr('CPointer') {
    sub xmlLoadACatalog(Str $filename --> xmlCatalog) is native(LIB) {*};
    sub xmlLoadSGMLSuperCatalog(Str $filename --> xmlCatalog) is native(LIB) {*};
    sub xmlNewCatalog(int32 $sgml --> xmlCatalog) is native(LIB) {*};

    method xmlACatalogAdd(xmlCharP $type, xmlCharP $orig, xmlCharP $replace --> int32) is native(LIB) {*};
    method xmlACatalogDump(FILE * $out) is native(LIB) {*};
    method xmlACatalogRemove(xmlCharP $value --> int32) is native(LIB) {*};
    method xmlACatalogResolve(xmlCharP $pubID, xmlCharP $sysID --> xmlCharP) is native(LIB) {*};
    method xmlACatalogResolvePublic(xmlCharP $pubID --> xmlCharP) is native(LIB) {*};
    method xmlACatalogResolveSystem(xmlCharP $sysID --> xmlCharP) is native(LIB) {*};
    method xmlACatalogResolveURI(xmlCharP $URI --> xmlCharP) is native(LIB) {*};
    method xmlCatalogIsEmpty( --> int32) is native(LIB) {*};
    method xmlConvertSGMLCatalog( --> int32) is native(LIB) {*};
    method xmlFreeCatalog() is native(LIB) {*};
}

sub xmlCatalogAdd(xmlCharP $type, xmlCharP $orig, xmlCharP $replace --> int32) is native(LIB) {*};
sub xmlCatalogAddLocal(Pointer $catalogs, xmlCharP $URL --> Pointer) is native(LIB) {*};
sub xmlCatalogCleanup() is native(LIB) {*};
sub xmlCatalogConvert( --> int32) is native(LIB) {*};
sub xmlCatalogDump(FILE * $out) is native(LIB) {*};
sub xmlCatalogFreeLocal(Pointer $catalogs) is native(LIB) {*};
sub xmlCatalogGetDefaults( --> xmlCatalogAllow) is native(LIB) {*};
sub xmlCatalogGetPublic(xmlCharP $pubID --> xmlCharP) is native(LIB) {*};
sub xmlCatalogGetSystem(xmlCharP $sysID --> xmlCharP) is native(LIB) {*};
sub xmlCatalogLocalResolve(Pointer $catalogs, xmlCharP $pubID, xmlCharP $sysID --> xmlCharP) is native(LIB) {*};
sub xmlCatalogLocalResolveURI(Pointer $catalogs, xmlCharP $URI --> xmlCharP) is native(LIB) {*};
sub xmlCatalogRemove(xmlCharP $value --> int32) is native(LIB) {*};
sub xmlCatalogResolve(xmlCharP $pubID, xmlCharP $sysID --> xmlCharP) is native(LIB) {*};
sub xmlCatalogResolvePublic(xmlCharP $pubID --> xmlCharP) is native(LIB) {*};
sub xmlCatalogResolveSystem(xmlCharP $sysID --> xmlCharP) is native(LIB) {*};
sub xmlCatalogResolveURI(xmlCharP $URI --> xmlCharP) is native(LIB) {*};
sub xmlCatalogSetDebug(int32 $level --> int32) is native(LIB) {*};
sub xmlCatalogSetDefaultPrefer(xmlCatalogPrefer $prefer --> xmlCatalogPrefer) is native(LIB) {*};
sub xmlCatalogSetDefaults(xmlCatalogAllow $allow) is native(LIB) {*};
sub xmlInitializeCatalog() is native(LIB) {*};
sub xmlLoadCatalog(Str $filename --> int32) is native(LIB) {*};
sub xmlLoadCatalogs(Str $pathss) is native(LIB) {*};
