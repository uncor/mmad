package MMAD::Types;

use Modern::Perl;

use base 'Exporter';

use MMAD::Database;
use MMAD::Directory;
use MMAD::DublinCore;
use MMAD::DublinCoreExt;
use MMAD::DarwinCore;
use MMAD::Statements;

use Term::ANSIColor;
use Encode;

our @EXPORT = (
    qw( material_types 
        herbarium )
);

use Switch;

sub material_types {
	
    #my ( $type, $date, $entity ) = @_;

    my ( $proc, $type, $date ) = @_; 

    my $dbh = connect_db();

    my $stmt = check_type($proc, $type);

    if($stmt){
        
        my $sth = $dbh->prepare($stmt);
        
        $sth->execute() or die $DBI::errstr;

        while ( my $row = $sth->fetchrow_hashref ){

            my ($fh, $xml);
            
            $fh = create_directory($row, $date);
            
            $xml = generate_xml($row);

            print $fh $xml;
        }

        $sth->finish();
    }
    else{
        print color('red'),"Please choose the correct option\n",color('reset');
    }
}

sub herbarium {

    my ( $proc ) = @_;

    my $dbh = connect_db2();

    my $stmt = herbarium_stmt();

    if($stmt){

        my $sth = $dbh->prepare($stmt);

        $sth->execute() or die $DBI::errstr;

        while( my $row = $sth->fetchrow_hashref ){

            my ($fh1, $fh2, $fh3, $dc, $dwc);

            ($fh1, $fh2, $fh3) = create_directory_herbarium($row);

            $dc = generate_dc($row);

            $dwc = generate_dwc($row);

            print $fh1 $dc;
            print $fh2 $dwc;
            print $fh3 ( "ocurrenceId: ",                   $row->{'occurrenceId'},"\n",
                         "basicOfRecord: ",                 $row->{'basisOfRecord'},"\n",
                         "institutionCode: ",               $row->{'institutionCode'},"\n",
                         "previousIdentifications: ",       $row->{'previousIdentifications'},"\n",
                         "recordedBy: ",                    $row->{'recordedBy'},"\n",
                         "recordNumber: ",                  $row->{'recordNumber'},"\n",
                         "otherCatalogNumbers: ",           $row->{'otherCatalogNumbers'},"\n",
                         "verbatimEventDate: ",             $row->{'verbatimEventDate'},"\n",
                         "day: ",                           $row->{'days'},"\n",
                         "month: ",                         $row->{'months'},"\n",
                         "year: ",                          $row->{'years'},"\n",
                         "eventDate: ",                     $row->{'eventDate'},"\n",
                         "higherGeography: ",               $row->{'higherGeography'},"\n",
                         "continent: ",                     $row->{'continent'},"\n",
                         "country: ",                       $row->{'country'},"\n",
                         "countryCode: ",                   $row->{'countryCode'},"\n",
                         "stateProvince: ",                 $row->{'stateProvince'},"\n",
                         "county: ",                        $row->{'county'},"\n",
                         "locality: ",                      $row->{'locality'},"\n",
                         "decimalLatitude: ",               $row->{'decimalLatitude'},"\n",
                         "decimalLongitude: ",              $row->{'decimalLongitude'},"\n",
                         "coordinateUncertaintyInMeters: ", $row->{'coordinateUncertaintyInMeters'},"\n",
                         "verbatimElevation: ",             $row->{'verbatimElevation'},"\n",
                         "occurrenceRemarks: ",             $row->{'occurrenceRemarks'},"\n",
                         "kingdom: ",                       $row->{'kingdom'},"\n",
                         "phylum: ",                        $row->{'phylum'},"\n",
                         "class: ",                         $row->{'class'},"\n",
                         "order: ",                         $row->{'orders'},"\n",
                         "family: ",                        $row->{'family'},"\n",
                         "scientificName: ",                $row->{'scientificName'},"\n",
                         "identifiedBy: ",                  $row->{'identifiedBy'},"\n",
                         "dateIdentified: ",                $row->{'dateIdentified'},"\n",
                         "georeferenceSources: ",           $row->{'georeferenceSources'},"\n",
                         "georeferenceRemarks: ",           $row->{'georeferenceRemarks'},"\n",
                         "geodeticDatum: ",                 $row->{'geodeticDatum'},"\n",             
                         "catalogNumber: ",                 $row->{'catalogNumber'},"\n",
                         "typeStatus: ",                    $row->{'typeStatus'},"\n",
                         "establishmentMeans: ",            $row->{'establishmentMeans'},"\n"
                        );

        }

        $sth->finish();
    
    }
    
    else{
        
        print color('red'),"Please choose the correct option\n",color('reset');
    
    }

}

1;
