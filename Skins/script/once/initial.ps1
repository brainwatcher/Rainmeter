#adjust wallpaper
cd $env:Skinpath
# set "cat_face" wallpaper 
$d=pwd
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value "$d\cat_face.jpg"
# make the wallpaper "fill"
Set-ItemProperty ‘HKCU:\Control Panel\Desktop’ -Name “WallpaperStyle” -Value 2
# refresh the desktop background
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters 1, True
# initial xlsx
#Install-Module -Name ImportExcel -RequiredVersion 5.4.0
cd $env:Skinpath
$add_link="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
$add_list= New-Object System.Object
$add_list | Add-Member -type NoteProperty -name label -Value 1 
$add_list| Add-Member -type NoteProperty -name name -Value "chrome"
$add_list| Add-Member -type NoteProperty -name link -Value $add_link 
$add_list| Add-Member -type NoteProperty -name sort -Value 1 -Force
$add_list | Export-Excel details.xlsx 
Remove-Variable add_list