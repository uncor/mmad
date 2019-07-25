    # Módulo de Migración de Datos

#### Descripción

MMAD (Módulo para la migración de metadatos y archivos digitales) es una herramienta desarrollada por la Oficina de Conocimiento Abierto (OCA) y la Prosecretaría de Informática, ambas pertenecientes a la Universidad Nacional de Córdoba (UNC). El programa permite: 

* Extraer los metadatos de los investigadores y sus registros.
* Codificarlos en un esquema Dublin Core.
* Almacenarlos en directorios bien definidos para su migración a repositorios digitales basados en DSpace.

#### Prerrequisitos de Instalación

MMAD es una herramienta desarrollada en Perl, por lo tanto es necesario instalar:

* Perl >= v5.26.1 
* MySQL >= v5.7.26

Más información para crear un usuario y base de datos.

* Instalar MySQL: https://dev.mysql.com/downloads/mysql
* Crear usuario: https://dev.mysql.com/doc/refman/5.7/en/create-user.html
* Crear base de datos: https://dev.mysql.com/doc/refman/5.7/en/creating-database.html

#### Funcionamiento

* Clonar el repositorio

### 

    git clone https://github.com/uncor/mmad.git mmad

* Dirigirse a la carpeta raíz del proyecto y ejecutar el siguiente comando:

###
    cd mmad

* Copiar el archivo config.yaml.sample y agregar la configuración que corresponda


###
    cp config.yam.sample config.yaml

* Crear la base de datos con los datos configurados en config.yaml (En caso que se desee trabajar en un entorno de test)

* Ejecutar el siguiente comando para realizar la migración de datos

###    

    perl [mmad-src]/mmad.pl --date [arg1] --unit [arg2] --type [arg3]

* Dirigirse al home del usuario y buscar la directorio recien creado (ver Datos de referencia). Buscar el directorio del año de publicación y crear un archivo .zip del mismo. 

###

    cd $HOME/Odontología/Articulo/
    zip -r 2013.zip 2013 

* Ir al repositorio de la institución y agregar los metadatos que correspon. Buscar la opción "Importación por lotes (ZIP)" (Es importante crear una colección y almacenar los registros recién importados para el proceso de curación que corresponda antes de ser publicados).

Más información sobre DSpace:

* Documentación de DSpace: https://wiki.duraspace.org/display/DSDOC5x/DSpace+5.x+Documentation 
* Importar y Exportar: https://wiki.duraspace.org/display/DSDOC5x/Importing+and+Exporting+Items+via+Simple+Archive+Format

#### Datos de referencia

Las referencias que se muestran a continuación dependerá de cada universidad. 

1. date: Año de publicación (Ej: 2013) 
2. unit: Unidad académica (Ej: 187 corresponde Facultad de Odontología)
3. type: Tipo de material:

    * 1 = artículo
    * 2 = libro 
    * 3 = conferencia 
    * 4 = capítulo de libro  
    * 5 = tesis

#### Licencia

MMAD está bajo una licencia <a href="./LICENSE.txt">AGPL v3</a>.




