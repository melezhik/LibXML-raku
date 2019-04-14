use v6;
use Test;
plan 54;

use LibXML;
use LibXML::Enums;

my $htmlPublic = "-//W3C//DTD XHTML 1.0 Transitional//EN";
my $htmlSystem = "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd";

{
    my $doc = LibXML::Document.new;
    my $dtd = $doc.createExternalSubset( "html",
                                          $htmlPublic,
                                          $htmlSystem
                                        );
    # TEST
    ok( $dtd.isSameNode(  $doc.externalSubset ), ' TODO : Add test name' );
    # TEST
    is( $dtd.publicId, $htmlPublic, ' TODO : Add test name' );
    # TEST
    is( $dtd.systemId, $htmlSystem, ' TODO : Add test name' );
    # TEST
    is( $dtd.name, 'html', ' TODO : Add test name' );
}

{
    my $doc = LibXML::Document.new;
    my $dtd = $doc.createInternalSubset( "html",
                                          $htmlPublic,
                                          $htmlSystem
                                        );
    # TEST
    ok( $dtd.isSameNode( $doc.internalSubset ), ' TODO : Add test name' );

    $doc.setExternalSubset( $dtd );
    # TEST
    ok(!defined($doc.internalSubset), ' TODO : Add test name' );
    # TEST
    ok( $dtd.isSameNode( $doc.externalSubset ), ' TODO : Add test name' );

    # TEST

    is( $dtd.getPublicId, $htmlPublic, ' TODO : Add test name' );
    # TEST
    is( $dtd.getSystemId, $htmlSystem, ' TODO : Add test name' );

    $doc.setInternalSubset( $dtd );
    # TEST
    ok(!defined($doc.externalSubset), ' TODO : Add test name' );
    # TEST
    ok( $dtd.isSameNode( $doc.internalSubset ), ' TODO : Add test name' );

    my $dtd2 = $doc.createDTD( "huhu",
                                "-//W3C//DTD XHTML 1.0 Transitional//EN",
                                "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
                              );

    $doc.setInternalSubset( $dtd2 );
    # TEST
    ok( !defined($dtd.parentNode), ' TODO : Add test name' );
    # TEST
    ok( $dtd2.isSameNode( $doc.internalSubset ), ' TODO : Add test name' );


    my $dtd3 = $doc.removeInternalSubset;
    # TEST
    ok( $dtd3.isSameNode($dtd2), ' TODO : Add test name' );
    # TEST
    ok( !defined($doc.internalSubset), ' TODO : Add test name' );

    $doc.setExternalSubset( $dtd2 );

    $dtd3 = $doc.removeExternalSubset;
    # TEST
    ok( $dtd3.isSameNode($dtd2), ' TODO : Add test name' );
    # TEST
    ok( !defined($doc.externalSubset), ' TODO : Add test name' );
}

{
    my $parser = LibXML.new();

    my $doc = $parser.parse: :file( "example/dtd.xml" );

    # TEST

    ok($doc, ' TODO : Add test name');

    my $dtd = $doc.internalSubset;
    # TEST
    is( $dtd.name, 'doc', ' TODO : Add test name' );
    # TEST
    is( $dtd.publicId, Str, ' TODO : Add test name' );
    # TEST
    is( $dtd.systemId, Str, ' TODO : Add test name' );

    my $entity = $doc.createEntityReference( "foo" );
    # TEST
    ok($entity, ' TODO : Add test name');
    # TEST
    is($entity.nodeType, +XML_ENTITY_REF_NODE, ' TODO : Add test name' );

    # TEST

    ok( $entity.hasChildNodes, ' TODO : Add test name' );
    # TEST
    # We don't have explicit EntityDecl or ElementDecl classes yet
    is( $entity.firstChild.nodeType, +XML_ENTITY_DECL, ' TODO : Add test name' );
    # TEST
    is( $entity.firstChild.nodeValue, " test ", ' TODO : Add test name' );

    my $edcl = $entity.firstChild;
    # TEST
    is( $edcl.previousSibling.nodeType, +XML_ELEMENT_DECL, ' TODO : Add test name' );

    {
        my $doc2  = LibXML::Document.new;
        my $e = $doc2.createElement("foo");
        $doc2.setDocumentElement( $e );

        my $dtd2 = $doc.internalSubset.cloneNode(1);
        # TEST
        ok($dtd2, ' TODO : Add test name');

#        $doc2.setInternalSubset( $dtd2 );
#        warn $doc2.Str;

#        $e.appendChild( $entity );
#        warn $doc2.Str;
    }
}

