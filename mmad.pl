#!/bin/bash/perl

use Modern::Perl;

use Getopt::Long;
use Switch;
use Term::ANSIColor;
use XML::Writer;

use MMAD::Entities;
use MMAD::Types;

use LWP::UserAgent ();

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

    # Add config
    #
    # my $config   = YAML::LoadFile('config.yaml');
    # my $url      = $config->{url};

    # Add API
    #
    # my $ua = LWP::UserAgent->new(timeout => 10);
    # $ua->env_proxy;
    # my $reponse = $ua->get("$url/tramites/$proc/publicaciones?tipo=$type")
    # if ($response->is_success) {
    #   print color('green'),"Objeto encontrado\n",color('reset');
    #   sleep(2);
    #   my $decoded_json = decode_json($response->decoded_content);
    #   message_memory($proc, $type);
    #   material_types(@$decoded_json,$date);
    # else {
    #   print color('red'),"Objeto no encotrado\n",color('reset');
    #   die $response->status_line;
    # }

    
    if($type eq('0') && $proc eq('1')){
        message_herbarium();
        herbarium();
    }


    else{
        message_memory($proc, $type);
        material_types($proc, $type, $date);
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
          color('yellow'),$p, 
	  color('green')," del año ",
	  color('yellow'),$date,"\n",
          color('reset');
   
}

1;
