package MMAD::DublinCore;

use Modern::Perl;

use base 'Exporter';

use Switch;
use Encode;
use YAML;

our @EXPORT = (
	qw( generate_xml
		lang
		lang2
		types
		check_status
		check_role)
);

sub generate_xml {

	my ($row) = @_;

	my $config   	= YAML::LoadFile( 'config.yaml' );
	my $rights 		= $config->{cc}; 
	my $rights_uri 	= $config->{cc_uri};

	my $id             		= $row->{'id'};
	my $title          		= $row->{'titulo'};
	my $abstract            = $row->{'resumen'};
	my $creator  			= $row->{'autores'};
	my $subject  			= $row->{'palabras_clave'}; 
	my $language       		= $row->{'idioma'};
	my $type           		= $row->{'tipo_produccion'};
	my $date           		= $row->{'anio'};
	my $link           		= $row->{'link_archivo_fulltext'};
	my $academic_grade 		= $row->{'grado_academico'};
	my $url            		= $row->{'web'};
	my $editorial	   		= $row->{'editorial'};
	my $disciplinary_field  = $row->{'area'};
	my $support 			= $row->{'medios_difusion'};

	my $version;
	my $ref;
	my $r;

	my $referato = check_referato($row);

	#my $desc = "Fil: " . $creator . ". Universidad Nacional de Cordoba. " . $description . ". Cordoba. Argentina.";

	# Check status
	
	if($type eq('Articulo')){
		
		my $status = $row->{'Estado'};
		
		$version = check_status($status);
		
	}
	else{
		
		$version = 'publishedVersion';
	
	}

	# Check role & referato

	if( $type eq('Libro') | $type eq('Capitulo de Libro')){
		
		$r = check_role($row);
	
	}
	
	# Encode language

	my $l = encode( "utf-8", $language );

	my $lang = lang($l);

	# Transformers

	my $t = types($type);

	my $lang2 = lang2($lang);

	# Dublin Core XML

	my $dc = XML::Writer->new(
		OUTPUT      => 'self',
		DATA_MODE   => 1,
		DATA_INDENT => 2,
	);

	$dc->xmlDecl( 'UTF-8', 'no' );
	$dc->startTag( 'dublin_core', schema => 'dc' );

	# Abstract

	$dc->startTag( 'dcvalue', element   => 'description', qualifier => 'abstract', language  => $lang2 );
	$dc->characters(StripNonXmlChars($abstract));
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
	$dc->characters(StripNonXmlChars($creator));
	$dc->endTag('dcvalue');

	# Date

	$dc->startTag( 'dcvalue', element => 'date', qualifier => 'issued', language => '' );
	$dc->characters($date);
	$dc->endTag('dcvalue');

	# Filiation

	# $dc->startTag( 'dcvalue', element => 'description', qualifier => 'fil', language => $lang2 );
	# $dc->characters($desc);
	# $dc->endTag('dcvalue');

	# Language

	$dc->startTag( 'dcvalue', element => 'language', qualifier => 'iso', language => $lang2 );
	$dc->characters($lang);
	$dc->endTag('dcvalue');

	# Publisher

	$dc->startTag( 'dcvalue', element => 'publisher', qualifier => 'none', language => '' );
	$dc->characters( my $publisher );
	$dc->endTag('dcvalue');

	# Subject

	$dc->startTag( 'dcvalue', element => 'subject', qualifier => 'none', language => $lang2 );
	$dc->characters(StripNonXmlChars($subject));
	$dc->endTag('dcvalue');

	# Title

	$dc->startTag( 'dcvalue', element => 'title', qualifier => 'none', language => $lang2 );
	$dc->characters(StripNonXmlChars($title));
	$dc->endTag('dcvalue');

	# Type

	$dc->startTag( 'dcvalue', element => 'type', qualifier => 'none', language => $lang2 );
	$dc->characters($t);
	$dc->endTag('dcvalue');

	# Version

	$dc->startTag( 'dcvalue', element => 'description', qualifier => 'version', language => '' );
	$dc->characters($version);
	$dc->endTag('dcvalue');

	# URL

	$dc->startTag( 'dcvalue', element => 'description', qualifier => 'uri', language => '' );
	$dc->characters($url);
	$dc->endTag('dcvalue');

	# Referato

	$dc->startTag( 'dcvalue', element => 'journal', qualifier => 'referato', language => '' );
	$dc->characters($referato);
	$dc->endTag('dcvalue');

	# Area

	$dc->startTag( 'dcvalue', element => 'description', qualifier => 'field', language => '' );
	$dc->characters($disciplinary_field);
	$dc->endTag('dcvalue');

	# Support

	$dc->startTag( 'dcvalue', element => 'format', qualifier => 'medium', language => '' );
	$dc->characters($support);
	$dc->endTag('dcvalue');
	
	if($type eq 'Tesis'){
			
			my $lastname_advisor    = $row->{'apellido_director'};
			my $firstname_advisor	= $row->{'nombre_director'};

			my $advisor = $lastname_advisor . ", " . $firstname_advisor;

			# Advisor

			$dc->startTag( 'dcvalue', element => 'contributor', qualifier => 'advisor', language => '' );
			$dc->characters($advisor);
			$dc->endTag('dcvalue');
			
	}

	# Others

	if ( $type eq ("Articulo") ) {

		my $volume             = $row->{'Volumen_articulo'};
		my $tome               = $row->{'Tomo_articulo'};
		my $first_page         = $row->{'Pagina_inicial_articulo'};
		my $last_page          = $row->{'Pagina_final_articulo'};
		my $doi                = $row->{'DOI_articulo'};
		my $issn               = $row->{'ISSN_articulo'};
		my $eissn              = $row->{'EISSN_articulo'};
		my $country            = $row->{'pais'};
		my $city               = $row->{'ciudad'};
		my $journal			   = $row->{'revista'};

		if (!($journal)){
			$journal = $row->{'otra_revista'};
		}	
		
		my $pagination;

		if ( $first_page && $last_page ) {
			$pagination = $first_page . "-" . $last_page;
		}

		# Volume

		$dc->startTag( 'dcvalue', element => 'journal', qualifier => 'volume', language => '' );
		$dc->characters($volume);
		$dc->endTag('dcvalue');

		# Tome

		$dc->startTag( 'dcvalue', element => 'journal', qualifier => 'tome', language => '' );
		$dc->characters($tome);
		$dc->endTag('dcvalue');

		# Pagination

		$dc->startTag( 'dcvalue', element => 'journal', qualifier => 'pagination', language => '' );
		$dc->characters($pagination);
		$dc->endTag('dcvalue');

		# EISSN

		$dc->startTag( 'dcvalue', element => 'identifier', qualifier => 'eissn', language => '' );
		$dc->characters($eissn);
		$dc->endTag('dcvalue');

		# ISSN

		$dc->startTag( 'dcvalue', element => 'identifier', qualifier => 'issn', language => '' );
		$dc->characters($issn);
		$dc->endTag('dcvalue');

		# Journal

		$dc->startTag( 'dcvalue', element => 'journal', qualifier => 'title', language => '' );
		$dc->characters($journal);
		$dc->endTag('dcvalue');

		# Edition country

		$dc->startTag( 'dcvalue', element => 'journal', qualifier => 'country', language => '' );
		$dc->characters($country);
		$dc->endTag('dcvalue');

		# Edition city

		$dc->startTag( 'dcvalue', element => 'journal', qualifier => 'city', language => '' );
		$dc->characters($city);
		$dc->endTag('dcvalue');

		# DOI

		$dc->startTag( 'dcvalue', element => 'identifier', qualifier => 'uri', language => '' );
		$dc->characters($doi);
		$dc->endTag('dcvalue');

		$dc->startTag( 'dcvalue', element => 'journal', qualifier => 'editorial', language => '' );
		$dc->characters($editorial);
		$dc->endTag('dcvalue');

	}

	if ( $type eq ("Libro") ) {

		my $volumes   	= $row->{'cantidad_volumenes'};
		my $isbn        = $row->{'ISBN_Libro'};
		my $country  	= $row->{'pais'};
		my $city     	= $row->{'ciudad'};
		my $pages_libro = $row->{'total_paginas_libro_1'}; 

		# Total volumes

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'volumes', language => '' );
		$dc->characters($volumes);
		$dc->endTag('dcvalue');

		# Pages

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'pages', language => '' );
		$dc->characters($pages_libro);
		$dc->endTag('dcvalue');

		# Edition country

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'country', language => '' );
		$dc->characters($country);
		$dc->endTag('dcvalue');

		# Edition city

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'city', language => '' );
		$dc->characters($city);
		$dc->endTag('dcvalue');

		# Editorial

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'editorial', language => '' );
		$dc->characters($editorial);
		$dc->endTag('dcvalue');

		# ISBN

		$dc->startTag( 'dcvalue', element => 'identifier', qualifier => 'isbn', language => '' );
		$dc->characters($isbn);
		$dc->endTag('dcvalue');

		# Role

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'role', language => '' );
		$dc->characters($r);
		$dc->endTag('dcvalue');

	}

	if ( $type eq ("Capitulo de Libro") ) {

		my $volume      = $row->{'volumen'},
		my $number      = $row->{'numero'},
		my $first_page  = $row->{'pagina_inicial'},
		my $last_page   = $row->{'pagina_final'},
		my $isbn        = $row->{'ISBN_parte'},
		my $other_title = $row->{'titulo_libro'},
		my $tome        = $row->{'tomo'},
		my $pages       = $row->{'total_paginas_libro'},
		my $country     = $row->{'pais'},
		my $city        = $row->{'ciudad'},

	    # Alternative title

		$dc->startTag( 'dcvalue', element   => 'book', qualifier => 'title', language  => $lang2 );
		$dc->characters($other_title);
		$dc->endTag('dcvalue');

		# Volume

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'volume', language => '' );
		$dc->characters($volume);
		$dc->endTag('dcvalue');

		# Tome

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'tome', language => '' );
		$dc->characters($tome);
		$dc->endTag('dcvalue');

		# Number

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'number', language => '' );
		$dc->characters($number);
		$dc->endTag('dcvalue');

		# First page

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'firstpage', language => '' );
		$dc->characters($first_page);
		$dc->endTag('dcvalue');

		# Last page

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'lastpage', language => '' );
		$dc->characters($last_page);
		$dc->endTag('dcvalue');

		# Pages

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'pages', language => '' );
		$dc->characters($pages);
		$dc->endTag('dcvalue');

		# Edition country

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'country', language => '' );
		$dc->characters($country);
		$dc->endTag('dcvalue');

		# Edition city

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'city', language => '' );
		$dc->characters($city);
		$dc->endTag('dcvalue');

		# Editorial

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'editorial', language => '' );
		$dc->characters($editorial);
		$dc->endTag('dcvalue');

		# ISBN

		$dc->startTag( 'dcvalue', element => 'identifier', qualifier => 'isbn', language => '' );
		$dc->characters($isbn);
		$dc->endTag('dcvalue');

		# Role

		$dc->startTag( 'dcvalue', element => 'book', qualifier => 'role', language => '' );
		$dc->characters($r);
		$dc->endTag('dcvalue');

	}

	if ( $type eq ("Congreso") ) {

		my $publication_type = $row->{'tipo_publicacion'};
		my $work_type        = $row->{'tipo_trabajo'};
		my $journal          = $row->{'titulo_revista'};
		my $country          = $row->{'pais'};
		my $city             = $row->{'ciudad'};
		my $event            = $row->{'reunion_cientifica'};
		my $event_type       = $row->{'tipo_reunion'};
		my $event_country    = $row->{'pais_evento'};
		my $event_city       = $row->{'ciudad_evento'};
		my $event_year       = $row->{'anio_reunion'};
		my $event_mounth	 = $row->{'mes_reunion'};
		my $institution      = $row->{'institucion_organizadora'};
		my $issn_isbn		 = $row->{'isbn_issn'};

		# Publication type

		$dc->startTag( 'dcvalue', element   => 'conference', qualifier => 'publication', language  => '' );
		$dc->characters($publication_type);
		$dc->endTag('dcvalue');

		# Work type

		$dc->startTag( 'dcvalue', element => 'conference', qualifier => 'work', language => '' );
		$dc->characters($work_type);
		$dc->endTag('dcvalue');

		# Journal

		$dc->startTag( 'dcvalue', element   => 'conference', qualifier => 'journal', language  => '' );
		$dc->characters(StripNonXmlChars($journal));
		$dc->endTag('dcvalue');

		# Edition country

		$dc->startTag( 'dcvalue', element => 'conference', qualifier => 'country', language => '' );
		$dc->characters($country);
		$dc->endTag('dcvalue');

		# Edition city

		$dc->startTag( 'dcvalue', element => 'conference', qualifier => 'city', language => '' );
		$dc->characters($city);
		$dc->endTag('dcvalue');

		# Editorial

		$dc->startTag( 'dcvalue', element   => 'conference', qualifier => 'editorial', language  => '' );
		$dc->characters($editorial);
		$dc->endTag('dcvalue');

		# Event

		$dc->startTag( 'dcvalue', element => 'conference', qualifier => 'event', language => '' );
		$dc->characters(StripNonXmlChars($event));
		$dc->endTag('dcvalue');


		# Event type

		$dc->startTag( 'dcvalue', element => 'conference', qualifier => 'type', language => '' );
		$dc->characters($event_type);
		$dc->endTag('dcvalue');

		# Event country

		$dc->startTag( 'dcvalue', element   => 'conference', qualifier => 'eventcountry', language  => '' );
		$dc->characters($event_country);
		$dc->endTag('dcvalue');

		# Event city

		$dc->startTag( 'dcvalue', element   => 'conference', qualifier => 'eventcity', language  => '' );
		$dc->characters($event_city);
		$dc->endTag('dcvalue');

		# Event date

		$dc->startTag( 'dcvalue', element   => 'conference', qualifier => 'eventdate', language  => '' );
		$dc->characters($event_year . '-' . $event_mounth);
		$dc->endTag('dcvalue');

		# Institution

		$dc->startTag( 'dcvalue', element   => 'conference', qualifier => 'institution', language  => '' );
		$dc->characters(StripNonXmlChars($institution));
		$dc->endTag('dcvalue');

		# ISSN-ISBN

		$dc->startTag( 'dcvalue', element   => 'identifier', qualifier => 'issn', language  => '' );
		$dc->characters($issn_isbn);
		$dc->endTag('dcvalue');

		$dc->startTag( 'dcvalue', element   => 'identifier', qualifier => 'isbn', language  => '' );
		$dc->characters($issn_isbn);
		$dc->endTag('dcvalue');

	}

	$dc->endTag('dublin_core');

	my $xml = $dc->end();

	return $xml;
}

