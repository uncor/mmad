#!/bin/bash/perl

use Modern::Perl;

use Getopt::Long;
use Switch;
use Term::ANSIColor;
use XML::Writer;

use MMAD::Entities;
use MMAD::Types;

our @EXPORT = (
    qw( message_herbarium
        color_message )
);

my ($proc, $type, $date);

my $result = GetOptions(
  
    'proc=s'    => \$proc,
    'type=s'    => \$type,
    'date=s'    => \$date,        

);
    
    if($type eq('0') && $proc eq('1')){
        message_herbarium();
        herbarium();
    }

    else{
        message_memory($proc, $type);
        material_types($proc, $type);
    }

sub message_herbarium {
    print 
            color('green'), "\nIniciando proceso de migración de ",
            color('yellow'),"herbario","\n\n", 
            color('reset');
}

sub message_memory {

    my ($proc, $type) = @_;

    my $p = entity($proc);
    my $t = types($type);

    print color('green'), "\nIniciando proceso de migración de ",
          color('yellow'),$t, 
          color('green')," de ", 
          color('yellow'),$p,"\n",
          color('reset');
   
}

1;
