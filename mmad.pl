#!/bin/bash/perl

use Modern::Perl;

use Getopt::Long;
use Switch;
use Term::ANSIColor;
use XML::Writer;

use MMAD::Entities;
use MMAD::Types;

my ($date, $entity, $type);

my $result = GetOptions(
    'date=s'    => \$date,
    'unity=s'   => \$entity,
    'type=s'    => \$type,
);

# Options 

    my $config      = YAML::LoadFile( 'config.yaml' );
    my $first_date  = $config->{first_date};
    my $last_date   = $config->{last_date};

if($date >= $first_date && $date <= $last_date){

    my $ent = entity($entity);

    if($ent) {

        if ($type) {
            
            color_message($type);
            material_types( $type, $date, $entity );
        }
        else{
            print color('red'),"\nType not found. Please choose the correct option\n\n", color('reset'); }
        }
    }
else{
    print color('red'),"\nDate not found. Please choose the correct option\n\n", color('reset');
    print color('red'),"Migrate process failed...\n\n";
}

sub color_message{

    my ($type, $value, $ent) = @_;

    switch($type){
        case 1 { $value = "artículos científicos" }
        case 2 { $value = "libros" }
        case 3 { $value = "capítulos de libros" }
        case 4 { $value = "congresos" }
        case 5 { $value = "tesis" }
        
    }
    
    if($value){

        $ent = entity($entity);
    
        print 
            color('green'), "\nIniciando proceso de migración de ",
            color('yellow'),$value, 
            color('green')," de ", 
            color('yellow'),$ent," ($date)\n\n",
            color('reset');
    }
}

1;
