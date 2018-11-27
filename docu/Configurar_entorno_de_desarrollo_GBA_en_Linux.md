#### Source: https://www.elotrolado.net/wiki/Configurar_entorno_de_desarrollo_GBA_en_Linux

*En este tutorial se enseña como configurar un entorno para empezar a desarrollar homebrew para la GameBoy Advance en un sistema operativo GNU/Linux.

*Hay muchas opciones a la hora de elegir un entorno, pero la principal es devkitPro y el compilador multiplataforma ARM devkitARM.

*Necesitaremos las siguientes herramientas:
::*DevkitPro (DKP)
::*DevkitARM (DKA)
::*Un IDE donde escribir nuestro código (en este tutorial se enseñará a configurar [http://www.eclipse.org/ Eclipse]).
::*Un emulador de GameBoy Advance (en este tutorial se usará [http://vba.ngemu.com/ VisualBoy Advance], podemos instalarlo desde los repositorios de la distribución).


==Instalacion==

===DevkitPro===
*[http://sourceforge.net/projects/devkitpro DevkitPro] es un paquete que contiene compiladores para unos cuantos sistemas (incluido la GBA), librearías, códigos de ejemplo, etc. DevkitARM es un compilador multiplataforma ARM, basado en el conjunto de herramientas GCC.

*Pasos para la instalación de devkitPro:
:#Creamos un directorio llamado <code style="color:black;">devkitPro</code>.
:#Descargamos devkitARM de su [http://sourceforge.net/projects/devkitpro/files/devkitARM/ web] y lo descomprimimos dentro del directorio <code style="color:black;">devkitPro</code>.
:#Descargamos libgba (el cual es un conjunto de tipos básicos, macros y funciones) de su [http://sourceforge.net/projects/devkitpro/files/libgba/ web], lo descomprimimos dentro del directorio <code style="color:black;">devkitPro</code> y renombramos su directorio a <code style="color:black;">libgba</code>.
:#Descargamos los ejemplos de GBA (un conjunto de proyectos de ejemplo usando libgba) de su [http://sourceforge.net/projects/devkitpro/files/examples/gba/ web], lo descomprimimos dentro del directorio <code style="color:black;">devkitPro</code> y renombramos su directorio a <code style="color:black;">gba-examples</code>.

'''NOTA''': No useis espacios en la rutas, ya que GCC hace uso del conjunto de herramientas GCC, las cuales no admiten bien el uso de espacios en las rutas.

*Al final deberá quedarte una estructura de directorios tal que así:

{| style="margin:10px 0 0 0;"
|-
|[[Imagen:Estructura_directorios_linux_-_Scene_GBA.png]]
|}

===Crear las variables de entorno===
*Si intentáis construir cualquier cosa usando los comandos dados anteriormente, probablemente descubriréis que no funciona. Para que la consola pueda ejecutar comandos, necesita primero encontrar la ruta del mismo. La ruta completa necesita ser visible para la consola, no solo el nombre del archivo.

*Editamos con un editor de textos el archivo:
<pre>~/.bashrc</pre>


*Y añadimos al final del archivo lo siguiente:
<pre>export DEVKITPRO=/ruta/al/devkitPro
export DEVKITARM=$DEVKITPRO/devkitARM
export PATH=$DEVKITARM/bin:$PATH</pre>
donde <code style="color:black;">/ruta/al/devkitPro</code> es donde hayamos creado el directorio <code style="color:black;">devkitPro</code>.


*Ahora ejecutamos en un terminal:
<pre>$ source ~/.bashrc</pre>
en bash, el comando <code style="color:black;">source</code> lee instrucciones bash de un archivo y las ejecuta como si estuvieran dentro del fichero desde donde se usa el comando <code style="color:black;">source</code>.


*Para comprobar que las rutas son correctas, ejecutamos en un terminal:
<pre>$ echo $PATH</pre>


*'''NOTA''': este metodo solo sirve para ese usuario en cuestion, para que sea aplicable a todos habría que añadir las rutas en el archivo <code style="color:black;">/etc/environment</code>.

===Construir proyectos===

*Una vez configuradas las variables de entorno ya estamos listos para empezar a construir nuestros proyectos.

*Como test vamos a construir un ejemplo de los que descargamos antes, debería estar alojado en la siguiente ruta:
<pre>$DEVKITPRO/gba-examples/template</pre>


*Para ello ejecutamos en un terminal:
<pre>$ cd $DEVKITPRO/gba-examples/template
$ make</pre>


*Si todo ha salido bien nos deberá aparecer:

<pre>template.c
arm-eabi-gcc -MMD -MP -MF /home/ealdor/gbadev/devkitPro/gba-examples/template/build/template.d 
     -g -Wall -O3 -mcpu=arm7tdmi -mtune=arm7tdmi -fomit-frame-pointer -ffast-math -mthumb -mthumb-interwork  
     -I/home/ealdor/gbadev/devkitPro/libgba/include -I/home/ealdor/gbadev/devkitPro/gba-examples/template/build                                
     -c /home/ealdor/gbadev/devkitPro/gba-examples/template/source/template.c -o template.o 
linking multiboot
built ... template_mb.gba
ROM fixed!</pre>


*Ahora deberemos tener un archivo <code style="color:black;">template_mb.gba</code>. Cuando abráis este archivo en el VBA (VisualBoy Advance), no$gba u otro emulador de la GBA deberíais ver algo parecido a la imagen de abajo:

{| style="margin:10px 0 0 0;"
|-
|[[Imagen:Ejecucion_template_vba_-_Scene_GBA.png]]
|}

==Eclipse==
*Ahora vamos a ver como se puede configurar el Eclipse para poder utilizarlo como IDE a la hora de crear nuestros proyectos.

*Descargamos "Eclipse IDE for C/C++ Developers", de su [http://www.eclipse.org/downloads/ web] o si ya tenéis el Eclipse instalado podemos descargar el plugin [http://www.eclipse.org/cdt/ CDT] el cual nos permitirá trabar con C/C++.

*Una vez ejecutado el Eclipse nos dirigimos al menú "Run -> External Tools -> External Tools Configuration". En la parte izquierda seleccionad "Program" y darle al botón de "New Launch Configuration" (se encuentra en la parte superior). Ahora id a la pestaña "Main" y en "Name" poned <code style="color:black;">VisualBoy Advance Run</code>. Ahora dirigios a la opción "Location", "Browse File System" y selecciona el ejecutable del VisualBoy Advance (por ejemplo, /usr/bin/VisualBoyAdvance). En el apartado de "Arguments" ponemos <code style="color:black;">${project_loc}/${selected_resource_name}</code> (sin las comillas). Ahora nos dirijimos a "Run -> External Tools -> Organize Favorites" y añadimos la que acabamos de crear.

*Ahora debemos definir las variables de entorno en Eclipse (ya que Eclipse no utiliza las variables de entorno del usuario en Linux, o al menos a mi no me las reconoce), para ello nos dirijimos a "Windows -> Preferences -> C/C++ -> Build -> Enviroment" y presionamos en "Add". Las dos que debemos crear son:
::*'''Name''': DEVKITPRO, '''Value''': ruta/al/directorio/devkitPro (por ejemplo, /home/ealdor/gbadev/devkitPro).
::*'''Name''': DEVKITARM, '''Value''': ${DEVKITPRO}/devkitARM

===Creando un proyecto===
*Una vez configurado el Eclipse vamos a importar un proyecto y comprobar que todo funciona correctamente. Para ellos presionamos en "File -> Import", seleccionamos "C/C++" y elegimos "Existing Code as Makefile Project". En "Existing Code Location" presionamos en "Browse" y nos dirijimos a donde teniamos el directorio con los ejemplos de la GBA que antes descargamos y al proyecto <code style="color:black;">template</code> (por ejemplo, /home/ealdor/gbadev/devkitPro/gba-examples/template) y presionamos en "Finish".

*Ahora para construir nuestro proyecto presionamos en "Proyect -> Build Proyect". Si todo ha ido bien deberemos tener los archivos <code style="color:black;">template.elf</code> y <code style="color:black;">template.gba</code>.

*Ahora elegimos el archivo <code style="color:black;">template.gba</code> y presionamos en el botón "VisualBoy Advance Run" localizado en la barra de herramientas del Eclipse (botón de play verde con un candado rojo).

*Opcionalmente podemos crear algunas "make targets" para construir el proyecto. Abrimos "Window -> Show View -> Make target", presionamos en nuestro proyeto y hacemos click en el icono de "Add Make Target". Podemos crear por ejemplo tres, ponemos en sus nombres: <code style="color:black;">build</code>, <code style="color:black;">clean</code> y <code style="color:black;">clean build</code> respectivamente.

==Links de interes==
*[http://forum.gbadev.org/viewtopic.php?t=5271 GBA Development with Eclipse IDE HOWTO]
*[http://devkitpro.org/ DevkitPro]
*[http://www.coranac.com/tonc/text/ TONC]

[[Categoría:Scene de GBA]]