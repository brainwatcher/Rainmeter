#adjust wallpaper
cd $env:Skinpath
# set "cat_face" wallpaper 
$d=pwd
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value "$d\cat_face.jpg"
# make the wallpaper "fill"
Set-ItemProperty ‘HKCU:\Control Panel\Desktop’ -Name “WallpaperStyle” -Value 10
# refresh the desktop background Preblem!
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters 1, True