{
    my $parser = LibXML.new();
    $parser.validation = True;
    $parser.keep-blanks = True;
    my $doc=$parser.parse: :string(q:to<EOF>);
<?xml version='1.0'?>
<!DOCTYPE test [
 <!ELEMENT test (#PCDATA)>
]>
<test>
</test>
EOF

    # TEST
    ok($doc.validate(), ' TODO : Add test name');

    # TEST
    ok($doc.is-valid(), ' TODO : Add test name');

}

{
    my $parser = LibXML.new();
    $parser.validation = False;
    $parser.load-ext-dtd = False; # This should make libxml not try to get the DTD

    my $xml = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://localhost/does_not_exist.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml"><head><title>foo</title></head><body><p>bar</p></body></html>';
    my $doc;
    lives-ok {
        $doc = $parser.parse: :string($xml);
    }, ' TODO : Add test name';

    # TEST
    ok($doc.defined, ' TODO : Add test name');
}

{
    my $bad = 'example/bad.dtd';
    # TEST
    ok($bad.IO.f, ' TODO : Add test name' );
    dies-ok {
        LibXML::Dtd.parse("-//Foo//Test DTD 1.0//EN", $bad);
    }, ' TODO : Add test name';

    my $dtd = $bad.IO.slurp;

    # TEST
    warn $dtd;
    ok( $dtd.chars > 5, ' TODO : Add test name' );
    todo "not dying";
    dies-ok { LibXML::Dtd.parse: :string($dtd); }, 'Parse fails for bad.dtd';

    my $xml = "<!DOCTYPE test SYSTEM \"example/bad.dtd\">\n<test/>";

    {
        my $parser = LibXML.new;
        $parser.load-ext-dtd = False;
        $parser.validation = False;
        my $doc = $parser.parse: :string($xml);
        # TEST
        ok( $doc, ' TODO : Add test name' );
    }
    {
        my $parser = LibXML.new;
        $parser.load-ext-dtd = True;
        $parser.validation = False;
        dies-ok { $parser.parse: :string($xml) }, ' TODO : Add test name';
    }
}

{
    # RT #71076: https://rt.cpan.org/Public/Bug/Display.html?id=71076

    my $parser = LibXML.new();
    my $doc = $parser.parse: :string(q:to<EOF>);
<!DOCTYPE test [
 <!ELEMENT test (#PCDATA)>
 <!ATTLIST test
  attr CDATA #IMPLIED
 >
]>
<test>
</test>
EOF
    my $dtd = $doc.internalSubset;

    # TEST
    ok( !$dtd.hasAttributes, 'hasAttributes' );
    # TEST
    dies-ok { $dtd.attributes }, 'attributes N/A to DTD nodes';
}

# Remove DTD nodes

sub test_remove_dtd {
    my ($test_name, &remove_sub) = @_;

    my $parser = LibXML.new;
    my $doc    = $parser.parse: :file('example/dtd.xml');
    my $dtd    = $doc.internalSubset;

    remove_sub($doc, $dtd);

    # TEST*3
    ok( !$doc.internalSubset, "remove DTD via $test_name" );
}

test_remove_dtd( "unbindNode", sub {
    my ($doc, $dtd) = @_;
    $dtd.unbindNode;
} );
test_remove_dtd( "removeChild", sub {
    my ($doc, $dtd) = @_;
    $doc.removeChild($dtd);
} );
test_remove_dtd( "removeChildNodes", sub {
    my ($doc, $dtd) = @_;
    $doc.removeChildNodes;
} );

# Insert DTD nodes

sub test_insert_dtd {
    my ($test_name, &insert_sub) = @_;

    my $parser  = LibXML.new;
    my $src_doc = $parser.parse: :file('example/dtd.xml');
    my $dtd     = $src_doc.internalSubset;
    my $doc     = $parser.parse: :file('example/dtd.xml');

    insert_sub($doc, $dtd);

    # TEST*11
    ok( $doc.internalSubset.isSameNode($dtd), "insert DTD via $test_name" );
}

test_insert_dtd( "insertBefore internalSubset", sub {
    my ($doc, $dtd) = @_;
    $doc.insertBefore($dtd, $doc.internalSubset);
} );
test_insert_dtd( "insertBefore documentElement", sub {
    my ($doc, $dtd) = @_;
    $doc.insertBefore($dtd, $doc.documentElement);
} );
test_insert_dtd( "insertAfter internalSubset", sub {
    my ($doc, $dtd) = @_;
    $doc.insertAfter($dtd, $doc.internalSubset);
} );
test_insert_dtd( "insertAfter documentElement", sub {
    my ($doc, $dtd) = @_;
    $doc.insertAfter($dtd, $doc.documentElement);
} );
test_insert_dtd( "replaceChild internalSubset", sub {
    my ($doc, $dtd) = @_;
    $doc.replaceChild($dtd, $doc.internalSubset);
} );
test_insert_dtd( "replaceChild documentElement", sub {
    my ($doc, $dtd) = @_;
    $doc.replaceChild($dtd, $doc.documentElement);
} );
test_insert_dtd( "replaceNode internalSubset", sub {
    my ($doc, $dtd) = @_;
    $doc.internalSubset.replaceNode($dtd);
} );
test_insert_dtd( "replaceNode documentElement", sub {
    my ($doc, $dtd) = @_;
    $doc.documentElement.replaceNode($dtd);
} );
test_insert_dtd( "appendChild", sub {
    my ($doc, $dtd) = @_;
    $doc.appendChild($dtd);
} );
test_insert_dtd( "addSibling internalSubset", sub {
    my ($doc, $dtd) = @_;
    $doc.internalSubset.addSibling($dtd);
} );
test_insert_dtd( "addSibling documentElement", sub {
    my ($doc, $dtd) = @_;
    $doc.documentElement.addSibling($dtd);
} );

