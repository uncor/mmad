package MMAD::Types;

use Modern::Perl;

use base 'Exporter';

use MMAD::Database;
use MMAD::Directory;
use MMAD::DublinCore;
use MMAD::Entities;
use MMAD::Statements;

our @EXPORT = (
    qw( material_types )
);

use Switch;

sub material_types{
	
    my ( $type, $date, $entity ) = @_;

    my $dbh = connect_db();

    my $stmt = check_type($type, $date, $entity);

    if($stmt){
        
        my $sth = $dbh->prepare($stmt);

        $sth->execute() or die $DBI::errstr;

        while( my $row = $sth->fetchrow_hashref ){

            my ($fh, $unit_case, $xml);
            
            my $id = $row->{'Produccion'},
            my $type = $row->{'Tipo'};
            my $link = $row->{'Link'},
            
            $unit_case = entity($entity);

            $fh = create_directory( $id, $type, $link, $date, $unit_case );

            $xml = generate_xml($row);

            print $fh $xml;
        }

        $sth->finish();
    }
    else{
        print color('red'),"Please choose the correct option\n",color('reset');
    }
}

1;