sub lang {

	my ($lang) = @_;

	my $value;

	switch ($lang) {

		case "Español"   { $value = "spa" }
		case "Inglés"    { $value = "eng" }
		case "Portugués" { $value = "por" }
		case "Alemán"	 { $value = "deu" }
		case "Francés"   { $value = "fra" }
		case "Italiano"  { $value = "ita"}		
		else             { $value = "N/D" }

	}

	return $value;

}

sub lang2 {

	my ($lang) = @_;

	my $value;

	switch ($lang) {

		case "spa"	{ $value = "es" }
		case "eng" 	{ $value = "en" }
		case "por"	{ $value = "por" }
		case "deu" 	{ $value = "deu" }
		case "fra"  { $value = "fr" }
		case "ita"  { $value = "it" }		
		else 	   	{ $value = "N/A" }
	}

	return $value;

}

sub types {

	my ($type) = @_;

	my $value;

	switch ($type) {

		case "Articulo"          { $value = "article" }
		case "Capitulo de Libro" { $value = "bookPart" }
		case "Congreso"      	 { $value = "conferenceObject" }
		case "Libro"             { $value = "book" }
		case "Tesis"             { $value = "bachelorThesis" }
		else                     { $value = "" }

	}

	return $value;

}

sub check_status {
	my ($status) = @_;

	my $value;

	if($status == 0){
		$value = 'submittedVersion';
	}
	else{
		$value = 'publishedVersion';
	}
	return $value;
}

