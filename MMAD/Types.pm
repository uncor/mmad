package MMAD::Types;

use Modern::Perl;

use base 'Exporter';

use MMAD::Database;
use MMAD::Directory;
use MMAD::DublinCore;
use MMAD::DublinCoreExt;
use MMAD::DarwinCore;
use MMAD::Statements;

our @EXPORT = (
    qw( material_types 
        herbarium )
);

use Switch;

sub material_types {
	
    #my ( $type, $date, $entity ) = @_;

    my ( $proc, $type ) = @_; 

    my $dbh = connect_db();

    my $stmt = check_type($proc, $type);

    if($stmt){
        
        my $sth = $dbh->prepare($stmt);
        
        $sth->execute() or die $DBI::errstr;

        while ( my $row = $sth->fetchrow_hashref ){

            my ($fh, $xml);
            
            $fh = create_directory($row);
            
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

            my ($fh1, $fh2, $dc, $dwc);

            ($fh1, $fh2) = create_directory_herbarium($row);

            $dc = generate_dc($row);

            $dwc = generate_dwc($row);

            print $fh1 $dc;
            print $fh2 $dwc;
            

            

        }

        $sth->finish();
    
    }
    
    else{
        
        print color('red'),"Please choose the correct option\n",color('reset');
    
    }

}

1;