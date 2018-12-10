# Internacionalización i18n con Harbour

Pequeña guía para implementar multilenguaje en sus aplicaciones Harbour. 
>Se facilita estructura de proyecto y código para mayor facilidad de comprensión. 
>El esquema es orientativo y susceptible a mejoras. Sugerencias, como siempre, son bienvenidas :))

- Para empezar, definimos una macro para poder implementar cambios globales de forma unitaria. Este ejemplo transforma también la cadena a UTF8
  - `#define _txt( x ) hb_UTF8ToStr( hb_i18n_gettext(x) )`
- Preparar nuestro código :
  - En Harbour : `@ 2,1 SAY _txt("Editar")`
  - En Fivewin : `REDEFINE SAY VAR _txt("Editar") ID 200 OF oDlg`
- Compilar fuente para obtener salida en formato *.pot
  - `harbour -m -n -j app.prg`
- Descargar poedit, herramienta gratuita de edición y traducción : 		https://poedit.net/download
- Ejecutar poedit y crear nueva traducción, **Archivo-> Nueva desde archivo POT/PO**
- La primera vez que ejecutemos poedit, nos pedirá el idioma base de traducción
    - Elegir la plantilla *app.pot* generada en el proceso de compilación de Harbour
    - Poedit nos pregunta por el idioma de traducción

    ![](https://github.com/QuimFerrer/i18n/blob/master/po/poedit1.png)
- Empezar con las traducciones
    ![](https://github.com/QuimFerrer/i18n/blob/master/po/poedit2.png)

- Guardar traducción, por ejemplo para idioma inglés *en.po* 
- Vemos que también genera el archivo **.mo* que no vamos a utilizar
- Una vez finalizada(s) la(s) traducción(es) es el momento de generar el binario del idioma o idiomas que cargaremos en nuestra aplicación. Para ello disponemos del superpoder de hbmk2.exe, utilidad make de Harbour. 
    - `hbmk2 -hbl en.po`
- La utilidad crea el archivo *en.hbl* a partir de *en.po*
- Ya sólo nos queda implementarlo en nuestra aplicación :
```php
cFile := hb_MemoRead( "en.hbl" )
if hb_i18n_Check( cFile )
  hb_i18n_Set( hb_i18n_RestoreTable(cFile) )
endif
```
- Con este procedimiento, todos los literales en código fuente quedan traducidos y si queremos cambiar de idioma en tiempo de ejecución, basta con apuntar a otro set de idioma, llamando a las instrucciones anteriores.
- Cada vez que exista un cambio en nuestro código, solamente habrá que generar de nuevo el archivo de plantilla **.pot*, abrir cada archivo de idioma **.po* y desde la opción del menú de poedit, **Catálogo->Actualizar desde archivo POT**. Los cambios anteriores permanecen intactos y las nuevas entradas quedan pendientes de traducir, con facilidad para buscarlas.
- Para terminar, os animo a investigar, mejorar y comentar, experiencias que tengáis en la internacionalización y  traducción de vuestras creaciones.
