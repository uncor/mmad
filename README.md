# Módulo de Migración de Datos

#### Descripción
    
MMD está desarrollado en lenguaje de programación Perl. Está conformado por un menu principal (main.pl) y módulos que corresponde al tipo de material que se quiere extraer y transformar.

#### Requisitos de instalación 
   
* Perl >= v5.26.1 
* MySQL >= v5.7.26

#### Proceso de Migración
   
Para ejecutar el proceso de migración se debe ejecutar el siguiente comando:

###    

    $ perl [mmd-src]/main.pl --date [arg1] --unit [arg2] --type [arg3]

####   

1. date: Año de publicación (Ej: 2013) 
2. unit: Unidad académica (Ej: 187 corresponde Facultad de Odontología)
3. type: Tipo de material:

    * 1 = artículo
    * 2 = libro 
    * 3 = conferencia 
    * 4 = capítulo de libro  
    * 5 = tesis




