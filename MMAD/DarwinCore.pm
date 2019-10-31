package MMAD::DarwinCore;

use Modern::Perl;

use base 'Exporter';

use Switch;
use Encode;
use YAML;

our @EXPORT = (
	qw( generate_dwc
		lang)
);

sub generate_dwc {

	my ($row) = @_;

	my $family      = $row->{'family'}; 
    my $catalogNum  = $row->{'catalogNumber'}; 
    
    my $language   = 'spa';
   	my $lang = lang($language);

	# Dublin Core XML

	my $dwc = XML::Writer->new(
		OUTPUT      => 'self',
		DATA_MODE   => 1,
		DATA_INDENT => 2,
	);

	$dwc->xmlDecl( 'UTF-8', 'no' );
	$dwc->startTag( 'dublin_core', schema => 'dwc' );

	# family

	$dwc->startTag( 'dcvalue', element   => 'family', qualifier => '', language  => $lang );
	$dwc->characters($family);
	$dwc->endTag('dcvalue');

	# catalogNumber

	$dwc->startTag( 'dcvalue', element => 'catalogNumber', qualifier => '', language => $lang );
	$dwc->characters($catalogNum);
	$dwc->endTag('dcvalue');

	$dwc->endTag('dublin_core');

	my $xml = $dwc->end();

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
