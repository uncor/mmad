package MMAD::Statements;

use Modern::Perl;

use base 'Exporter';

use Switch;

our @EXPORT = (
    qw( check_type
        herbarium_stmt )
);

# sub check_type {
    
#     my ($type, $date, $unit) = @_;
    
#     my $stmt;

#     switch ($type){

#         case 1 { $stmt = "SELECT p.id AS Produccion, p.produccion AS Titulo, i.idioma AS Idioma, tp.tipo_produccion AS Tipo, 
#                           a.link_archivo_fulltext AS Link, a.volumen AS Volumen, a.tomo AS Tomo, a.numero AS Numero, a.pagina_inicial AS Pagina_Inicial,
#                           a.pagina_final AS Pagina_Final, a.web AS URL, a.doi AS DOI, tr.tipo_referato AS Referato, a.publicado AS Estado, a.issn AS ISSN, a.eissn AS EISSN, a.editorial AS Editorial,
#                           ps.pais AS Pais_Edicion, a.lugar_edicion AS Ciudad_Edicion, a.anio_publica AS Fecha_Publicacion, 
#                           concat(per.apellido,', ',per.nombre) AS Creador, (GROUP_CONCAT(DISTINCT pc.palabra_clave SEPARATOR '; ')) AS Palabra_Clave, a.resumen AS Resumen, u.id AS Codigo, u.unidad AS Unidad,
#                           (GROUP_CONCAT(DISTINCT cd.campo_disciplinar SEPARATOR '; ')) AS Areas_del_Conocimiento, a.revista AS Revista, 
#                           o.tipo_origen AS Origen, tra.es_ignorado AS Ignorado, cmp.id AS Compilacion
#                           from eva.PRODUCCION p
#                           INNER JOIN eva.COMPILACION cmp ON cmp.produccion_id = p.id
#                           INNER JOIN eva.TIPO_ORIGEN o ON o.id = p.tipo_origen_id
#                           INNER JOIN eva.PERSONA per ON per.id = p.persona_id
#                           INNER JOIN eva.PR_ARTICULO a ON a.produccion_id = p.id
#                           INNER JOIN eva.IDIOMA i ON i.id = a.idioma_id
#                           INNER JOIN eva.TIPO_PRODUCCION tp ON tp.id = p.tipo_produccion_id
#                           INNER JOIN eva.PAIS ps ON a.pais_edicion_id = ps.id
#                           INNER JOIN eva.PALABRA_CLAVE_PRODUCCION pcp ON p.id = pcp.produccion_id
#                           INNER JOIN eva.PALABRA_CLAVE pc ON pcp.palabra_clave_id = pc.id
#                           INNER JOIN eva.UNIDAD_PERSONA up ON per.id = up.persona_id
#                           INNER JOIN eva.UNIDAD u ON up.unidad_id = u.id
#                           INNER JOIN eva.PRODUCCION_CAMPO_DISCIPLINAR pcd ON p.id = pcd.produccion_id
#                           INNER JOIN eva.CAMPO_DISCIPLINAR cd ON pcd.campo_disciplinar_id = cd.id
#                           INNER JOIN eva.TIPO_REFERATO tr ON a.tipo_referato_id = tr.id
#                           INNER JOIN eva.PRODUCCION_TRAMITE tra ON tra.produccion_id = p.id
#                           AND a.link_archivo_fulltext LIKE 'sigeva_files%'
#                           AND tra.es_ignorado = 0
#                           WHERE a.anio_publica = $date AND u.id = $unit 
#                           GROUP BY cmp.id" }
        
