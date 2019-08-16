use v6;
#  -- DO NOT EDIT --
# generated by: etc/generator.p6 

unit module LibXML::Native::Gen::xpath;
# XML Path Language implementation:
#    API for the XML Path Language implementation  XML Path Language implementation XPath is a language for addressing parts of an XML document, designed to be used by both XSLT and XPointer
use LibXML::Native::Defs :LIB, :XmlCharP;

enum xmlXPathError is export {
    XPATH_ENCODING_ERROR => 20,
    XPATH_EXPRESSION_OK => 0,
    XPATH_EXPR_ERROR => 7,
    XPATH_FORBID_VARIABLE_ERROR => 24,
    XPATH_INVALID_ARITY => 12,
    XPATH_INVALID_CHAR_ERROR => 21,
    XPATH_INVALID_CTXT => 22,
    XPATH_INVALID_CTXT_POSITION => 14,
    XPATH_INVALID_CTXT_SIZE => 13,
    XPATH_INVALID_OPERAND => 10,
    XPATH_INVALID_PREDICATE_ERROR => 6,
    XPATH_INVALID_TYPE => 11,
    XPATH_MEMORY_ERROR => 15,
    XPATH_NUMBER_ERROR => 1,
    XPATH_STACK_ERROR => 23,
    XPATH_START_LITERAL_ERROR => 3,
    XPATH_UNCLOSED_ERROR => 8,
    XPATH_UNDEF_PREFIX_ERROR => 19,
    XPATH_UNDEF_VARIABLE_ERROR => 5,
    XPATH_UNFINISHED_LITERAL_ERROR => 2,
    XPATH_UNKNOWN_FUNC_ERROR => 9,
    XPATH_VARIABLE_REF_ERROR => 4,
    XPTR_RESOURCE_ERROR => 17,
    XPTR_SUB_RESOURCE_ERROR => 18,
    XPTR_SYNTAX_ERROR => 16,
}

enum xmlXPathObjectType is export {
    XPATH_BOOLEAN => 2,
    XPATH_LOCATIONSET => 7,
    XPATH_NODESET => 1,
    XPATH_NUMBER => 3,
    XPATH_POINT => 5,
    XPATH_RANGE => 6,
    XPATH_STRING => 4,
    XPATH_UNDEFINED => 0,
    XPATH_USERS => 8,
    XPATH_XSLT_TREE => 9,
}

