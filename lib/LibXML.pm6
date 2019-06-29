use v6;
use LibXML::Parser;
use LibXML::Config;

# Preload stuff to avoid some Rakudo buglets
use LibXML::Attr;
use LibXML::CDATASection;
use LibXML::Comment;
use LibXML::Document;
use LibXML::DocumentFragment;
use LibXML::Element;
use LibXML::Text;
use LibXML::Native;
use LibXML::Node::Set;
use LibXML::Node::List;
use LibXML::XPath::Object;

unit class LibXML
    is LibXML::Parser;

method parser-version {
    state $version //= Version.new(xmlParserVersion.match(/^ (.) (..) (..) /).join: '.');
}

method have-reader {
    require LibXML::Reader;
    LibXML::Reader.have-reader
}

method have-schemas {
    given $.parser-version {
        $_ >= v2.05.10 && $_ !=  v2.09.04
    }
}

method config handles <skip-xml-declaration skip-dtd keep-blanks-default tag-expansion> {
    LibXML::Config;
}

method createDocument(|c) {
    LibXML::Document.createDocument(|c);
}

=begin pod

=head1 NAME

LibXML - Perl 6 bindings to the libxml2 native library

=head1 SYNOPSIS

  use LibXML;
  use LibXML::Document;
  my LibXML::Document $doc =  LibXML.parse: :string('<Hello/>');
  $doc.root.nodeValue = 'World!';
  say $doc.Str;
  # <?xml version="1.0" encoding="UTF-8"?>
  # <Hello>World!</Hello>

=head1 DESCRIPTION

** Under Construction **

This module implements Perl 6 bindings to the Gnome libxml2 library
which provides functions for parsing and manipulating XML files.

=head1 SEE ALSO

Draft documents (So far)

=item [LibXML::Attr](https://github.com/p6-pdf/LibXML-p6/blob/master/doc/Attr.md) - LibXML DOM attribute class

=item [LibXML::CDATASection](https://github.com/p6-pdf/LibXML-p6/blob/master/doc/Attr.md) - LibXML class for DOM CDATA sections

=item [LibXML::Comment](https://github.com/p6-pdf/LibXML-p6/blob/master/doc/Comment.md) - LibXML class for comment DOM nodes

=item [LibXML::Document](https://github.com/p6-pdf/LibXML-p6/blob/master/doc/Document.md) - LibXML's DOM L2 Document Fragment implementation

=item [LibXML::DocumentFragment](https://github.com/p6-pdf/LibXML-p6/blob/master/doc/DocumentFragment.md) - LibXML DOM attribute class

=item [LibXML::Dtd](https://github.com/p6-pdf/LibXML-p6/blob/master/doc/Dtd.md) - LibXML frontend for DTD validation

=item [LibXML::Element](https://github.com/p6-pdf/LibXML-p6/blob/master/doc/Element.md) - LibXML class for DOM element nodes

=item [LibXML::Namespace](https://github.com/p6-pdf/LibXML-p6/blob/master/doc/Namespace.md) - LibXML DOM namespace nodes

=item [LibXML::PI](https://github.com/p6-pdf/LibXML-p6/blob/master/doc/PI.md) - LibXML DOM processing instruction nodes

=item [LibXML::RegExp](https://github.com/p6-pdf/LibXML-p6/blob/master/doc/RegExp.md) - LibXML Regular Expression bindings

=end pod
