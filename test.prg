/**
 *************************************************************************************************
 * Internacionalizacion con Harbour
 * (C)2018 Joaquim Ferrer Godoy <quim_ferrer@yahoo.es>
 * v1.0 26-11-2018
 *************************************************************************************************

1) Extraer cadenas. Generar *.pot ( Portable Object Template ) en po/lang.pot
Se obtiene compilando los fuentes .prg con la opcion -j

	Ejemplo : harbour -jpo/lang mi.prg
	Genera archivo lang.pot en po/

Este proceso extrae todas las cadenas de texto contenidas por i18n() 
o sus alias (hb_i18n_gettext, gtxt) de mi.prg


2) Crear traducciones. Generar *.po ( Portable Object )
Se recomienda el editor gratuito poedit (https://poedit.net/) 
Archivo->Nueva desde archivo POT, abrir el archivo generado lang.pot y crear una nueva traducción. 
Poedit nos pide el lenguaje de traducción, seleccionamos y guardamos. 
Normalmente se sigue un patrón para nombres :
	Si el nombre generado en el paso 1 es lang.pot, los archivos de traducciones 
	son aconsejable llamarlos :	lang.es.po, lang.fr.po, etc.


3) Generar *.hbl
Harbour soporta el formato hbl (Harbour Language) propio, es un equivalente funcional 
a los archivos compilados *.mo de otros compiladores y realiza perfectamente su función


4) Llamada al lenguaje desde nuestra aplicación :
	hb_i18n_Set( hb_i18n_RestoreTable("hbl/lang.fr.hbl") )


5) Catalogo->Actualizar desde archivo POT


Utilidades
==========
- make_pot.bat: Llamada a Harbour para extraer todas las cadenas que sean llamadas por la
				funcion _txt() alias de hb_i18n_gettext() -> Paso 1

- Project.hbp :	Script hbmk2 para generacion de archivos *.hbl compilados para
				realizar la traducción -> Paso 3
				Consta de 2 flag importantes :
					-hbl=[destino a ubicar los *.hbl generados]
					-lng=[es,en,fr] lenguajes correspondientes a los archivos [lang.]es.po, [lang.]fr.po

Notas
=====
Si se utiliza harbour -j ... y la funcion i18n() en vez de hb_i18n_gettext() no se extraen las cadenas
Supongo que i18n() era de xHarbour y por compatibilidad se ha incluido, me pide enlazar con xhb.hbc

La utilidad make hbmk2 crea el formato de salida *.hbl de forma nativa, mediante los flag -hbl y -lng
Para utilizar otros sistemas make, harbour/bin dispone de la utilidad hbi18n.exe que tambien es capaz
de generar salida *.hbl a partir de *.po

Para no tener que crear y traducir a lenguaje en castellano, definir todas las cadenas sin
acentos, tanto en RC como en PRG. Servirá de base o indice para el resto de traducciones
**/

#define _txt( x ) 	hb_UTF8ToStr( hb_i18n_gettext(x) )

function main()

	local cFile

	cFile := hb_MemoRead( "hbl/lang.en.hbl" )
	
	if hb_i18n_Check( cFile )
		hb_i18n_Set( hb_i18n_RestoreTable(cFile) )
	endif

	// Las cadenas son como indices 
	// Si se crean con acentos poedit falla al crear la traduccion, p.e. _txt("Impresión")
	? _txt("Bienvenidos")
	? _txt("Nuevo")
	? _txt("Edicion")
	? _txt("Imprimir")

return NIL

//------------------------------------------------------------------------------------------------------//