struct xmlNodeSet is repr('CStruct') {
    has int32 $.nodeNr; # number of nodes in the set
    has int32 $.nodeMax; # size of the array as allocated
    has xmlNodePtr * $.nodeTab; # array of nodes in no particular order @@ with_ns to check wether namespace nodes should be looked at @@
    method xmlXPathCastNodeSetToBoolean( --> int32) is native(LIB) {*};
    method xmlXPathCastNodeSetToNumber( --> num64) is native(LIB) {*};
    method xmlXPathCastNodeSetToString( --> xmlCharP) is native(LIB) {*};
    method xmlXPathDifference(xmlNodeSet $nodes2 --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathDistinct( --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathDistinctSorted( --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathFreeNodeSet() is native(LIB) {*};
    method xmlXPathHasSameNodes(xmlNodeSet $nodes2 --> int32) is native(LIB) {*};
    method xmlXPathIntersection(xmlNodeSet $nodes2 --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathLeading(xmlNodeSet $nodes2 --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathLeadingSorted(xmlNodeSet $nodes2 --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathNewNodeSetList( --> xmlXPathObject) is native(LIB) {*};
    method xmlXPathNodeLeading(xmlNode $node --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathNodeLeadingSorted(xmlNode $node --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathNodeSetAdd(xmlNode $val --> int32) is native(LIB) {*};
    method xmlXPathNodeSetAddNs(xmlNode $node, xmlNs $ns --> int32) is native(LIB) {*};
    method xmlXPathNodeSetAddUnique(xmlNode $val --> int32) is native(LIB) {*};
    method xmlXPathNodeSetContains(xmlNode $val --> int32) is native(LIB) {*};
    method xmlXPathNodeSetDel(xmlNode $val) is native(LIB) {*};
    method xmlXPathNodeSetMerge(xmlNodeSet $val2 --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathNodeSetRemove(int32 $val) is native(LIB) {*};
    method xmlXPathNodeSetSort() is native(LIB) {*};
    method xmlXPathNodeTrailing(xmlNode $node --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathNodeTrailingSorted(xmlNode $node --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathTrailing(xmlNodeSet $nodes2 --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathTrailingSorted(xmlNodeSet $nodes2 --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathWrapNodeSet( --> xmlXPathObject) is native(LIB) {*};
    method xmlXPtrNewLocationSetNodeSet( --> xmlXPathObject) is native(LIB) {*};
}

struct xmlXPathAxis is repr('CStruct') {
    has xmlCharP $.name; # the axis name
    has xmlXPathAxisFunc $.func; # the search function
}

struct xmlXPathCompExpr is repr('CPointer') {
    sub xmlXPathCompile(xmlCharP $str --> xmlXPathCompExpr) is native(LIB) {*};

    method xmlXPathCompiledEval(xmlXPathContext $ctx --> xmlXPathObject) is native(LIB) {*};
    method xmlXPathCompiledEvalToBoolean(xmlXPathContext $ctxt --> int32) is native(LIB) {*};
    method xmlXPathFreeCompExpr() is native(LIB) {*};
}

struct xmlXPathContext is repr('CStruct') {
    has xmlDoc $.doc; # The current document
    has xmlNode $.node; # The current node
    has int32 $.nb_variables_unused; # unused (hash table)
    has int32 $.max_variables_unused; # unused (hash table)
    has xmlHashTable $.varHash; # Hash table of defined variables
    has int32 $.nb_types; # number of defined types
    has int32 $.max_types; # max number of types
    has xmlXPathType $.types; # Array of defined types
    has int32 $.nb_funcs_unused; # unused (hash table)
    has int32 $.max_funcs_unused; # unused (hash table)
    has xmlHashTable $.funcHash; # Hash table of defined funcs
    has int32 $.nb_axis; # number of defined axis
    has int32 $.max_axis; # max number of axis
    has xmlXPathAxis $.axis; # Array of defined axis the namespace nodes of the context node
    has xmlNsPtr * $.namespaces; # Array of namespaces
    has int32 $.nsNr; # number of namespace in scope
    has Pointer $.user; # function to free extra variables
    has int32 $.contextSize; # the context size
    has int32 $.proximityPosition; # the proximity position extra stuff for XPointer
    has int32 $.xptr; # is this an XPointer context?
    has xmlNode $.here; # for here()
    has xmlNode $.origin; # for origin() the set of namespace declarations in scope for the expression
    has xmlHashTable $.nsHash; # The namespaces hash table
    has xmlXPathVariableLookupFunc $.varLookupFunc; # variable lookup func
    has Pointer $.varLookupData; # variable lookup data Possibility to link in an extra item
    has Pointer $.extra; # needed for XSLT The function name and URI when calling a function
    has xmlCharP $.function;
    has xmlCharP $.functionURI; # function lookup function and data
    has xmlXPathFuncLookupFunc $.funcLookupFunc; # function lookup func
    has Pointer $.funcLookupData; # function lookup data temporary namespace lists kept for walking the namespace axis
    has xmlNsPtr * $.tmpNsList; # Array of namespaces
    has int32 $.tmpNsNr; # number of namespaces in scope error reporting mechanism
    has Pointer $.userData; # user specific data block
    has xmlStructuredErrorFunc $.error; # the callback in case of errors
    has xmlError $.lastError; # the last error
    has xmlNode $.debugNode; # the source node XSLT dictionary
    has xmlDict $.dict; # dictionary if any
    has int32 $.flags; # flags to control compilation Cache for reusal of XPath objects
    has Pointer $.cache;
    method xmlXPathContextSetCache(int32 $active, int32 $value, int32 $options --> int32) is native(LIB) {*};
    method xmlXPathCtxtCompile(xmlCharP $str --> xmlXPathCompExpr) is native(LIB) {*};
    method xmlXPathEvalPredicate(xmlXPathObject $res --> int32) is native(LIB) {*};
    method xmlXPathFreeContext() is native(LIB) {*};
    method xmlXPathFunctionLookup(xmlCharP $name --> xmlXPathFunction) is native(LIB) {*};
    method xmlXPathFunctionLookupNS(xmlCharP $name, xmlCharP $ns_uri --> xmlXPathFunction) is native(LIB) {*};
    method xmlXPathNsLookup(xmlCharP $prefix --> xmlCharP) is native(LIB) {*};
    method xmlXPathRegisterAllFunctions() is native(LIB) {*};
    method xmlXPathRegisterFunc(xmlCharP $name, xmlXPathFunction $f --> int32) is native(LIB) {*};
    method xmlXPathRegisterFuncLookup(xmlXPathFuncLookupFunc $f, Pointer $funcCtxt) is native(LIB) {*};
    method xmlXPathRegisterFuncNS(xmlCharP $name, xmlCharP $ns_uri, xmlXPathFunction $f --> int32) is native(LIB) {*};
    method xmlXPathRegisterNs(xmlCharP $prefix, xmlCharP $ns_uri --> int32) is native(LIB) {*};
    method xmlXPathRegisterVariable(xmlCharP $name, xmlXPathObject $value --> int32) is native(LIB) {*};
    method xmlXPathRegisterVariableLookup(xmlXPathVariableLookupFunc $f, Pointer $data) is native(LIB) {*};
    method xmlXPathRegisterVariableNS(xmlCharP $name, xmlCharP $ns_uri, xmlXPathObject $value --> int32) is native(LIB) {*};
    method xmlXPathRegisteredFuncsCleanup() is native(LIB) {*};
    method xmlXPathRegisteredNsCleanup() is native(LIB) {*};
    method xmlXPathRegisteredVariablesCleanup() is native(LIB) {*};
    method xmlXPathVariableLookup(xmlCharP $name --> xmlXPathObject) is native(LIB) {*};
    method xmlXPathVariableLookupNS(xmlCharP $name, xmlCharP $ns_uri --> xmlXPathObject) is native(LIB) {*};
}

struct xmlXPathFunct is repr('CStruct') {
    has xmlCharP $.name; # the function name
    has xmlXPathEvalFunc $.func; # the evaluation function
}

struct xmlXPathObject is repr('CStruct') {
    has xmlXPathObjectType $.type;
    has xmlNodeSet $.nodesetval;
    has int32 $.boolval;
    has num64 $.floatval;
    has xmlCharP $.stringval;
    has Pointer $.user;
    has int32 $.index;
    has Pointer $.user2;
    has int32 $.index2;

    sub xmlXPathEval(xmlCharP $str, xmlXPathContext $ctx --> xmlXPathObject) is native(LIB) {*};
    sub xmlXPathEvalExpression(xmlCharP $str, xmlXPathContext $ctxt --> xmlXPathObject) is native(LIB) {*};
    sub xmlXPathNewBoolean(int32 $val --> xmlXPathObject) is native(LIB) {*};
    sub xmlXPathNewCString(Str $val --> xmlXPathObject) is native(LIB) {*};
    sub xmlXPathNewFloat(num64 $val --> xmlXPathObject) is native(LIB) {*};
    sub xmlXPathNewString(xmlCharP $val --> xmlXPathObject) is native(LIB) {*};
    sub xmlXPathWrapCString(Str $val --> xmlXPathObject) is native(LIB) {*};
    sub xmlXPathWrapExternal(Pointer $val --> xmlXPathObject) is native(LIB) {*};
    sub xmlXPathWrapString(xmlCharP $val --> xmlXPathObject) is native(LIB) {*};
    sub xmlXPtrEval(xmlCharP $str, xmlXPathContext $ctx --> xmlXPathObject) is native(LIB) {*};

    method xmlShellPrintXPathResult() is native(LIB) {*};
    method xmlXPathCastToBoolean( --> int32) is native(LIB) {*};
    method xmlXPathCastToNumber( --> num64) is native(LIB) {*};
    method xmlXPathCastToString( --> xmlCharP) is native(LIB) {*};
    method xmlXPathConvertBoolean( --> xmlXPathObject) is native(LIB) {*};
    method xmlXPathConvertNumber( --> xmlXPathObject) is native(LIB) {*};
    method xmlXPathConvertString( --> xmlXPathObject) is native(LIB) {*};
    method xmlXPathFreeNodeSetList() is native(LIB) {*};
    method xmlXPathFreeObject() is native(LIB) {*};
    method xmlXPathObjectCopy( --> xmlXPathObject) is native(LIB) {*};
    method xmlXPtrBuildNodeList( --> xmlNode) is native(LIB) {*};
    method xmlXPtrLocationSetCreate( --> xmlLocationSet) is native(LIB) {*};
    method xmlXPtrNewRangePointNode(xmlNode $end --> xmlXPathObject) is native(LIB) {*};
    method xmlXPtrNewRangePoints(xmlXPathObject $end --> xmlXPathObject) is native(LIB) {*};
}

struct xmlXPathParserContext is repr('CStruct') {
    has xmlCharP $.cur; # the current char being parsed
    has xmlCharP $.base; # the full expression
    has int32 $.error; # error code
    has xmlXPathContext $.context; # the evaluation context
    has xmlXPathObject $.value; # the current value
    has int32 $.valueNr; # number of values stacked
    has int32 $.valueMax; # max number of values stacked
    has xmlXPathObjectPtr * $.valueTab; # stack of values
    has xmlXPathCompExpr $.comp; # the precompiled expression
    has int32 $.xptr; # it this an XPointer expression
    has xmlNode $.ancestor; # used for walking preceding axis
    has int32 $.valueFrame; # used to limit Pop on the stack

    sub xmlXPathNewParserContext(xmlCharP $str, xmlXPathContext $ctxt --> xmlXPathParserContext) is native(LIB) {*};

    method valuePop( --> xmlXPathObject) is native(LIB) {*};
    method valuePush(xmlXPathObject $value --> int32) is native(LIB) {*};
    method xmlXPathAddValues() is native(LIB) {*};
    method xmlXPathBooleanFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathCeilingFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathCompareValues(int32 $inf, int32 $strict --> int32) is native(LIB) {*};
    method xmlXPathConcatFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathContainsFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathCountFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathDivValues() is native(LIB) {*};
    method xmlXPathEqualValues( --> int32) is native(LIB) {*};
    method xmlXPathErr(int32 $error) is native(LIB) {*};
    method xmlXPathEvalExpr() is native(LIB) {*};
    method xmlXPathEvaluatePredicateResult(xmlXPathObject $res --> int32) is native(LIB) {*};
    method xmlXPathFalseFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathFloorFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathFreeParserContext() is native(LIB) {*};
    method xmlXPathIdFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathLangFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathLastFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathLocalNameFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathModValues() is native(LIB) {*};
    method xmlXPathMultValues() is native(LIB) {*};
    method xmlXPathNamespaceURIFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathNextAncestor(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNextAncestorOrSelf(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNextAttribute(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNextChild(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNextDescendant(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNextDescendantOrSelf(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNextFollowing(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNextFollowingSibling(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNextNamespace(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNextParent(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNextPreceding(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNextPrecedingSibling(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNextSelf(xmlNode $cur --> xmlNode) is native(LIB) {*};
    method xmlXPathNormalizeFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathNotEqualValues( --> int32) is native(LIB) {*};
    method xmlXPathNotFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathNumberFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathParseNCName( --> xmlCharP) is native(LIB) {*};
    method xmlXPathParseName( --> xmlCharP) is native(LIB) {*};
    method xmlXPathPopBoolean( --> int32) is native(LIB) {*};
    method xmlXPathPopExternal( --> Pointer) is native(LIB) {*};
    method xmlXPathPopNodeSet( --> xmlNodeSet) is native(LIB) {*};
    method xmlXPathPopNumber( --> num64) is native(LIB) {*};
    method xmlXPathPopString( --> xmlCharP) is native(LIB) {*};
    method xmlXPathPositionFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathRoot() is native(LIB) {*};
    method xmlXPathRoundFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathStartsWithFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathStringFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathStringLengthFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathSubValues() is native(LIB) {*};
    method xmlXPathSubstringAfterFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathSubstringBeforeFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathSubstringFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathSumFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathTranslateFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathTrueFunction(int32 $nargs) is native(LIB) {*};
    method xmlXPathValueFlipSign() is native(LIB) {*};
    method xmlXPatherror(Str $file, int32 $line, int32 $no) is native(LIB) {*};
    method xmlXPtrEvalRangePredicate() is native(LIB) {*};
    method xmlXPtrRangeToFunction(int32 $nargs) is native(LIB) {*};
}

struct xmlXPathType is repr('CStruct') {
    has xmlCharP $.name; # the type name
    has xmlXPathConvertFunc $.func; # the conversion function
}

struct xmlXPathVariable is repr('CStruct') {
    has xmlCharP $.name; # the variable name
    has xmlXPathObject $.value; # the value
}

sub xmlXPathCastBooleanToNumber(int32 $val --> num64) is native(LIB) {*};
sub xmlXPathCastBooleanToString(int32 $val --> xmlCharP) is native(LIB) {*};
sub xmlXPathCastNumberToBoolean(num64 $val --> int32) is native(LIB) {*};
sub xmlXPathCastNumberToString(num64 $val --> xmlCharP) is native(LIB) {*};
sub xmlXPathCastStringToBoolean(xmlCharP $val --> int32) is native(LIB) {*};
sub xmlXPathCastStringToNumber(xmlCharP $val --> num64) is native(LIB) {*};
sub xmlXPathInit() is native(LIB) {*};
sub xmlXPathIsInf(num64 $val --> int32) is native(LIB) {*};
sub xmlXPathIsNaN(num64 $val --> int32) is native(LIB) {*};