#         case 2 { $stmt = "SELECT cmp.compilacion_id AS Compilacion, p.id AS Produccion, p.produccion AS Titulo, i.idioma AS Idioma, l.link_archivo_fulltext AS Link, tp.tipo_produccion AS Tipo, 
#                           l.cantidad_volumenes AS Cantidad_Volumenes, l.total_paginas_libro AS Cantidad_Paginas, l.isbn AS ISBN, 
#                           CONCAT (l.is_autor, l.is_editor_compilador, l.is_revisor) AS Rol,
#                           ps.pais AS Pais_Edicion, l.lugar_edicion AS Ciudad_Edicion, l.publicado AS Estado, l.referato AS Referato, 
#                           l.editorial AS Editorial, l.anio_publica AS Fecha_Publicacion, l.web AS URL, 
#                           concat(per.apellido,', ',per.nombre) AS Creador, pc.palabra_clave AS Palabra_Clave, l.resumen AS Resumen, u.id AS Codigo, u.unidad AS Unidad
#                           from eva.PRODUCCION p
#                           INNER JOIN eva.COMPILACION cmp ON cmp.produccion_id = p.id
#                           INNER JOIN eva.PERSONA per ON per.id = p.persona_id
#                           INNER JOIN eva.PR_LIBRO l ON l.produccion_id = p.id
#                           INNER JOIN eva.IDIOMA i ON i.id = l.idioma_id
#                           INNER JOIN eva.TIPO_PRODUCCION tp ON tp.id = p.tipo_produccion_id
#                           INNER JOIN eva.PAIS ps ON l.pais_edicion_id = ps.id
#                           INNER JOIN eva.PALABRA_CLAVE_PRODUCCION pcp ON p.id = pcp.produccion_id
#                           INNER JOIN eva.PALABRA_CLAVE pc ON pcp.palabra_clave_id = pc.id
#                           INNER JOIN eva.UNIDAD_PERSONA up ON per.id = up.persona_id
#                           INNER JOIN eva.UNIDAD u ON up.unidad_id = u.id
#                           WHERE l.anio_publica = $date AND u.id = $unit 
#                           AND l.link_archivo_fulltext IS NOT NULL
#                           AND l.link_archivo_fulltext LIKE 'sigeva_files%'
#                           ORDER BY cmp.compilacion_id" }

#         case 3 { $stmt = "SELECT cmp.compilacion_id AS Compilacion, p.id AS Produccion, p.produccion AS Titulo, i.idioma AS Idioma, tp.tipo_produccion AS Tipo, 
#                           cl.link_archivo_fulltext AS Link, cl.numero AS Numero, cl.pagina_inicial AS Pagina_Inicial, cl.pagina_final AS Pagina_Final,
#                           cl.isbn AS ISBN, cl.titulo_libro AS Titulo_Libro, cl.tomo AS Tomo, cl.total_paginas_libro AS Total_Paginas, cl.volumen AS Volumen, 
#                           CONCAT(cl.is_autor, cl.is_editor_compilador,cl.is_revisor) AS Rol,
#                           ps.pais AS Pais_Edicion, cl.lugar_edicion AS Ciudad_Edicion, cl.publicado AS Estado, cl.referato AS Referato, 
#                           cl.editorial AS Editorial, cl.anio_publica AS Fecha_Publicacion, cl.web AS URL, 
#                           concat(per.apellido,', ',per.nombre) AS Creador, pc.palabra_clave AS Palabra_Clave, cl.resumen AS Resumen, u.id AS Codigo, u.unidad AS Unidad,
#                           cd.campo_disciplinar AS Areas_del_Conocimiento
#                           from eva.PRODUCCION p
#                           INNER JOIN eva.COMPILACION cmp ON cmp.produccion_id = p.id
#                           INNER JOIN eva.PERSONA per ON per.id = p.persona_id
#                           INNER JOIN eva.PR_CAPITULO_LIBRO cl ON cl.produccion_id = p.id
#                           INNER JOIN eva.IDIOMA i ON i.id = cl.idioma_id
#                           INNER JOIN eva.TIPO_PRODUCCION tp ON tp.id = p.tipo_produccion_id
#                           INNER JOIN eva.PAIS ps ON cl.pais_edicion_id = ps.id
#                           INNER JOIN eva.PALABRA_CLAVE_PRODUCCION pcp ON p.id = pcp.produccion_id
#                           INNER JOIN eva.PALABRA_CLAVE pc ON pcp.palabra_clave_id = pc.id
#                           INNER JOIN eva.UNIDAD_PERSONA up ON per.id = up.persona_id
#                           INNER JOIN eva.UNIDAD u ON up.unidad_id = u.id
#                           INNER JOIN eva.PRODUCCION_CAMPO_DISCIPLINAR pcd ON p.id = pcd.produccion_id
#                           INNER JOIN eva.CAMPO_DISCIPLINAR cd ON pcd.campo_disciplinar_id = cd.id
#                           WHERE cl.anio_publica = $date AND u.id = $unit 
#                           AND cl.link_archivo_fulltext IS NOT NULL
#                           AND cl.link_archivo_fulltext LIKE 'sigeva_files%'
#                           ORDER BY p.id" }

