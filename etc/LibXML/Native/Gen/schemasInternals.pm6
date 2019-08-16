use v6;
#  -- DO NOT EDIT --
# generated by: etc/generator.p6 

unit module LibXML::Native::Gen::schemasInternals;
# internal interfaces for XML Schemas:
#    internal interfaces for the XML Schemas handling and schema validity checking The Schemas development is a Work In Progress. Some of those interfaces are not guaranteed to be API or ABI stable ! 
use LibXML::Native::Defs :LIB, :XmlCharP;

enum xmlSchemaContentType is export {
    XML_SCHEMA_CONTENT_ANY => 7,
    XML_SCHEMA_CONTENT_BASIC => 6,
    XML_SCHEMA_CONTENT_ELEMENTS => 2,
    XML_SCHEMA_CONTENT_EMPTY => 1,
    XML_SCHEMA_CONTENT_MIXED => 3,
    XML_SCHEMA_CONTENT_MIXED_OR_ELEMENTS => 5,
    XML_SCHEMA_CONTENT_SIMPLE => 4,
    XML_SCHEMA_CONTENT_UNKNOWN => 0,
}

enum xmlSchemaTypeType is export {
    XML_SCHEMA_EXTRA_ATTR_USE_PROHIB => 2001,
    XML_SCHEMA_EXTRA_QNAMEREF => 2000,
    XML_SCHEMA_FACET_ENUMERATION => 1007,
    XML_SCHEMA_FACET_FRACTIONDIGITS => 1005,
    XML_SCHEMA_FACET_LENGTH => 1009,
    XML_SCHEMA_FACET_MAXEXCLUSIVE => 1003,
    XML_SCHEMA_FACET_MAXINCLUSIVE => 1002,
    XML_SCHEMA_FACET_MAXLENGTH => 1010,
    XML_SCHEMA_FACET_MINEXCLUSIVE => 1001,
    XML_SCHEMA_FACET_MININCLUSIVE => 1000,
    XML_SCHEMA_FACET_MINLENGTH => 1011,
    XML_SCHEMA_FACET_PATTERN => 1006,
    XML_SCHEMA_FACET_TOTALDIGITS => 1004,
    XML_SCHEMA_FACET_WHITESPACE => 1008,
    XML_SCHEMA_TYPE_ALL => 8,
    XML_SCHEMA_TYPE_ANY => 2,
    XML_SCHEMA_TYPE_ANY_ATTRIBUTE => 21,
    XML_SCHEMA_TYPE_ATTRIBUTE => 15,
    XML_SCHEMA_TYPE_ATTRIBUTEGROUP => 16,
    XML_SCHEMA_TYPE_ATTRIBUTE_USE => 26,
    XML_SCHEMA_TYPE_BASIC => 1,
    XML_SCHEMA_TYPE_CHOICE => 7,
    XML_SCHEMA_TYPE_COMPLEX => 5,
    XML_SCHEMA_TYPE_COMPLEX_CONTENT => 10,
    XML_SCHEMA_TYPE_ELEMENT => 14,
    XML_SCHEMA_TYPE_EXTENSION => 13,
    XML_SCHEMA_TYPE_FACET => 3,
    XML_SCHEMA_TYPE_GROUP => 17,
    XML_SCHEMA_TYPE_IDC_KEY => 23,
    XML_SCHEMA_TYPE_IDC_KEYREF => 24,
    XML_SCHEMA_TYPE_IDC_UNIQUE => 22,
    XML_SCHEMA_TYPE_LIST => 19,
    XML_SCHEMA_TYPE_NOTATION => 18,
    XML_SCHEMA_TYPE_PARTICLE => 25,
    XML_SCHEMA_TYPE_RESTRICTION => 12,
    XML_SCHEMA_TYPE_SEQUENCE => 6,
    XML_SCHEMA_TYPE_SIMPLE => 4,
    XML_SCHEMA_TYPE_SIMPLE_CONTENT => 9,
    XML_SCHEMA_TYPE_UNION => 20,
    XML_SCHEMA_TYPE_UR => 11,
}

