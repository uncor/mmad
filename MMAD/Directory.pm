package MMAD::Directory;

use Modern::Perl;

use File::Copy;
use File::Fetch;
use Encode;

sub create_directory{

    my ( $id, $type, $link, $date, $unit_case ) = @_;

    my $HOME = $ENV{'HOME'}; 

    my $folder1 = "$HOME/$unit_case"; 
    
    my ($folder2, $folder3, $folder4);
    
    my $src = "$HOME/mmd/mmd-src/default.license";
    
    my $url = "file:///media/alexis/Toshiba_Ext/$link";

    $folder2 = "$folder1/$type";
    
    $folder3 = "$folder2/$date";
    
    $folder4 = "$folder3/item_$id";

    # Node directory

    unless(mkdir ($folder1,0755)){
    }
    
    # Type 
 
    unless(mkdir ($folder2,0755)) {
    }    
    
    # Date
    
    unless(mkdir ($folder3,0755)){
    }
    
    # Item

    unless(mkdir ($folder4,0755)){
    }
            
    open(my $fh, ">:encoding(UTF-8)", "$folder4/dublin_core.xml")
        or die "Can't save > dublin_core.xml: $!";

    # License txt
    
    copy("$src", "$folder4/license.txt") 
        or die "Copy failed: $!";

    # File content from URL or localhost

    #my $url = "https://sigeva.unc.edu.ar/eva/archivosAdjuntos.do?archivo=$link";
    
    
    my $ff = File::Fetch->new(uri => $url);
    my $file = $ff->fetch(to=>"$folder4/");
    my $file_name = $ff->file;

    create_content($folder4, $file_name);
    
    return $fh;
        
}

sub create_content{

    my ($folder, $file) = @_;
    
    my $original = "$file\tbundle:ORIGINAL\n";

    my $license = "license.txt\tbundle:LICENSE\n";

    open(my $contents, ">", "$folder/contents")
        or die "Can't save > content: $!";

    print $contents($original, $license);
    
}

1;