sub check_ref {

	my ($referato) = @_;

	my $value;

	switch($referato){

		case 0	{ $value = 'Sin referato'}
		case 1	{ $value = 'No informado'}
		case 2	{ $value = 'Con referato'}

	} 
	return $value;
}

sub check_role {

	my ($row) = @_;
	
	my ($role, $value);

	my $is_author 		= $row->{'es_autor'};
	my $is_editor_comp 	= $row->{'es_editor_compilador'};
	my $is_revisor 		= $row->{'es_revisor'};

	$role = $is_author . $is_editor_comp . $is_revisor;

	switch($role){

		case '000'	{ $value = 'Ninguno' }
		case '001'	{ $value = 'Revisor' }
		case '010'	{ $value = 'Editor/Compilador' }
		case '011'	{ $value = 'Editor/Compilador - Revisor' }
		case '100'	{ $value = 'Autor' }
		case '101'	{ $value = 'Autor - Revisor' }
		case '110'	{ $value = 'Autor - Editor/Compilador' }
		case '111'	{ $value = 'Autor - Editor/Compilador - Revisor' }
	
	}
	
	return $value;
}

sub check_referato {
		my ($row) = @_;

		my ($ref, $value);

		switch ($row->{'tipo_produccion'}) {

			case 'Articulo'				{ $value = $row->{'Referato_articulo'} }
			case 'Libro'				{ $value = $row->{'Referato_libro'}	}
			case 'Capitulo de Libro'	{ $value = $row->{'Referato_capitulo'} }
		}

		$ref = check_ref($value);

		return $ref;
}

sub StripNonXmlChars {
    my $str = shift;
    if (!defined($str) || $str eq ""){
        return "";
    }
    $str =~ s/[^\x09\x0A\x0D\x{0020}-\x{D7FF}\x{E000}-\x{FFFD}\x{10000}-\x{10FFFF}]//g;
    return $str;
}

sub check {
	my ($args) = @_;
	if(!$args){
		print "Not found\n";
	}
	
	return $args;
}
1;