#         case 4 { $stmt = "SELECT cmp.compilacion_id AS Compilacion, p.id AS Produccion, p.produccion AS Titulo, i.idioma AS Idioma, tpub.tipo_publicacion AS Tipo_Publicacion, 
#                           tt.tipo_trabajo AS Tipo_Trabajo, tp.tipo_produccion AS Tipo, c.link_archivo_fulltext AS Link,
#                           c.titulo_publicacion AS Revista, ps.pais AS Pais_Edicion, c.lugar_publicacion AS Ciudad_Edicion,
#                           c.editorial AS Editorial, c.anio_publica AS Fecha_Publicacion, c.web AS URL, c.reunion_cientifica AS Evento, 
#                           tr.tipo_reunion AS Tipo_Evento, ps.pais AS Pais_Evento, c.lugar_reunion AS Ciudad_Evento, 
#                           c.anio_reunion AS Fecha_Evento, c.institucion_organizadora AS Instituticion_Organizadora, 
#                           concat(per.apellido,', ',per.nombre) AS Creador, pc.palabra_clave AS Palabra_Clave, c.resumen AS Resumen,
#                           u.id AS Codigo, u.unidad AS Unidad
#                           from eva.PRODUCCION p
#                           INNER JOIN eva.COMPILACION cmp ON cmp.produccion_id = p.id
#                           INNER JOIN eva.PERSONA per ON per.id = p.persona_id
#                           INNER JOIN eva.PR_CONGRESO c ON c.produccion_id = p.id
#                           INNER JOIN eva.IDIOMA i ON i.id = c.idioma_id
#                           INNER JOIN eva.TIPO_PRODUCCION tp ON tp.id = p.tipo_produccion_id
#                           INNER JOIN eva.TIPO_PUBLICACION tpub ON c.tipo_publicacion_id = tpub.id
#                           INNER JOIN eva.TIPO_REUNION tr ON c.tipo_reunion_id = tr.id
#                           INNER JOIN eva.PAIS ps ON c.pais_edicion_id = ps.id
#                           INNER JOIN eva.PALABRA_CLAVE_PRODUCCION pcp ON p.id = pcp.produccion_id
#                           INNER JOIN eva.PALABRA_CLAVE pc ON pcp.palabra_clave_id = pc.id
#                           INNER JOIN eva.UNIDAD_PERSONA up ON per.id = up.persona_id
#                           INNER JOIN eva.UNIDAD u ON up.unidad_id = u.id
#                           INNER JOIN eva.TIPO_TRABAJO tt ON c.tipo_trabajo_id = tt.id
#                           WHERE c.anio_publica = $date AND u.id = $unit 
#                           AND c.link_archivo_fulltext IS NOT NULL
#                           AND c.link_archivo_fulltext LIKE 'sigeva_files%'
#                           ORDER BY p.id" }

