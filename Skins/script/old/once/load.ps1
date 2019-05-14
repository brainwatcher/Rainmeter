cd $env:Rainmeter
$text= Get-Content .\Rainmeter.ini
$text += "[illustro\icon\$add_name]"
$text += "Active=1
WindowX=0
WindowY=0
ClickThrough=0
Draggable=1
SnapEdges=1
KeepOnScreen=1
AlwaysOnTop=0"
Set-Content -Path .\Rainmeter.ini -Value $text