package MMAD::Directory;

use Modern::Perl;

use base 'Exporter';

use MMAD::Entities;

use File::Copy;
use File::Fetch;
use Encode;

our @EXPORT = (
    qw( create_directory
        create_content
        create_handle
        create_directory_herbarium )
);

sub create_directory {

    my ($row, $date) = @_;

    # my($result, $date) = @_;
    
    # my $id   = $result->{'id'};
    # my $type = $result->{'tipo_produccion'};
    # my $link = $result->{'link_archivo_fulltext'};
    # 

    my $src;
    my $id      = $row->{'id'};
    my $type    = $row->{'tipo_produccion'};
    my $link    = $row->{'link_archivo_fulltext'};
    my $code    = $row->{'codigo'};
    
    my $config  = YAML::LoadFile('config.yaml');
    my $home    = $config->{home}->{memoria};
    my $source  = $config->{src}->{memoria};
    my $source_without_file = $config->{src}->{empty};
    my $license = $config->{license};
    my $handle  = $config->{handle};
    
    # Folders
    
    my $unity = entity($code);

    my $unity_dir = "$home/$unity-$date";
    my $type_dir  = "$unity_dir/$type";
    my $item_dir  = "$type_dir/item_$id";

    unless ( mkdir( $unity_dir, 0755 ) ) {
    }
        unless ( mkdir( $type_dir, 0755 ) ) {
        }
            unless ( mkdir( $item_dir, 0755 ) ) {
            }

    open( my $fh, ">:encoding(UTF-8)", "$item_dir/dublin_core.xml" )
        or die "Can't save > dublin_core.xml: $!";

    # License txt

    copy( "$license", "$item_dir/license.txt" )
        or die "Copy failed: $!";

    # File content from URL or localhost
    
    if($link ne ""){
        $src = "$source/$link";
    }
    else{
        $src = "$source_without_file";
    } 
    
    my $ff        = File::Fetch->new( uri => $src );
    my $file      = $ff->fetch( to => "$item_dir/" );
    my $file_name = $ff->file;

    create_content( $item_dir, $file_name );

    return $fh;

}

sub create_directory_herbarium {

    my ($row) = @_;

    my $num     = $row->{'objectId'};
    my $path    = $row->{'path'};
    my $url     = $row->{'url'};
    
    my $config      = YAML::LoadFile('config.yaml');
    my $home        = $config->{home}->{herbario};
    my $source      = $config->{src}->{herbario};
    my $license     = $config->{license};
    my $collection  = $config->{collection};

    my $dir = "$home/$collection";
    my $catalogue = "$dir/$num";

    unless ( mkdir( $dir, 0755 ) ) {
         unless ( mkdir( $catalogue, 0755 ) ) {
        }
    }

    open( my $fh1, ">:encoding(UTF-8)", "$catalogue/dublin_core.xml")
        or die "Can't save > dublin_core.xml: $!";

    open( my $fh2, ">:encoding(UTF-8)", "$catalogue/metadata_dwc.xml")
        or die "Can't save > metadata_dwc.xml: $!";
    
    #open( my $fh3, ">:encoding(UTF-8)", "$catalogue/darwin_core.txt")
    #    or die "Can't save > dwc.txt: $!";


    # License txt

    copy( "$license", "$catalogue/license.txt" )
        or die "Copy failed: $!";

    # File content from URL or localhost

    my $src = "$source/$path";

    my $ff        = File::Fetch->new( uri => $src . ".tif" );
    my $file      = $ff->fetch( to => "$catalogue/" );
    my $file_name = $ff->file;

    create_content( $catalogue, $file_name );

    return ($fh1, $fh2);
    
}

sub create_content {

    my ( $folder, $file ) = @_;

    my $original = "$file\tbundle:ORIGINAL\n";
    my $text     = "darwin_core.txt\tbundle:ORIGINAL\n";
    my $license  = "license.txt\tbundle:LICENSE\n";
       
    open( my $contents, ">:encoding(UTF-8)", "$folder/contents" )
        or die "Can't save > content: $!";

    print $contents( $original, $license );

}

1;
