:: You must replace YOUR PACKS NAME and YOUR XMLS NAME in order to use
:: ex: del ".\TehsTrails.taco"

:: deletes existing pack
del ".\JapyxTrails.taco"

:: uses WinRar to create a zip out of \Data and \YOUR XML
"%ProgramFiles%\WinRAR\WinRAR.exe" a -afzip -ep1 -ibck -r -y ".\JapyxTrails.zip" ".\Data" ".\JapyxTrails.xml"

:: renames the zip to taco
rename "JapyxTrails.zip" "JapyxTrails.taco"
