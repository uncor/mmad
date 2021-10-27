package MMAD::Entities;

use Modern::Perl;
use Term::ANSIColor;

use base 'Exporter';

use Switch;

our @EXPORT = (
    qw( entity
        types )
);

sub entity {

    my ( $code ) = @_;
    my $value;

    switch($code){

        # Memory [2013, 2014, 2015, 2016, 2017, 2018]    

        case ['10620190100001CB','10620190300001CB','10620190500001CB','10620190400001CB','10620190200001CB']   { $value = 'Arquitectura' }	
        case ['10620190100002CB','10620190300002CB','10620190500002CB','10620190400002CB','10620190200002CB']   { $value = 'Artes' }
        case ['10620190100003CB','10620190300003CB','10620190500003CB','10620190400003CB','10620190200003CB']   { $value = 'Ciencias-Comunicacion' }
        case ['10620190100004CB','10620190300004CB','10620190500004CB','10620190400004CB','10620190200004CB']   { $value = 'Ciencias-Sociales' }	
        case ['10620190100005CB','10620190300005CB','10620190500005CB','10620190400005CB','10620190200005CB']	{ $value = 'Ciencias-Agropecuarias' } 	
        case ['10620190100006CB','10620190300006CB','10620190500006CB','10620190400006CB','10620190200006CB']   { $value = 'Ciencias-Economicas' }
        case ['10620190100007CB','10620190300007CB','10620190500007CB','10620190400007CB','10620190200007CB']	{ $value = 'Ciencias-Exactas' }	
        case ['10620190100008CB','10620190300008CB','10620190500008CB','10620190400008CB','10620190200008CB']	{ $value = 'Ciencias-Quimicas' }
        case ['10620190100009CB','10620190300009CB','10620190500009CB','10620190400009CB','10620190200009CB']	{ $value = 'Derecho-Ciencias-Sociales' }
        case ['10620190100010CB','10620190300010CB','10620190500010CB','10620190400010CB','10620190200010CB']   { $value = 'Filosofia-Humanidades' }	
        case ['10620190100011CB','10620190300011CB','10620190500011CB','10620190400011CB','10620190200011CB']	{ $value = 'Lenguas' }	
        case ['10620190100012CB','10620190300012CB','10620190500012CB','10620190400012CB','10620190200012CB']   { $value = 'FAMAF' }
        case ['10620190100013CB','10620190300013CB','10620190500013CB','10620190400013CB','10620190200013CB']	{ $value = 'Medicina' }
        case ['10620190100014CB','10620190300014CB','10620190500014CB','10620190400014CB','10620190200014CB','10620200100014CB']   { $value = 'Odontologia' }
        case ['10620190100015CB','10620190300015CB','10620190500015CB','10620190400015CB','10620190200015CB']	{ $value = 'Psicologia' }	
        case ['10620190100016CB','10620190300016CB','10620190500016CB','10620190400016CB','10620190200016CB']	{ $value = 'Observatorio'} 
        
        else    { print color('red'), "\nProcedure not found. Plese choose correct option\n\n", color('reset') }

    }

    return $value;
}

sub types {

    my ($type) = @_;

    my $value;

    switch ($type) {

        case '1'    { $value = 'Articulo' }
        case '2'    { $value = 'Partes de Libro' }
        case '3'    { $value = 'Libro' }
        case '4'    { $value = 'Congreso' }
        case '7'    { $value = 'Tesis' }
        else        { print color('red'), "\nType not found. Plese choose correct option\n\n", color('reset') }

    }

    return $value;
}

1;
