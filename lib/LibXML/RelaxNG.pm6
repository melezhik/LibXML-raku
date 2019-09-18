use v6;

unit class LibXML::RelaxNG;

use LibXML::Document;
use LibXML::ErrorHandler :&structured-error-cb;
use LibXML::Native;
use LibXML::Native::RelaxNG;
use LibXML::Parser::Context;
has xmlRelaxNG $.native;

my class Parser::Context {
    has xmlRelaxNGParserCtxt $!native;
    has LibXML::ErrorHandler $!errors handles<generic-error structured-error flush-errors> .= new;
    has Blob $!buf;

    multi submethod BUILD( xmlRelaxNGParserCtxt:D :$!native! ) {
    }
    multi submethod BUILD(Str:D :$url!) {
        $!native .= new: :$url;
    }
    multi submethod BUILD(Str:D :location($url)!) {
        self.BUILD: :$url;
    }
    multi submethod BUILD(Blob:D :$!buf!) {
        $!native .= new: :$!buf;
    }
    multi submethod BUILD(Str:D :$string!) {
        self.BUILD: :buf($string.encode);
    }
    multi submethod BUILD(LibXML::Document:D :doc($_)!) {
        my xmlDoc:D $doc = .native;
        $!native .= new: :$doc;
    }

    submethod TWEAK {
        $!native.SetStructuredErrorFunc: &structured-error-cb;
    }

    submethod DESTROY {
        $!buf = Nil;
        .Free with $!native;
    }

    method parse {
        my $*XML-CONTEXT = self;
        my $rv := $!native.Parse;
        self.flush-errors;
        $rv;
    }

}

my class ValidContext {
    has xmlRelaxNGValidCtxt $!native;
    has LibXML::ErrorHandler $!errors handles<generic-error structured-error flush-errors> .= new;

    multi submethod BUILD( xmlRelaxNGValidCtxt:D :$!native! ) { }
    multi submethod BUILD( LibXML::RelaxNG:D :schema($_)! ) {
        my xmlRelaxNG:D $schema = .native;
        $!native .= new: :$schema;
    }

    submethod TWEAK {
        $!native.SetStructuredErrorFunc: &structured-error-cb;
    }

    submethod DESTROY {
        .Free with $!native;
    }

    method validate(LibXML::Document:D $_, Bool() :$check) {
        my $*XML-CONTEXT = self;
        my xmlDoc:D $doc = .native;
        my $rv := $!native.ValidateDoc($doc);
	$rv := $!errors.is-valid
            if $check;
        self.flush-errors;
        $rv;
    }

    method is-valid(LibXML::Document:D $_) {
        self.validate($_, :check);
    }

}

submethod TWEAK(|c) {
    my Parser::Context:D $parser-ctx .= new: |c;
    $!native = $parser-ctx.parse;
}

submethod DESTROY {
    .Free with $!native;
}

method !valid-ctx { ValidContext.new: :schema(self) }
method validate(LibXML::Document:D $doc) {
    self!valid-ctx.validate($doc);
}
method is-valid(LibXML::Document:D $doc) {
    self!valid-ctx.is-valid($doc);
}

=begin pod
=head1 NAME

LibXML::RelaxNG - RelaxNG Schema Validation

=head1 SYNOPSIS


  use LibXML::Schema;
  use LibXML;

  my $doc = LibXML.new.parse: :file($url);

  my LibXML::RelaxNG $rngschema .= new( location => $filename_or_url );
  my LibXML::RelaxNG $rngschema .= new( string => $xmlschemastring );
  my LibXML::RelaxNG $rngschema .= new( :$doc );
  try { $rngschema.validate( $doc ); };
  if  $rngschema.is-valid( $doc ) {...}

=head1 DESCRIPTION

The LibXML::RelaxNG class is a tiny frontend to libxml2's RelaxNG
implementation. Currently it supports only schema parsing and document
validation.


=head1 METHODS

=begin item1
new

  my LibXML::RelaxNG $rngschema .= new( location => $filename_or_url );
  my LibXML::RelaxNG $rngschema .= new( string => $xmlschemastring );
  my LibXML::RelaxNG $rngschema .= new( :$doc );

The constructor of LibXML::RelaxNG may get called with either one of three
parameters. The parameter tells the class from which source it should generate
a validation schema. It is important, that each schema only have a single
source.

The location parameter allows one to parse a schema from the filesystem or a
URL.

The string parameter will parse the schema from the given XML string.

The DOM parameter allows one to parse the schema from a pre-parsed L<<<<<< LibXML::Document >>>>>>.

Note that the constructor will die() if the schema does not meed the
constraints of the RelaxNG specification.

=end item1

=begin item1
validate

  try { $rngschema->validate( $doc ); };

This function allows one to validate a (parsed) document against the given
RelaxNG schema. The argument of this function should be an LibXML::Document
object. If this function succeeds, it will return True, otherwise it will throw,
reporting the found. Because of this validate() should be always be execute in
a `try` block or in the scope of a `CATCH` block.

=end item1

=begin item1
is-valid

  my Bool $valid = $rngschema.is-valid($doc);

Returns either True or False depending on whether the passed Document is valid or not.

=end item1

=head1 COPYRIGHT

2001-2007, AxKit.com Ltd.

2002-2006, Christian Glahn.

2006-2009, Petr Pajas.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=end pod
