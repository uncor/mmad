package MMAD::Database;

use Modern::Perl;

use base 'Exporter';

our @EXPORT = (
    qw( connect_db
        connect_db2 )
);

use DBI;
use YAML;

##### MySQL database configuration #####

sub connect_db {

    my ($args) = @_;

    my $config = YAML::LoadFile( 'config.yaml' );
    my $driver   = $config->{driver};
    my $database = $config->{database}->{eva};
    my $host     = $config->{host}->{sigeva};
    my $userid   = $config->{userid}->{sigeva};
    my $password = $config->{password}->{sigeva};

    my $dsn      = "DBI:$driver:database=$database:host=$host";

    my $dbh      = DBI->connect( $dsn, $userid, $password, { mysql_enable_utf8 => 1 } )
        or die $DBI::errstr;

    return $dbh;
}

sub connect_db2 {

    my ($args) = @_;

    my $config = YAML::LoadFile( 'config.yaml' );
    my $driver   = $config->{driver};
    my $database = $config->{database}->{herbarium};
    my $host     = $config->{host}->{herbarium};
    my $userid   = $config->{userid}->{herbarium};
    my $password = $config->{password}->{herbarium};

    my $dsn      = "DBI:$driver:database=$database:host=$host";

    my $dbh      = DBI->connect( $dsn, $userid, $password, { mysql_enable_utf8 => 1 } )
        or die $DBI::errstr;

    return $dbh; 
    
}

1;