enum xmlSchemaValType is export {
    XML_SCHEMAS_ANYSIMPLETYPE => 46,
    XML_SCHEMAS_ANYTYPE => 45,
    XML_SCHEMAS_ANYURI => 29,
    XML_SCHEMAS_BASE64BINARY => 44,
    XML_SCHEMAS_BOOLEAN => 15,
    XML_SCHEMAS_BYTE => 41,
    XML_SCHEMAS_DATE => 10,
    XML_SCHEMAS_DATETIME => 11,
    XML_SCHEMAS_DECIMAL => 3,
    XML_SCHEMAS_DOUBLE => 14,
    XML_SCHEMAS_DURATION => 12,
    XML_SCHEMAS_ENTITIES => 27,
    XML_SCHEMAS_ENTITY => 26,
    XML_SCHEMAS_FLOAT => 13,
    XML_SCHEMAS_GDAY => 5,
    XML_SCHEMAS_GMONTH => 6,
    XML_SCHEMAS_GMONTHDAY => 7,
    XML_SCHEMAS_GYEAR => 8,
    XML_SCHEMAS_GYEARMONTH => 9,
    XML_SCHEMAS_HEXBINARY => 43,
    XML_SCHEMAS_ID => 23,
    XML_SCHEMAS_IDREF => 24,
    XML_SCHEMAS_IDREFS => 25,
    XML_SCHEMAS_INT => 35,
    XML_SCHEMAS_INTEGER => 30,
    XML_SCHEMAS_LANGUAGE => 17,
    XML_SCHEMAS_LONG => 37,
    XML_SCHEMAS_NAME => 20,
    XML_SCHEMAS_NCNAME => 22,
    XML_SCHEMAS_NINTEGER => 32,
    XML_SCHEMAS_NMTOKEN => 18,
    XML_SCHEMAS_NMTOKENS => 19,
    XML_SCHEMAS_NNINTEGER => 33,
    XML_SCHEMAS_NORMSTRING => 2,
    XML_SCHEMAS_NOTATION => 28,
    XML_SCHEMAS_NPINTEGER => 31,
    XML_SCHEMAS_PINTEGER => 34,
    XML_SCHEMAS_QNAME => 21,
    XML_SCHEMAS_SHORT => 39,
    XML_SCHEMAS_STRING => 1,
    XML_SCHEMAS_TIME => 4,
    XML_SCHEMAS_TOKEN => 16,
    XML_SCHEMAS_UBYTE => 42,
    XML_SCHEMAS_UINT => 36,
    XML_SCHEMAS_ULONG => 38,
    XML_SCHEMAS_UNKNOWN => 0,
    XML_SCHEMAS_USHORT => 40,
}

struct xmlSchemaAnnot is repr('CStruct') {
    has struct _xmlSchemaAnnot * $.next;
    has xmlNode $.content; # the annotation
}

struct xmlSchemaAttribute is repr('CStruct') {
    has xmlSchemaTypeType $.type;
    has struct _xmlSchemaAttribute * $.next; # the next attribute (not used?)
    has xmlCharP $.name; # the name of the declaration
    has xmlCharP $.id; # Deprecated; not used
    has xmlCharP $.ref; # Deprecated; not used
    has xmlCharP $.refNs; # Deprecated; not used
    has xmlCharP $.typeName; # the local name of the type definition
    has xmlCharP $.typeNs; # the ns URI of the type definition
    has xmlSchemaAnnot $.annot;
    has xmlSchemaType $.base; # Deprecated; not used
    has int32 $.occurs; # Deprecated; not used
    has xmlCharP $.defValue; # The initial value of the value constraint
    has xmlSchemaType $.subtypes; # the type definition
    has xmlNode $.node;
    has xmlCharP $.targetNamespace;
    has int32 $.flags;
    has xmlCharP $.refPrefix; # Deprecated; not used
    has xmlSchemaVal $.defVal; # The compiled value constraint
    has xmlSchemaAttribute $.refDecl; # Deprecated; not used
}

struct xmlSchemaAttributeGroup is repr('CStruct') {
    has xmlSchemaTypeType $.type; # The kind of type
    has struct _xmlSchemaAttribute * $.next; # the next attribute if in a group ...
    has xmlCharP $.name;
    has xmlCharP $.id;
    has xmlCharP $.ref; # Deprecated; not used
    has xmlCharP $.refNs; # Deprecated; not used
    has xmlSchemaAnnot $.annot;
    has xmlSchemaAttribute $.attributes; # Deprecated; not used
    has xmlNode $.node;
    has int32 $.flags;
    has xmlSchemaWildcard $.attributeWildcard;
    has xmlCharP $.refPrefix; # Deprecated; not used
    has xmlSchemaAttributeGroup $.refItem; # Deprecated; not used
    has xmlCharP $.targetNamespace;
    has Pointer $.attrUses;
}

struct xmlSchemaAttributeLink is repr('CStruct') {
    has struct _xmlSchemaAttributeLink * $.next; # the next attribute link ...
    has struct _xmlSchemaAttribute * $.attr; # the linked attribute
}

