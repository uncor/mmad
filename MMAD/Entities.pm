package MMAD::Entities;

use Modern::Perl;

use base 'Exporter';

use Switch;

our @EXPORT = (
    qw( entity )
);

sub entity{

    my ($unit) = @_;

    my $value;

    switch($unit){

        case 185    { $value = 'Rectorado' }
        case 186    { $value = 'Medicina' }
        case 187    { $value = 'Odontologia' }
        case 188    { $value = 'Ciencias-Economicas' }
        case 189    { $value = 'Psicologia' }
        case 190    { $value = 'Derecho-Ciencias-Sociales' }
        case 191    { $value = 'Ciencias-Agropecuarias' }
        case 192    { $value = 'Ciencias-Exactas' }
        case 193    { $value = 'FAMAF' }
        case 194    { $value = 'Ciencias-Quimicas' }
        case 195    { $value = 'Filosofía-Humanidades' }
        case 196    { $value = 'Observatorio' }
        case 197    { $value = 'Arquitectura' }
        case 198    { $value = 'Centro-Estudios-Avanzados' }
        case 200    { $value = 'Lenguas' }
        case 201    { $value = 'Artes' }
        case 206    { $value = 'Ciencias-Sociales' }
        case 207    { $value = 'Comunicacion' }
        else        { print color('red'),"\nUnit not found. Plese choose correct option\n\n", color('reset') }

    } 

    return $value;
}

1;
