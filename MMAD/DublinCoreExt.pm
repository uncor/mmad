package MMAD::DublinCoreExt;

use Modern::Perl;

use base 'Exporter';

use Switch;
use Encode;
use YAML;

our @EXPORT = (
	qw( generate_dc
		lang)
);

sub generate_dc {

	my ($row) = @_;

	my $config   	= YAML::LoadFile( 'config.yaml' );
	my $rights 		= $config->{cc}; 
	my $rights_uri 	= $config->{cc_uri};

	my $title       = $row->{'previousIdentifications'}; # agregar dc.title
    my $abstract    = $row->{'locality'};
    my $collector   = $row->{'recordedBy'}; # dc.contributor.author
    my $cataloger   = $row->{'identifiedBy'}; # dc.contributor.author
    my $loc         = $row->{'higherGeography'}; # dc.coverage.spacial
    my $order       = $row->{'orders'}; # dc.subject
    my $family      = $row->{'family'}; # dc.subject
    my $name        = $row->{'scientificName'}; # dc.subject
	my $uri			= $row->{'uri'}; #dc.identifier.uri
    
    # Date

    my $year        = $row->{'years'};
    my $month       = $row->{'months'};
    my $day         = $row->{'days'};
    
    # Subject

    my $subject     = $order . "; " . $family . "; " . $name;

    # Add
    
    my $fil1        = 'Universidad Nacional de Cordoba. Facultad de Ciencias Exactas, Fisicas y Naturales';
    my $fil2        = 'Consejo Nacional de Investigaciones Cientificas y Tecnicas. Instituto Multidisciplinario de Biologia Vegetal';    
    my $publisher   = $fil1 . "; " . $fil2;   

    my $type        = 'stillImage';
    my $version     = 'publishedVersion';
    
    my $language    = 'spa';
	my $lang        = lang($language);

	# Dublin Core XML

	my $dc = XML::Writer->new(
		OUTPUT      => 'self',
		DATA_MODE   => 1,
		DATA_INDENT => 2,
	);

	$dc->xmlDecl( 'UTF-8', 'no' );
	$dc->startTag( 'dublin_core', schema => 'dc' );

	# Abstract

	$dc->startTag( 'dcvalue', element   => 'description', qualifier => 'abstract', language  => $lang );
	$dc->characters($abstract);
	$dc->endTag('dcvalue');

	# Creative Commons (License)

	$dc->startTag( 'dcvalue', element => 'rights', qualifier => 'none', language => '*' );
	$dc->characters($rights);
	$dc->endTag;

	$dc->startTag( 'dcvalue', element => 'rights', qualifier => 'uri', language => '*' );
	$dc->characters($rights_uri);
	$dc->endTag;

	# Creator

	$dc->startTag( 'dcvalue', element => 'contributor', qualifier => 'author', language => '' );
	$dc->characters($collector . " [Collector]; " . $cataloger . " [Cataloger]");
	$dc->endTag('dcvalue');

	# Date

	$dc->startTag( 'dcvalue', element => 'date', qualifier => 'issued', language => '' );
	$dc->characters($year . "-" . $month . "-" . $day);
	$dc->endTag('dcvalue');

	# Identifier URI

	$dc->startTag( 'dcvalue', element => 'identifier', qualifier => 'uri', language => '' );
	$dc->characters($uri);
	$dc->endTag('dcvalue');

	# Language

	$dc->startTag( 'dcvalue', element => 'language', qualifier => 'iso', language => $lang );
	$dc->characters($language);
	$dc->endTag('dcvalue');

	# Publisher

	$dc->startTag( 'dcvalue', element => 'publisher', qualifier => 'none', language => '' );
	$dc->characters( $publisher );
	$dc->endTag('dcvalue');

	# Subject

	$dc->startTag( 'dcvalue', element => 'subject', qualifier => 'none', language => $lang );
	$dc->characters($subject);
	$dc->endTag('dcvalue');

	# Title

	$dc->startTag( 'dcvalue', element => 'title', qualifier => 'none', language => $lang );
	$dc->characters($title);
	$dc->endTag('dcvalue');

	# Type

	$dc->startTag( 'dcvalue', element => 'type', qualifier => 'none', language => $lang );
	$dc->characters($type);
	$dc->endTag('dcvalue');

	# Version

	$dc->startTag( 'dcvalue', element => 'description', qualifier => 'version', language => '' );
	$dc->characters($version);
	$dc->endTag('dcvalue');

	$dc->endTag('dublin_core');

	my $xml = $dc->end();

	return $xml;
}

sub lang {

	my ($lang) = @_;

	my $value;

	switch ($lang) {

		case "spa"	{ $value = "es" }
		case "eng" 	{ $value = "en" }
		else 	   	{ $value = "undefined" }
	}

	return $value;

}

1;
