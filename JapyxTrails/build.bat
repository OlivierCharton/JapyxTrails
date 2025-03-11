:: You must replace YOUR PACKS NAME and YOUR XMLS NAME in order to use
:: ex: del ".\TehsTrails.taco"

:: deletes existing pack
del ".\JapyxTrails.taco"

:: uses WinRar to create a zip out of \Data and \YOUR XML
"%ProgramFiles%\WinRAR\WinRAR.exe" a -afzip -ep1 -ibck -r -y ".\JapyxTrails.zip" ".\Data" ".\JapyxTrails.xml" ".\Pack.lua"

:: renames the zip to taco
rename "JapyxTrails.zip" "JapyxTrails.taco"

:: copy the taco to blish marker folder
copy "JapyxTrails.taco" "C:\Users\Olivier\Documents\Guild Wars 2\addons\Blish.HUD\settings\markers" /y

:: copy the taco to taco marker folder
copy "JapyxTrails.taco" "C:\Program Files\Guild Wars 2\Addons\GW2TacO_067r\POIs" /y
