use v6;
use Test;
use LibXML::HashMap;
use LibXML::Element;
use LibXML::XPath::Object :XPathDomain;
use NativeCall;

plan 2;

subtest 'node-hash' => {
    plan 4;
    my LibXML::HashMap[LibXML::Element] $elems .= new;

    for 1 .. 5 {
        $elems{'e'~$_} .= new('Elem' ~ $_);
    }

    is-deeply [$elems.keys.sort], [(1..5).map('e'~*)], 'keys';
    is-deeply [$elems.values.map(*.Str).sort], [(1..5).map({'<Elem'~$_~'/>'})], 'values';

    skip 'hash updates', 2;
    #$elems<e5>:delete;
    #ok ($elems<e5>:!exists), 'deleted element';
    #$elems<e4> .= new('Replaced');
    #is $elems<e4>.Str, '<Replaced/>', 'replaced element';
}

skip 'object hashes';
sub {
##subtest 'object-hash' => {
    plan 20;

    my LibXML::HashMap[LibXML::XPath::Object] $h .= new;
    is-deeply $h.of, XPathDomain;
    is $h.elems, 0;
    lives-ok { $h<Xx> = 'Hi';};
    is $h.elems, 1;
    is $h<Xx>, 'Hi';
    is-deeply $h<Yy>, XPathDomain;
    lives-ok {$h<Xx> = 'Again'};
    is $h.elems, 1;
    is $h<Xx>, 'Again';
    $h<Xx>:delete;
    is $h<Xx>, XPathDomain;
    is $h.elems, 0;
    $h<Xx> = 42;
    is-deeply $h<Xx>, 42e0;
    is-deeply $h<Xx>, 42e0;
    $h<yy> = "xx";

    is-deeply $h.keys.sort, ("Xx", "yy");
    is-deeply $h.values.sort, (42e0, "xx");
    is-deeply $h.pairs.sort, (Xx => 42e0, yy => "xx");

    my LibXML::Element $node .= new('test');

    lives-ok {$h<elems> = $node;};
    is-deeply $h.keys.sort, ("Xx", "elems", "yy");
    ok $node.isSame($h<elems>[0]);
    todo 'refetch of node';
    lives-ok { $h<elems>[0]; };
}

done-testing;