#         case 5 { $stmt = "SELECT p.id AS Produccion, pc.palabra_clave AS Palabra_Clave, p.produccion AS Titulo, t.resumen AS Resumen, 
#                           concat(per.apellido, ', ', per.nombre) AS Creador, t.web AS URL,
#                           i.idioma AS Idioma, tp.tipo_produccion AS Tipo, t.anio AS Fecha_Publicacion, 
#                           ga.grado_academico AS Grado, t.link_archivo_fulltext AS Link, u.id AS Codigo,
#                           u.unidad AS Unidad
#                           FROM eva.PRODUCCION p 
#                           INNER JOIN eva.PERSONA per ON per.id = p.persona_id
#                           INNER JOIN eva.PR_TESIS t ON t.produccion_id = p.id
#                           INNER JOIN eva.IDIOMA i ON i.id = t.idioma_id
#                           INNER JOIN eva.TIPO_PRODUCCION tp ON tp.id = p.tipo_produccion_id
#                           INNER JOIN eva.GRADO_ACADEMICO ga ON ga.id = t.grado_academico_id
#                           INNER JOIN eva.PALABRA_CLAVE_PRODUCCION pcp ON p.id = pcp.produccion_id
#                           INNER JOIN eva.PALABRA_CLAVE pc ON pcp.palabra_clave_id = pc.id
#                           INNER JOIN eva.UNIDAD_PERSONA up ON per.id = up.persona_id
#                           INNER JOIN eva.UNIDAD u ON up.unidad_id = u.id
#                           WHERE t.anio = $date AND u.id = $unit 
#                           AND t.link_archivo_fulltext IS NOT NULL   
#                           AND t.link_archivo_fulltext LIKE 'sigeva_files%'
#                           ORDER BY p.id" }

                       
#         else { print color('red'),"\nType not found. Please choose the correct option\n\n", color('reset'); }
        
#         }

#         return $stmt; 
# }

