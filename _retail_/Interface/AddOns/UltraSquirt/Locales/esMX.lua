--localization file for Spanish (Mexico)
local L = LibStub("AceLocale-3.0"):NewLocale("UltraSquirt", "esMX")

if not L then return end

L["Keybind Missing"] = "El enlace de teclas no está establecido"
L["Cannot Modify In Battle"] = "No se puede modificar el NPC de batalla de mascotas objetivo durante una batalla de mascotas: inténtalo de nuevo cuando termine la batalla"
L["Invalid Target"] = "Objetivo no válido: selecciona un NPC de batalla de mascotas repetible válido e inténtalo de nuevo"
L["Addon Enabled"] = "Addon habilitado"
L["Addon Disabled"] = "Addon deshabilitado"
L["Resetting Options"] = "Restablecimiento de las opciones del complemento y la posición de la ventana"
L["Resetting Options OOC"] = "Las opciones se restablecerán cuando termine el combate"
L["General Settings Group"] = "Configuración general"
L["Delay Settings Group"] = "Configuración de retardo"
L["Delay Settings Description"] = "La siguiente configuración le permite personalizar los temporizadores de retardo utilizados.  Los valores predeterminados deberían funcionar en la gran mayoría de los casos.  Si tiene una latencia alta, o de lo contrario se encuentra con problemas en los que el complemento se cura inesperadamente, intente aumentar los tiempos ligeramente."
L["Rematch Load Team Delay Setting"] = "Retraso del equipo de carga de revancha"
L["Rematch Load Team Delay Description"] = "Al usar las opciones de revancha \"Cargar mascotas más saludables\" y \"Después de las batallas de mascotas también\", después de que se complete una batalla de mascotas, el complemento detendrá cualquier acción adicional mientras Rematch carga un nuevo equipo.  Esto debería tomar 1 o 2 segundos como máximo.  Si se ajusta esta configuración, se cambiará el retraso máximo permitido."
L["Pet Battle Close Delay Setting"] = "Retraso de cierre de batalla de mascotas"
L["Pet Battle Close Delay Description"] = "Después de que se complete una batalla de mascotas, el complemento se retrasará por un corto período para permitir que el juego actualice el estado y la salud de las mascotas cargadas.  Cambie este valor para aumentar o disminuir el retraso máximo.  Esto solo se aplica mientras no se usan las opciones de revancha \"Cargar mascotas más saludables\" y \"Después de las batallas de mascotas también\"."
L["Heal Delay Setting"] = "Retraso de la curación"
L["Heal Delay Description"] = "Después de curar a sus mascotas con un vendaje o Revice Battle Pets, el complemento se retrasará por un corto período para permitir que el juego se actualice.  Cambie este valor para aumentar o disminuir el retraso máximo."
L["Help Header"] = "Comandos de barra diagonal disponibles:"
L["Help Default"] = "Alterna la ventana principal de UltraSquirt."
L["Help Config"] = "Mostrar panel de configuración."
L["Help Advanced"] = "Mostrar panel Equipos avanzados."
L["Help Reset"] = "Restablezca todas las configuraciones de UltraSquirt y las posiciones de las ventanas a los valores predeterminados."
L["Help Help"] = "Muestre esta lista de comandos disponibles."
L["Invalid Command"] = "Comando no válido."
L["Team Name"] = "Nombre del equipo"
L["Mute Addon Enabled and Disabled Messages"] = "Silenciar mensajes habilitados y deshabilitados del complemento"
