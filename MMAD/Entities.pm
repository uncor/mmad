package MMAD::Entities;

use Modern::Perl;
use Term::ANSIColor;

use base 'Exporter';

use Switch;

our @EXPORT = (
    qw( entity
        types )
);

# sub entity{

#     my ($unit) = @_;

#     my $value;

#     switch($unit){

#         case 185    { $value = 'Rectorado' }
#         case 186    { $value = 'Medicina' }
#         case 187    { $value = 'Odontologia' }
#         case 188    { $value = 'Ciencias-Economicas' }
#         case 189    { $value = 'Psicologia' }
#         case 190    { $value = 'Derecho-Ciencias-Sociales' }
#         case 191    { $value = 'Ciencias-Agropecuarias' }
#         case 192    { $value = 'Ciencias-Exactas' }
#         case 193    { $value = 'FAMAF' }
#         case 194    { $value = 'Ciencias-Quimicas' }
#         case 195    { $value = 'Filosofía-Humanidades' }
#         case 196    { $value = 'Observatorio' }
#         case 197    { $value = 'Arquitectura' }
#         case 198    { $value = 'Centro-Estudios-Avanzados' }
#         case 200    { $value = 'Lenguas' }
#         case 201    { $value = 'Artes' }
#         case 206    { $value = 'Ciencias-Sociales' }
#         case 207    { $value = 'Comunicacion' }
#         else        { print color('red'),"\nUnit not found. Plese choose correct option\n\n", color('reset') }

#     } 

#     return $value;
# }

sub entity {

    my ( $code ) = @_;
    my $value;

    switch($code){

        # 2013

        case '10620190100002CB' { $value = 'Artes-2013' } 
        case '10620190100012CB' { $value = 'FAMAF-2013' }	
        case '10620190100014CB' { $value = 'Odontologia-2013' }	
        case '10620190100001CB' { $value = 'Arquitectura-2013' }	
        case '10620190100003CB'	{ $value = 'Ciencias-Comunicacion-2013' }
        case '10620190100004CB' { $value = 'Ciencias-Sociales-2013' }	
        case '10620190100005CB'	{ $value = 'Ciencas-Agropecuarias-2013' } 	
        case '10620190100006CB' { $value = 'Ciencas-Economicas-2013' }
        case '10620190100007CB'	{ $value = 'Ciencas-Exactas-2013' }	
        case '10620190100008CB'	{ $value = 'Ciencias-Quimicas-2013' }
        case '10620190100009CB'	{ $value = 'Derecho-Ciencias-Sociales-2013' }	
        case '10620190100011CB'	{ $value = 'Lenguas-2013' }	
        case '10620190100013CB'	{ $value = 'Medicina-2013' }
        case '10620190100015CB'	{ $value = 'Psicologia-2013' }	
        case '10620190100016CB'	{ $value = 'Observatorio-2013'} 
        
        # 2014

        case '10620190300014CB' { $value = 'Odontologia-2014' }
        case '10620190300004CB' { $value = 'Ciencias-Sociales-2014' }	
        
        # 2015

        case '10620190500014CB' { $value = 'Odontologia-2015' }

        # 2016
        
        case '10620190400014CB' { $value = 'Odontologia-2016'}

        # 2017

        case '10620190200014CB' { $value = 'Odontologia-2017'}
#         
        else                    { print color('red'), "\nUnit not found. Plese choose correct option\n\n", color('reset') }

    }

    return $value;
}

sub types {

    my ($type) = @_;

    my $value;

    switch ($type) {

        case '1'    { $value = 'Articulo' }
        case '2'    { $value = 'Capitulo de Libro' }
        case '3'    { $value = 'Libro' }
        case '4'    { $value = 'Congreso' }
        case '7'    { $value = 'Tesis' }
        else        { print    'Type not found' }

    }

    return $value;
}

1;
