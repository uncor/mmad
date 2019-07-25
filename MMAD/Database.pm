package MMAD::Database;

use Modern::Perl;

use DBI;

##### MySQL database configuration ##### 

sub connect_db {

    my ($driver, $database, $host, $dsn, $userid, $password, $dbh);

    $driver = "mysql";
    $database = "test";
    $host = "localhost";
    $dsn = "DBI:$driver:database=$database:host=$host";
    $userid = "alexis";
    $password = "test2019";
    $dbh = DBI->connect($dsn, $userid, $password, { mysql_enable_utf8 => 1 } ) or die $DBI::errstr;
    
    return $dbh;

}
1;