sub check_type {

        my ( $proc , $type ) = @_;
    
        my $stmt;

        # $stmt = "SELECT pr.id, tr.codigo, tpr.tipo_produccion, pr.produccion AS 'titulo', idioma.idioma, paisEdicion.pais,
	
        #          COALESCE(pra.lugar_edicion, prlib.lugar_edicion, prcap.lugar_edicion, otra.ciudad, prcon.lugar_reunion) AS 'ciudad',

	#          COALESCE(pra.publicado,prlib.publicado,prcap.publicado,prcon.publicado) AS 'publicado',

	#          COALESCE(pra.editorial, prlib.editorial, prcap.editorial) AS 'editorial',
	         
        #          COALESCE(prlib.web, prcap.web, tesis.web, otra.web) AS 'web',
	        
        #          COALESCE(pra.anio_publica, prlib.anio_publica, prcap.anio_publica, tesis.anio, otra.anio, prcon.anio_reunion) AS 'anio',
	        
        #          COALESCE(pra.mes_publica, prcon.mes_reunion) AS 'mes',
    
        #          pra.issn AS ISSN_articulo,
        #          pra.volumen AS Volumen_articulo,
        #          pra.tomo AS Tomo_articulo,
        #          pra.numero AS Numero_articulo,
        #          pra.tipo_referato_id AS Referato_articulo,
        #          pra.revista AS Revista_articulo,

	#          prlib.cantidad_volumenes Volumenes_libro,
        #          prlib.total_paginas_libro AS Paginas_libro,
	#          prlib.isbn AS ISBN_libro,
	
	#          tpl.tipo_parte_libro AS Tipo_capitulo,
        #          prcap.isbn AS ISBN_capitulo,
	#          prcap.titulo_libro AS Titulo_capitulo,
	#          prcap.pagina_inicial AS Pagina_inicial_capitulo,
	#          prcap.pagina_final AS Pagina_final_capitulo,
        #          prcap.volumen AS Volumen_capitulo,
        #          prcap.tomo AS Tomo_capitulo,
        #          prcap.numero AS Numero_capitulo,
        #          prcap.total_paginas_libro AS Total_paginas_capitulo,
        #          prcap.referato AS Referato_capitulo,

        #          prcon.reunion_cientifica,
        #          tre.tipo_reunion,
        #          prcon.alcance_internacional,
        #          prcon.alcance_nacional,
        #          prcon.institucion_organizadora,

	#          gacad.grado_academico,
	#          tesis.titulo_obtenido,

        #          otra.issn,
        #          otra.isbn,
        #          otra.total_paginas,
                
        #          (SELECT GROUP_CONCAT(tso.tipo_soporte) FROM eva.PRODUCCION_TIPO_SOPORTE prtso
        #                 JOIN eva.TIPO_SOPORTE tso ON tso.id = prtso.tipo_soporte_id
        #                 WHERE prtso.produccion_id = pr.id GROUP BY prtso.produccion_id) AS 'medios_difusion',
                
        #                 (SELECT GROUP_CONCAT(par.participacion, '[', tpar.tipo_participacion, ']') FROM PARTICIPACION_PRODUCCION parpr 
        #                         JOIN PARTICIPACION par ON par.id = parpr.participacion_id
        #                         JOIN TIPO_PARTICIPACION tpar ON tpar.id = parpr.tipo_participacion_produccion_id
        #                         WHERE parpr.produccion_id = pr.id GROUP BY parpr.produccion_id ) AS 'autores',
                
        #                         (SELECT GROUP_CONCAT(pc.palabra_clave SEPARATOR '; ') FROM eva.PALABRA_CLAVE_PRODUCCION pcpr 
        #                                 JOIN eva.PALABRA_CLAVE pc ON pc.id = pcpr.palabra_clave_id
        #                                 WHERE pcpr.produccion_id = pr.id GROUP BY pcpr.produccion_id)  AS 'palabras_clave',

        #          COALESCE(prlib.is_autor, prcap.is_autor) AS 'es_autor',
                 
        #          COALESCE(prlib.is_editor_compilador, prcap.is_editor_compilador) AS 'es_editor_compilador',
                 
        #          COALESCE(prlib.is_revisor, prcap.is_revisor) AS 'es_revisor',

        #          COALESCE(pra.resumen,prlib.resumen,prcap.resumen,prcon.resumen,tesis.resumen) AS 'resumen',
        #                 campod.campo_disciplinar,
                 
        #          COALESCE(pra.link_archivo_fulltext, prcap.link_archivo_fulltext, prcon.link_archivo_fulltext, prlib.link_archivo_fulltext, otra.link_archivo_fulltext, tesis.link_archivo_fulltext) AS 'link_archivo_fulltext'

        #          FROM eva.TRAMITE tr JOIN eva.PRODUCCION_TRAMITE prtr ON tr.id = prtr.tramite_id		
                 
	#          JOIN eva.PRODUCCION pr ON pr.id = prtr.produccion_id							
        #          JOIN eva.TIPO_PRODUCCION tpr ON tpr.id = pr.tipo_produccion_id
	#          INNER JOIN eva.PRODUCCION_CAMPO_DISCIPLINAR pcad ON pcad.produccion_id = pr.id
	#          INNER JOIN eva.CAMPO_DISCIPLINAR campod ON campod.id = pcad.campo_disciplinar_id

	#          LEFT JOIN eva.PR_ARTICULO pra ON pra.produccion_id = pr.id

	#          LEFT JOIN eva.PR_LIBRO prlib ON prlib.produccion_id = pr.id

        #          LEFT JOIN eva.PR_CAPITULO_LIBRO prcap ON prcap.produccion_id = pr.id
        #          LEFT JOIN eva.TIPO_PARTE_LIBRO tpl ON tpl.id = prcap.tipo_parte_libro_id

        #          LEFT JOIN eva.PR_CONGRESO prcon ON prcon.produccion_id = pr.id
        #          LEFT JOIN eva.TIPO_REUNION tre ON tre.id = prcon.tipo_reunion_id

	#          LEFT JOIN eva.PR_TESIS tesis ON tesis.produccion_id = pr.id
	#          LEFT JOIN eva.GRADO_ACADEMICO gacad ON gacad.id = tesis.grado_academico_id

	#          LEFT JOIN eva.PR_OTRA_PRODUCCION otra ON otra.produccion_id = pr.id

	#          LEFT JOIN eva.PAIS paisEdicion ON paisEdicion.id = pra.pais_edicion_id OR paisEdicion.id = prlib.pais_edicion_id OR paisEdicion.id = prcap.pais_edicion_id OR paisEdicion.id = prcon.pais_evento_id OR paisEdicion.id = otra.pais_id
	#          LEFT JOIN eva.IDIOMA idioma ON idioma.id = pra.idioma_id OR idioma.id = prlib.idioma_id OR idioma.id = prcap.idioma_id OR idioma.id = prcon.idioma_id OR idioma.id = tesis.idioma_id OR idioma.id = otra.idioma_id
    
        #          WHERE 1 = 1
	#          AND (tr.codigo = '$proc' AND prtr.es_ignorado = 0)  			
    
	#          AND (pr.tipo_produccion_id = $type)
	#          AND (prcon.publicado = 1 OR pr.tipo_produccion_id != 4)";

        $stmt = "SELECT pr.id, tr.codigo, tpr.tipo_produccion, pr.produccion AS 'titulo', idioma.idioma, paisEdicion.pais AS pais,
                
                COALESCE(pra.lugar_edicion, prlib.lugar_edicion, prcap.lugar_edicion, otra.ciudad, prcon.lugar_publicacion) AS 'ciudad',

                COALESCE(pra.publicado,prlib.publicado,prcap.publicado,prcon.publicado) AS 'publicado',
 
                COALESCE(pra.editorial, prlib.editorial, prcap.editorial, prcon.editorial) AS 'editorial',
                
                COALESCE(pra.web,prlib.web, prcap.web, tesis.web, otra.web, prcon.web) AS 'web',
                 
                COALESCE(pra.anio_publica, prlib.anio_publica, prcap.anio_publica, tesis.anio, otra.anio, prcon.anio_publica) AS 'anio', 
                 
                COALESCE(pra.mes_publica) AS 'mes',
                
                -- ARTICULO
                
                pra.issn AS ISSN_articulo,
		pra.eissn AS EISSN_articulo,
		pra.publicado AS Estado,
		-- pra.area,
                pra.volumen AS Volumen_articulo,
                pra.tomo AS Tomo_articulo,
                pra.numero AS Numero_articulo,
                pra.tipo_referato_id AS Referato_articulo,
                CONCAT( IF(revistaArticulo.issn IS NOT NULL,CONCAT('ISSN: ', revistaArticulo.issn, ' - '),''),
                IF(revistaArticulo.eissn IS NOT NULL,CONCAT('- E-ISSN: ', revistaArticulo.eissn, ' - '),''),
                revistaArticulo.publicacion) AS revista,
                pra.revista AS 'otra_revista', -- NUEVO
                pra.pagina_inicial AS Pagina_inicial_articulo, -- NUEVO
                pra.pagina_final AS Pagina_final_articulo, -- NUEVO
                pra.doi AS DOI_articulo, -- NUEVO
                
                -- LIBRO
 
                prlib.cantidad_volumenes,
                prlib.total_paginas_libro,
                prlib.isbn,
                prlib.referato AS Referato_libro, -- NUEVO
                
                -- PARTE LIBRO
 
                tpl.tipo_parte_libro,
                prcap.isbn,
                prcap.titulo_libro,
                prcap.pagina_inicial,
                prcap.pagina_final,
                prcap.volumen,
                prcap.tomo,
                prcap.numero,
                prcap.total_paginas_libro,
                prcap.referato AS Referato_capitulo,

                -- TRABAJOS EN Ev CyT
        
                tTrabajo.tipo_trabajo, -- NUEVO
                tPublicacion.tipo_publicacion, -- NUEVO
                prcon.titulo_publicacion AS 'titulo_revista', -- NUEVO
                prcon.isbn_issn, -- NUEVO
                prcon.reunion_cientifica,
                tre.tipo_reunion,
                prcon.alcance_internacional,
                prcon.alcance_nacional,
                paisEvento.pais AS 'pais_evento', -- NUEVO
                prcon.lugar_reunion AS 'ciudad_evento', -- NUEVO
                prcon.mes_reunion, -- NUEVO
                prcon.anio_reunion, -- NUEVO
                prcon.institucion_organizadora,

                -- TESIS               

                gacad.grado_academico,
                tesis.titulo_obtenido,
                tesis.fecha_defensa,  -- NUEVO

                COALESCE(directorTesis.apellido, otroDirectorTesis.apellido) AS 'apellido_director', -- NUEVO

                COALESCE(directorTesis.nombre, otroDirectorTesis.nombre) AS 'nombre_director', -- NUEVO

                COALESCE(directorTesis.cuil, otroDirectorTesis.cuil) AS 'cuil_director', -- NUEVO

                COALESCE(coDirectorTesis.apellido, otroCoDirectorTesis.apellido) AS 'apellido_codirector', -- NUEVO

                COALESCE(coDirectorTesis.nombre, otroCoDirectorTesis.nombre) AS 'nombre_codirector', -- NUEVO

                COALESCE(coDirectorTesis.cuil, otroCoDirectorTesis.cuil) AS 'cuil_codirector', -- NUEVO
                
                -- OTRAS
        
                otra.issn,
                otra.isbn,
                otra.total_paginas,
                tipoOtraProd.tipo_otra_produccion, -- NUEVO
                otra.otro_tipo_otra_produccion, -- NUEVO
                
                        -- AUX
                        -- () MEDIO DIFUSION
        
                (SELECT GROUP_CONCAT(tso.tipo_soporte SEPARATOR '; ') FROM eva.PRODUCCION_TIPO_SOPORTE prtso
                        JOIN eva.TIPO_SOPORTE tso ON tso.id = prtso.tipo_soporte_id
                WHERE prtso.produccion_id = pr.id GROUP BY prtso.produccion_id) AS 'medios_difusion',
        
                -- () AUTORES
        
                (SELECT GROUP_CONCAT(par.participacion SEPARATOR '; ') FROM PARTICIPACION_PRODUCCION parpr 
                        JOIN PARTICIPACION par ON par.id = parpr.participacion_id
                        WHERE parpr.produccion_id = pr.id AND parpr.tipo_participacion_produccion_id = 1 GROUP BY parpr.produccion_id ) AS 'autores',
        
                -- () Compiladores editores u organizadores
        
                (SELECT GROUP_CONCAT(par.participacion SEPARATOR '; ') FROM PARTICIPACION_PRODUCCION parpr 
                        JOIN PARTICIPACION par ON par.id = parpr.participacion_id
                        WHERE parpr.produccion_id = pr.id AND parpr.tipo_participacion_produccion_id <> 1 GROUP BY parpr.produccion_id ) AS 'editores_compiladores_organizadores', -- NUEVO
        
                -- () PALABRA CLAVE
        
                (SELECT GROUP_CONCAT(pc.palabra_clave SEPARATOR '; ') FROM eva.PALABRA_CLAVE_PRODUCCION pcpr 
                        JOIN eva.PALABRA_CLAVE pc ON pc.id = pcpr.palabra_clave_id
                        WHERE pcpr.produccion_id = pr.id GROUP BY pcpr.produccion_id)  AS 'palabras_clave',

                COALESCE(prlib.is_autor, prcap.is_autor) AS 'es_autor',
                
                COALESCE(prlib.is_editor_compilador, prcap.is_editor_compilador) AS 'es_editor_compilador',
                
                COALESCE(prlib.is_revisor, prcap.is_revisor) AS 'es_revisor',

                COALESCE(pra.resumen,prlib.resumen,prcap.resumen,prcon.resumen,tesis.resumen) AS 'resumen',
                        campod.campo_disciplinar AS area,
                
                COALESCE(pra.link_archivo_fulltext, prcap.link_archivo_fulltext, prcon.link_archivo_fulltext, prlib.link_archivo_fulltext, otra.link_archivo_fulltext, tesis.link_archivo_fulltext) AS 'link_archivo_fulltext'

                FROM eva.TRAMITE tr	JOIN eva.PRODUCCION_TRAMITE prtr ON tr.id = prtr.tramite_id		/*BusquedaxTramite*/
                        JOIN eva.PRODUCCION pr ON pr.id = prtr.produccion_id							/*BusquedaxTramite*/
                -- FROM eva.PERSONA per	JOIN eva.PRODUCCION pr ON pr.persona_id = per.id			/*BusquedaxPersona*/
                
                JOIN eva.TIPO_PRODUCCION tpr ON tpr.id = pr.tipo_produccion_id
                INNER JOIN eva.PRODUCCION_CAMPO_DISCIPLINAR pcad ON pcad.produccion_id = pr.id
                INNER JOIN eva.CAMPO_DISCIPLINAR campod ON campod.id = pcad.campo_disciplinar_id

                -- ARTICULO
                
                LEFT JOIN eva.PR_ARTICULO pra ON pra.produccion_id = pr.id
                LEFT JOIN eva.PUBLICACION revistaArticulo ON pra.publicacion_id = revistaArticulo.id

                -- LIBRO
                
                LEFT JOIN eva.PR_LIBRO prlib ON prlib.produccion_id = pr.id

                -- PARTE LIBRO
                
                LEFT JOIN eva.PR_CAPITULO_LIBRO prcap ON prcap.produccion_id = pr.id
                LEFT JOIN eva.TIPO_PARTE_LIBRO tpl ON tpl.id = prcap.tipo_parte_libro_id

                -- TRABAJOS EN Ev CyT
                
                LEFT JOIN eva.PR_CONGRESO prcon ON prcon.produccion_id = pr.id
                LEFT JOIN eva.TIPO_REUNION tre ON tre.id = prcon.tipo_reunion_id
                LEFT JOIN eva.PAIS paisEvento ON paisEvento.id = prcon.pais_evento_id
                LEFT JOIN eva.TIPO_PUBLICACION tPublicacion ON tPublicacion.id = prcon.tipo_publicacion_id
                LEFT JOIN eva.TIPO_TRABAJO tTrabajo ON tTrabajo.id = prcon.tipo_trabajo_id

                -- TESIS
                
                LEFT JOIN eva.PR_TESIS tesis ON tesis.produccion_id = pr.id
                LEFT JOIN eva.GRADO_ACADEMICO gacad ON gacad.id = tesis.grado_academico_id
                LEFT JOIN eva.PRODUCCION_MIEMBRO_PARTICIPANTE pmpDirectorTesis ON pmpDirectorTesis.produccion_id = tesis.produccion_id AND pmpDirectorTesis.tipo_funcion_id = 13
                LEFT JOIN eva.PERSONA directorTesis ON directorTesis.id = pmpDirectorTesis.persona_id
                LEFT JOIN eva.OTRA_PERSONA otroDirectorTesis ON otroDirectorTesis.id = pmpDirectorTesis.otra_persona_id
                LEFT JOIN eva.PRODUCCION_MIEMBRO_PARTICIPANTE pmpCoDirectorTesis ON pmpCoDirectorTesis.produccion_id = tesis.produccion_id AND pmpCoDirectorTesis.tipo_funcion_id = 14
                LEFT JOIN eva.PERSONA coDirectorTesis ON coDirectorTesis.id = pmpCoDirectorTesis.persona_id
                LEFT JOIN eva.OTRA_PERSONA otroCoDirectorTesis ON otroCoDirectorTesis.id = pmpCoDirectorTesis.otra_persona_id
                
                -- OTRA PRODUCCION
                
                LEFT JOIN eva.PR_OTRA_PRODUCCION otra ON otra.produccion_id = pr.id
                LEFT JOIN eva.TIPO_OTRA_PRODUCCION tipoOtraProd ON tipoOtraProd.id = otra.tipo_otra_produccion_id

                -- AUX
                
                LEFT JOIN eva.PAIS paisEdicion ON paisEdicion.id = pra.pais_edicion_id OR paisEdicion.id = prlib.pais_edicion_id OR paisEdicion.id = prcap.pais_edicion_id OR paisEdicion.id = prcon.pais_edicion_id OR paisEdicion.id = otra.pais_id
                LEFT JOIN eva.IDIOMA idioma ON idioma.id = pra.idioma_id OR idioma.id = prlib.idioma_id OR idioma.id = prcap.idioma_id OR idioma.id = prcon.idioma_id OR idioma.id = tesis.idioma_id OR idioma.id = otra.idioma_id
        
                WHERE 1 = 1
                AND (tr.codigo = '$proc' AND prtr.es_ignorado = 0)  			/*BusquedaxTramite*/
                -- AND (per.cuil = '20295352494' AND pr.fecha_fin_vigencia IS NULL)			/*BusquedaxPersona*/
                -- AND (pra.produccion_id = 517382)
                AND (pr.tipo_produccion_id = $type) -- IN (1,3,2,4,7,8))
                AND (prcon.publicado = 1 OR pr.tipo_produccion_id != 4) -- para Trabajos en eventos cientificos publicados publicados";                 

        return $stmt;

}

sub herbarium_stmt {

        my $stmt;

        $stmt = "SELECT * FROM herbarium.tipos";

        return $stmt;
}
                        
1;

