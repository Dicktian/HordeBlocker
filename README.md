# HordeBlocker

**Versión 1.2 | World of Warcraft 3.3.5a**

HordeBlocker es un addon ligero que oculta automáticamente los mensajes en idioma orco enviados por la Horda a través de los canales **Decir (/say)** y **Gritar (/yell)** cuando juegas con un personaje de la Alianza.

## Características

- Filtrado automático, sin comandos ni configuración.
- Detección del idioma orco y sus etiquetas en el chat.
- Compatible con las ventanas de chat estándar.
- Sin bibliotecas externas ni interfaz adicional.

## Desarrollo

Creado en **Lua** con la API de World of Warcraft 3.3.5a. El proyecto consta de `HordeBlocker.lua`, que contiene el filtrado, y `HordeBlocker.toc`, que registra el addon y sus metadatos.

## Instalación

1. Descarga y descomprime el addon.
2. Si la carpeta extraída se llama HordeBlocker-main o HordeBlocker-1.2, elimina el sufijo -main o -1.2 para que quede HordeBlocker.
3. Copia la carpeta HordeBlocker en World of Warcraft/Interface/AddOns/, y asegúrate de que los archivos .toc y .lua estén directamente dentro de ella, sin carpetas adicionales.
4. Activa el addon desde Complementos e ingresa con un personaje de la Alianza.

**Compatibilidad:** World of Warcraft: Wrath of the Lich King (3.3.5a). El comportamiento puede variar según el servidor.

*Proyecto independiente, sin afiliación con Blizzard Entertainment.*
