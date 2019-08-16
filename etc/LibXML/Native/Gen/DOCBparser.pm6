use v6;
#  -- DO NOT EDIT --
# generated by: etc/generator.p6 

unit module LibXML::Native::Gen::DOCBparser;
# old DocBook SGML parser:
#    interface for a DocBook SGML non-verifying parser This code is DEPRECATED, and should not be used anymore. 
use LibXML::Native::Defs :LIB, :XmlCharP;

sub docbCreateFileParserCtxt(Str $filename, Str $encoding --> docbParserCtxt) is native(LIB) {*};
sub docbCreatePushParserCtxt(docbSAXHandler $sax, Pointer $user_data, Str $chunk, int32 $size, Str $filename, xmlCharEncoding $enc --> docbParserCtxt) is native(LIB) {*};
sub docbEncodeEntities(unsigned char * $out, Pointer[int32] $outlen, const unsigned char * $in, Pointer[int32] $inlen, int32 $quoteChar --> int32) is native(LIB) {*};
sub docbFreeParserCtxt(docbParserCtxt $ctxt) is native(LIB) {*};
sub docbParseChunk(docbParserCtxt $ctxt, Str $chunk, int32 $size, int32 $terminate --> int32) is native(LIB) {*};
sub docbParseDoc(xmlCharP $cur, Str $encoding --> docbDoc) is native(LIB) {*};
sub docbParseDocument(docbParserCtxt $ctxt --> int32) is native(LIB) {*};
sub docbParseFile(Str $filename, Str $encoding --> docbDoc) is native(LIB) {*};
sub docbSAXParseDoc(xmlCharP $cur, Str $encoding, docbSAXHandler $sax, Pointer $userData --> docbDoc) is native(LIB) {*};
sub docbSAXParseFile(Str $filename, Str $encoding, docbSAXHandler $sax, Pointer $userData --> docbDoc) is native(LIB) {*};
