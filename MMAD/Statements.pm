package MMAD::Statements;

use Modern::Perl;

use base 'Exporter';

use Switch;

our @EXPORT = (
    qw( check_type )
);

##### Queries #####

# Articles

sub check_type {
    
    my ($type, $date, $unit) = @_;
    
    my $stmt;

    switch ($type){

        case 1 { $stmt = "SELECT p.id AS Produccion, p.produccion AS Titulo, i.idioma AS Idioma, tp.tipo_produccion AS Tipo, 
                          a.link_archivo_fulltext AS Link, a.volumen AS Volumen, a.tomo AS Tomo, a.numero AS Numero, a.pagina_inicial AS Pagina_Inicial,
                          a.pagina_final AS Pagina_Final, a.web AS URL, a.doi AS DOI, tr.tipo_referato AS Referato, a.publicado AS Publicado, a.issn AS ISSN, a.eissn AS EISSN, a.editorial AS Editorial,
                          ps.pais AS Pais_Edicion, a.lugar_edicion AS Ciudad_Edicion, a.anio_publica AS Anio_Publicacion, 
                          concat(per.apellido,', ',per.nombre) AS Creador, pc.palabra_clave AS Palabra_Clave, a.resumen AS Resumen, u.unidad AS Unidad,
                          cd.campo_disciplinar AS Areas_del_Conocimiento, a.revista AS Revista
                          from test.PERSONA per
                          INNER JOIN test.PRODUCCION p ON per.id = p.persona_id
                          INNER JOIN test.PR_ARTICULO a ON a.produccion_id = p.id
                          INNER JOIN test.IDIOMA i ON i.id = a.idioma_id
                          INNER JOIN test.TIPO_PRODUCCION tp ON tp.id = p.tipo_produccion_id
                          INNER JOIN test.PAIS ps ON a.pais_edicion_id = ps.id
                          INNER JOIN test.PALABRA_CLAVE_PRODUCCION pcp ON p.id = pcp.produccion_id
                          INNER JOIN test.PALABRA_CLAVE pc ON pcp.palabra_clave_id = pc.id
                          INNER JOIN test.UNIDAD_PERSONA up ON per.id = up.persona_id
                          INNER JOIN test.UNIDAD u ON up.unidad_id = u.id
                          INNER JOIN test.PRODUCCION_CAMPO_DISCIPLINAR pcd ON p.id = pcd.produccion_id
                          INNER JOIN test.CAMPO_DISCIPLINAR cd ON pcd.campo_disciplinar_id = cd.id
                          INNER JOIN test.TIPO_REFERATO AS tr ON a.tipo_referato_id = tr.id
                          WHERE a.anio_publica = $date AND u.id = $unit 
                          AND a.link_archivo_fulltext IS NOT NULL
                          AND a.link_archivo_fulltext LIKE 'sigeva_files%'
                          ORDER BY p.id" }
        
        case 2 { $stmt = "SELECT p.id AS Produccion, p.produccion AS Titulo, i.idioma AS Idioma, l.link_archivo_fulltext AS Link, tp.tipo_produccion AS Tipo, 
                          l.cantidad_volumenes AS Cantidad_Volumenes, l.total_paginas_libro AS Cantidad_Paginas, l.isbn AS ISBN, 
                          ps.pais AS Pais_Edicion, l.lugar_edicion AS Ciudad_Edicion, l.publicado AS Estado, l.referato AS Referato, 
                          l.editorial AS Editorial, l.anio_publica AS Anio_Publicacion, l.web AS URL, 
                          concat(per.apellido,', ',per.nombre) AS Creador, pc.palabra_clave AS Palabra_Clave, l.resumen AS Resumen, u.unidad AS Unidad
                          from test.PERSONA per
                          INNER JOIN test.PRODUCCION p ON per.id = p.persona_id
                          INNER JOIN test.PR_LIBRO l ON l.produccion_id = p.id
                          INNER JOIN test.IDIOMA i ON i.id = l.idioma_id
                          INNER JOIN test.TIPO_PRODUCCION tp ON tp.id = p.tipo_produccion_id
                          INNER JOIN test.PAIS ps ON l.pais_edicion_id = ps.id
                          INNER JOIN test.PALABRA_CLAVE_PRODUCCION pcp ON p.id = pcp.produccion_id
                          INNER JOIN test.PALABRA_CLAVE pc ON pcp.palabra_clave_id = pc.id
                          INNER JOIN test.UNIDAD_PERSONA up ON per.id = up.persona_id
                          INNER JOIN test.UNIDAD u ON up.unidad_id = u.id
                          WHERE l.anio_publica = $date AND u.id = $unit 
                          AND l.link_archivo_fulltext IS NOT NULL
                          AND l.link_archivo_fulltext LIKE 'sigeva_files%'
                          ORDER BY p.id" }

        case 3 { $stmt = "SELECT p.id AS Produccion, p.produccion AS Titulo, i.idioma AS Idioma, tp.tipo_produccion AS Tipo, 
                          cl.link_archivo_fulltext AS Link, cl.numero AS Numero, cl.pagina_inicial AS Pagina_Inicial, cl.pagina_final AS Pagina_Final,
                          cl.isbn AS ISBN, cl.titulo_libro AS Titulo_Libro, cl.tomo AS Tomo, cl.total_paginas_libro AS Total_Paginas, cl.volumen AS Volumen, 
                          ps.pais AS Pais_Edicion, cl.lugar_edicion AS Ciudad_Edicion, cl.publicado AS Estado, cl.referato AS Referato, 
                          cl.editorial AS Editorial, cl.anio_publica AS Anio_Publicacion, cl.web AS URL, 
                          concat(per.apellido,', ',per.nombre) AS Creador, pc.palabra_clave AS Palabra_Clave, cl.resumen AS Resumen, u.unidad AS Unidad,
                          cd.campo_disciplinar AS Areas_del_Conocimiento
                          from test.PERSONA per
                          INNER JOIN test.PRODUCCION p ON per.id = p.persona_id
                          INNER JOIN test.PR_CAPITULO_LIBRO cl ON cl.produccion_id = p.id
                          INNER JOIN test.IDIOMA i ON i.id = cl.idioma_id
                          INNER JOIN test.TIPO_PRODUCCION tp ON tp.id = p.tipo_produccion_id
                          INNER JOIN test.PAIS ps ON cl.pais_edicion_id = ps.id
                          INNER JOIN test.PALABRA_CLAVE_PRODUCCION pcp ON p.id = pcp.produccion_id
                          INNER JOIN test.PALABRA_CLAVE pc ON pcp.palabra_clave_id = pc.id
                          INNER JOIN test.UNIDAD_PERSONA up ON per.id = up.persona_id
                          INNER JOIN test.UNIDAD u ON up.unidad_id = u.id
                          INNER JOIN test.PRODUCCION_CAMPO_DISCIPLINAR pcd ON p.id = pcd.produccion_id
                          INNER JOIN test.CAMPO_DISCIPLINAR cd ON pcd.campo_disciplinar_id = cd.id
                          WHERE cl.anio_publica = $date AND u.id = $unit 
                          AND cl.link_archivo_fulltext IS NOT NULL
                          AND cl.link_archivo_fulltext LIKE 'sigeva_files%'
                          ORDER BY p.id" }

        case 4 { $stmt = "SELECT p.id AS Produccion, p.produccion AS Titulo, i.idioma AS Idioma, tpub.tipo_publicacion AS Tipo_Publicacion, 
                          tt.tipo_trabajo AS Tipo_Trabajo, tp.tipo_produccion AS Tipo, c.link_archivo_fulltext AS Link,
                          c.titulo_publicacion AS Revista, ps.pais AS Pais_Edicion, c.lugar_publicacion AS Ciudad_Edicion,
                          c.editorial AS Editorial, c.anio_publica AS Fecha_Publicacion, c.web AS URL, c.reunion_cientifica AS Evento, 
                          tr.tipo_reunion AS Tipo_Evento, ps.pais AS Pais_Evento, c.lugar_reunion AS Ciudad_Evento, 
                          c.anio_reunion AS Fecha_Evento, c.institucion_organizadora AS Instituticion_Organizadora, 
                          concat(per.apellido,', ',per.nombre) AS Creador, pc.palabra_clave AS Palabra_Clave, c.resumen AS Resumen,
                          u.unidad AS Unidad
                          from test.PERSONA per
                          INNER JOIN test.PRODUCCION p ON per.id = p.persona_id
                          INNER JOIN test.PR_CONGRESO c ON c.produccion_id = p.id
                          INNER JOIN test.IDIOMA i ON i.id = c.idioma_id
                          INNER JOIN test.TIPO_PRODUCCION tp ON tp.id = p.tipo_produccion_id
                          INNER JOIN test.TIPO_PUBLICACION tpub ON c.tipo_publicacion_id = tpub.id
                          INNER JOIN test.TIPO_REUNION tr ON c.tipo_reunion_id = tr.id
                          INNER JOIN test.PAIS ps ON c.pais_edicion_id = ps.id
                          INNER JOIN test.PALABRA_CLAVE_PRODUCCION pcp ON p.id = pcp.produccion_id
                          INNER JOIN test.PALABRA_CLAVE pc ON pcp.palabra_clave_id = pc.id
                          INNER JOIN test.UNIDAD_PERSONA up ON per.id = up.persona_id
                          INNER JOIN test.UNIDAD u ON up.unidad_id = u.id
                          INNER JOIN test.TIPO_TRABAJO tt ON c.tipo_trabajo_id = tt.id
                          WHERE c.anio_publica = $date AND u.id = $unit 
                          AND c.link_archivo_fulltext IS NOT NULL
                          AND c.link_archivo_fulltext LIKE 'sigeva_files%'
                          ORDER BY p.id" }

        case 5 { $stmt = "SELECT p.id AS Produccion, pc.palabra_clave AS Palabra_Clave, p.produccion AS Titulo, t.resumen AS Resumen, 
                          concat(per.apellido, ', ', per.nombre) AS Creador, t.web AS URL,
                          i.idioma AS Idioma, tp.tipo_produccion AS Tipo, t.anio AS Fecha_Publicacion, 
                          ga.grado_academico AS Grado, t.link_archivo_fulltext AS Link, u.id,
                          u.unidad AS Unidad
                          FROM test.PERSONA per 
                          INNER JOIN test.PRODUCCION p ON per.id = p.persona_id
                          INNER JOIN test.PR_TESIS t ON t.produccion_id = p.id
                          INNER JOIN test.IDIOMA i ON i.id = t.idioma_id
                          INNER JOIN test.TIPO_PRODUCCION tp ON tp.id = p.tipo_produccion_id
                          INNER JOIN test.GRADO_ACADEMICO ga ON ga.id = t.grado_academico_id
                          INNER JOIN test.PALABRA_CLAVE_PRODUCCION pcp ON p.id = pcp.produccion_id
                          INNER JOIN test.PALABRA_CLAVE pc ON pcp.palabra_clave_id = pc.id
                          INNER JOIN test.UNIDAD_PERSONA up ON per.id = up.persona_id
                          INNER JOIN test.UNIDAD u ON up.unidad_id = u.id
                          WHERE t.anio = $date AND u.id = $unit 
                          AND t.link_archivo_fulltext IS NOT NULL   
                          AND t.link_archivo_fulltext LIKE 'sigeva_files%'
                          ORDER BY p.id" }

                       
        else { print color('red'),"\nType not found. Please choose the correct option\n\n", color('reset'); }
        
        }

        return $stmt; 
}
                        
1;