struct xmlSchemaElement is repr('CStruct') {
    has xmlSchemaTypeType $.type; # The kind of type
    has struct _xmlSchemaType * $.next; # Not used?
    has xmlCharP $.name;
    has xmlCharP $.id; # Deprecated; not used
    has xmlCharP $.ref; # Deprecated; not used
    has xmlCharP $.refNs; # Deprecated; not used
    has xmlSchemaAnnot $.annot;
    has xmlSchemaType $.subtypes; # the type definition
    has xmlSchemaAttribute $.attributes;
    has xmlNode $.node;
    has int32 $.minOccurs; # Deprecated; not used
    has int32 $.maxOccurs; # Deprecated; not used
    has int32 $.flags;
    has xmlCharP $.targetNamespace;
    has xmlCharP $.namedType;
    has xmlCharP $.namedTypeNs;
    has xmlCharP $.substGroup;
    has xmlCharP $.substGroupNs;
    has xmlCharP $.scope;
    has xmlCharP $.value; # The original value of the value constraint.
    has struct _xmlSchemaElement * $.refDecl; # This will now be used for the substitution group affiliation
    has xmlRegexp $.contModel; # Obsolete for WXS, maybe used for RelaxNG
    has xmlSchemaContentType $.contentType;
    has xmlCharP $.refPrefix; # Deprecated; not used
    has xmlSchemaVal $.defVal; # The compiled value contraint.
    has Pointer $.idcs; # The identity-constraint defs
}

struct xmlSchemaFacet is repr('CStruct') {
    has xmlSchemaTypeType $.type; # The kind of type
    has struct _xmlSchemaFacet * $.next; # the next type if in a sequence ...
    has xmlCharP $.value; # The original value
    has xmlCharP $.id; # Obsolete
    has xmlSchemaAnnot $.annot;
    has xmlNode $.node;
    has int32 $.fixed; # XML_SCHEMAS_FACET_PRESERVE, etc.
    has int32 $.whitespace;
    has xmlSchemaVal $.val; # The compiled value
    has xmlRegexp $.regexp; # The regex for patterns

    sub xmlSchemaNewFacet( --> xmlSchemaFacet) is native(LIB) {*};

    method xmlSchemaCheckFacet(xmlSchemaType $typeDecl, xmlSchemaParserCtxt $pctxt, xmlCharP $name --> int32) is native(LIB) {*};
    method xmlSchemaFreeFacet() is native(LIB) {*};
    method xmlSchemaGetFacetValueAsULong( --> unsigned long) is native(LIB) {*};
    method xmlSchemaValidateFacetWhtsp(xmlSchemaWhitespaceValueType $fws, xmlSchemaValType $valType, xmlCharP $value, xmlSchemaVal $val, xmlSchemaWhitespaceValueType $ws --> int32) is native(LIB) {*};
    method xmlSchemaValidateLengthFacetWhtsp(xmlSchemaValType $valType, xmlCharP $value, xmlSchemaVal $val, unsigned long * $length, xmlSchemaWhitespaceValueType $ws --> int32) is native(LIB) {*};
    method xmlSchemaValidateListSimpleTypeFacet(xmlCharP $value, unsigned long $actualLen, unsigned long * $expectedLen --> int32) is native(LIB) {*};
}

struct xmlSchemaFacetLink is repr('CStruct') {
    has struct _xmlSchemaFacetLink * $.next; # the next facet link ...
    has xmlSchemaFacet $.facet; # the linked facet
}

struct xmlSchemaNotation is repr('CStruct') {
    has xmlSchemaTypeType $.type; # The kind of type
    has xmlCharP $.name;
    has xmlSchemaAnnot $.annot;
    has xmlCharP $.identifier;
    has xmlCharP $.targetNamespace;
}

struct xmlSchemaType is repr('CStruct') {
    has xmlSchemaTypeType $.type; # The kind of type
    has struct _xmlSchemaType * $.next; # the next type if in a sequence ...
    has xmlCharP $.name;
    has xmlCharP $.id; # Deprecated; not used
    has xmlCharP $.ref; # Deprecated; not used
    has xmlCharP $.refNs; # Deprecated; not used
    has xmlSchemaAnnot $.annot;
    has xmlSchemaType $.subtypes;
    has xmlSchemaAttribute $.attributes; # Deprecated; not used
    has xmlNode $.node;
    has int32 $.minOccurs; # Deprecated; not used
    has int32 $.maxOccurs; # Deprecated; not used
    has int32 $.flags;
    has xmlSchemaContentType $.contentType;
    has xmlCharP $.base; # Base type's local name
    has xmlCharP $.baseNs; # Base type's target namespace
    has xmlSchemaType $.baseType; # The base type component
    has xmlSchemaFacet $.facets; # Local facets
    has struct _xmlSchemaType * $.redef; # Deprecated; not used
    has int32 $.recurse; # Obsolete
    has xmlSchemaAttributeLinkPtr * $.attributeUses; # Deprecated; not used
    has xmlSchemaWildcard $.attributeWildcard;
    has int32 $.builtInType; # Type of built-in types.
    has xmlSchemaTypeLink $.memberTypes; # member-types if a union type.
    has xmlSchemaFacetLink $.facetSet; # All facets (incl. inherited)
    has xmlCharP $.refPrefix; # Deprecated; not used
    has xmlSchemaType $.contentTypeDef; # Used for the simple content of complex types. Could we use @subtypes for this?
    has xmlRegexp $.contModel; # Holds the automaton of the content model
    has xmlCharP $.targetNamespace;
    has Pointer $.attrUses;

