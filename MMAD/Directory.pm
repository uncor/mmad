package MMAD::Directory;

use Modern::Perl;

use base 'Exporter';

use MMAD::Entities;

use File::Copy;
use File::Fetch;
use Encode;

our @EXPORT = (
    qw( create_directory
        create_content )
);

sub create_directory {

    my ($row) = @_;

    my $id      = $row->{'Produccion'};
    my $type    = $row->{'Tipo'};
    my $link    = $row->{'Link'};
    my $code    = $row->{'Codigo'};
    my $date    = $row->{'Fecha_Publicacion'};
    
    my $config  = YAML::LoadFile('config.yaml');
    my $home    = $config->{home};
    my $source  = $config->{src};
    my $license = $config->{license};
    
    # Folders

    my $unity = entity($code);

    my $unity_dir = "$home/$unity";
    my $type_dir  = "$unity_dir/$type";
    my $date_dir  = "$type_dir/$date";
    my $item_dir  = "$date_dir/item_$id";

    unless ( mkdir( $unity_dir, 0755 ) ) {
    }
        unless ( mkdir( $type_dir, 0755 ) ) {
        }
            unless ( mkdir( $date_dir, 0755 ) ) {
            }
                unless ( mkdir( $item_dir, 0755 ) ) {
                }

    open( my $fh, ">:encoding(UTF-8)", "$item_dir/dublin_core.xml" )
        or die "Can't save > dublin_core.xml: $!";

    # License txt

    copy( "$license", "$item_dir/license.txt" )
        or die "Copy failed: $!";

    # File content from URL or localhost

    my $src = "$source/$link";

    my $ff        = File::Fetch->new( uri => $src );
    my $file      = $ff->fetch( to => "$item_dir/" );
    my $file_name = $ff->file;

    create_content( $item_dir, $file_name );

    return $fh;

}

sub create_content {

    my ( $folder, $file ) = @_;

    my $original = "$file\tbundle:ORIGINAL\n";
    my $license  = "license.txt\tbundle:LICENSE\n";

    open( my $contents, ">", "$folder/contents" )
        or die "Can't save > content: $!";

    print $contents( $original, $license );

}

1;
