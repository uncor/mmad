package MMAD::Database;

use Modern::Perl;

use base 'Exporter';

our @EXPORT = (
    qw( connect_db )
);

use DBI;
use YAML;

##### MySQL database configuration #####

sub connect_db {

    my ($args) = @_;

    my $config = YAML::LoadFile( 'config.yaml' );
    my $driver   = $config->{driver};
    my $database = $config->{database};
    my $host     = $config->{host};
    my $userid   = $config->{userid};
    my $password = $config->{password};

    my $dsn      = "DBI:$driver:database=$database:host=$host";

    my $dbh      = DBI->connect( $dsn, $userid, $password, { mysql_enable_utf8 => 1 } )
        or die $DBI::errstr;

    return $dbh;
}

1;