    sub xmlSchemaGetBuiltInType(xmlSchemaValType $type --> xmlSchemaType) is native(LIB) {*};
    sub xmlSchemaGetPredefinedType(xmlCharP $name, xmlCharP $ns --> xmlSchemaType) is native(LIB) {*};

    method xmlSchemaFreeType() is native(LIB) {*};
    method xmlSchemaGetBuiltInListSimpleTypeItemType( --> xmlSchemaType) is native(LIB) {*};
    method xmlSchemaIsBuiltInTypeFacet(int32 $facetType --> int32) is native(LIB) {*};
    method xmlSchemaValPredefTypeNode(xmlCharP $value, xmlSchemaValPtr * $val, xmlNode $node --> int32) is native(LIB) {*};
    method xmlSchemaValPredefTypeNodeNoNorm(xmlCharP $value, xmlSchemaValPtr * $val, xmlNode $node --> int32) is native(LIB) {*};
    method xmlSchemaValidateFacet(xmlSchemaFacet $facet, xmlCharP $value, xmlSchemaVal $val --> int32) is native(LIB) {*};
    method xmlSchemaValidateLengthFacet(xmlSchemaFacet $facet, xmlCharP $value, xmlSchemaVal $val, unsigned long * $length --> int32) is native(LIB) {*};
    method xmlSchemaValidatePredefinedType(xmlCharP $value, xmlSchemaValPtr * $val --> int32) is native(LIB) {*};
}

struct xmlSchemaTypeLink is repr('CStruct') {
    has struct _xmlSchemaTypeLink * $.next; # the next type link ...
    has xmlSchemaType $.type; # the linked type
}

struct xmlSchemaVal is repr('CPointer') {
    sub xmlSchemaNewNOTATIONValue(xmlCharP $name, xmlCharP $ns --> xmlSchemaVal) is native(LIB) {*};
    sub xmlSchemaNewQNameValue(xmlCharP $namespaceName, xmlCharP $localName --> xmlSchemaVal) is native(LIB) {*};
    sub xmlSchemaNewStringValue(xmlSchemaValType $type, xmlCharP $value --> xmlSchemaVal) is native(LIB) {*};

    method xmlSchemaCompareValues(xmlSchemaVal $y --> int32) is native(LIB) {*};
    method xmlSchemaCompareValuesWhtsp(xmlSchemaWhitespaceValueType $xws, xmlSchemaVal $y, xmlSchemaWhitespaceValueType $yws --> int32) is native(LIB) {*};
    method xmlSchemaCopyValue( --> xmlSchemaVal) is native(LIB) {*};
    method xmlSchemaFreeValue() is native(LIB) {*};
    method xmlSchemaGetCanonValue(const xmlChar ** $retValue --> int32) is native(LIB) {*};
    method xmlSchemaGetCanonValueWhtsp(const xmlChar ** $retValue, xmlSchemaWhitespaceValueType $ws --> int32) is native(LIB) {*};
    method xmlSchemaGetValType( --> xmlSchemaValType) is native(LIB) {*};
    method xmlSchemaValueAppend(xmlSchemaVal $cur --> int32) is native(LIB) {*};
    method xmlSchemaValueGetAsBoolean( --> int32) is native(LIB) {*};
    method xmlSchemaValueGetAsString( --> xmlCharP) is native(LIB) {*};
    method xmlSchemaValueGetNext( --> xmlSchemaVal) is native(LIB) {*};
}

struct xmlSchemaWildcard is repr('CStruct') {
    has xmlSchemaTypeType $.type; # The kind of type
    has xmlCharP $.id; # Deprecated; not used
    has xmlSchemaAnnot $.annot;
    has xmlNode $.node;
    has int32 $.minOccurs; # Deprecated; not used
    has int32 $.maxOccurs; # Deprecated; not used
    has int32 $.processContents;
    has int32 $.any; # Indicates if the ns constraint is of ##any
    has xmlSchemaWildcardNs $.nsSet; # The list of allowed namespaces
    has xmlSchemaWildcardNs $.negNsSet; # The negated namespace
    has int32 $.flags;
    method xmlSchemaFreeWildcard() is native(LIB) {*};
}

struct xmlSchemaWildcardNs is repr('CStruct') {
    has struct _xmlSchemaWildcardNs * $.next; # the next constraint link ...
    has xmlCharP $.value; # the value
}
