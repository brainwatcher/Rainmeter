cd $env:Skinpath\script
. .\inputbox.ps1 
cd ..
($add_name,$add_exe,$add_label)=inputbox
if ($add_label -eq "Left") { $label=1}
elseif ($add_label -eq "Right") { $label=2}
else { throw "No choice of glass"}
#$add_name="Core Temp";
#$add_exe="C:\Program Files\Core Temp\Core Temp.exe";
cd .\illustro\icon
$default_dir=dir;
$default_name=$default_dir.name;
if (-not $default_name.Contains($add_name))
    { 
    New-item $add_name -ItemType Directory;
    }
cd $env:Skinpath\illustro\@*
$icon=dir -Filter "$add_name*" | Select-Object name
if (-not $icon.Name.count -eq 1)
    { 
    [System.Windows.MessageBox]::Show('You need icon for $add_name')
    }
cd $env:Skinpath\illustro\icon\$add_name
$text=Get-content -Path $env:Skinpath\illustro\icon\chrome\chrome.ini
$text=$text.Replace('Chrome.png',$icon.Name)
$text=$text.Replace('C:\Program Files (x86)\Google\Chrome\Application\chrome.exe',"$add_exe")
$text | out-file "$add_name.ini"
cd $env:Skinpath

$list = @(@(Import-Excel details.xlsx ))
$add_list= @(New-Object System.Object)
$add_list | Add-Member -type NoteProperty -name label -Value $label 
$add_list| Add-Member -type NoteProperty -name name -Value $add_name 
$add_list| Add-Member -type NoteProperty -name link -Value $add_exe 
$list0=$list | Where-Object -Property label -eq -Value 1
$sort0=($list0.sort |Measure -Max).Maximum
$add_list| Add-Member -type NoteProperty -name sort -Value ($sort0+1) -Force

$list += $add_list
Remove-Variable add_list
$list | Export-Excel details.xlsx 
Start-Process -FilePath "C:\Users\brainwatcher\Documents\Rainmeter\Skins\Rainmeter.exe" -ArgumentList "!RefreshApp"
#"C:\Program Files\Rainmeter\Rainmeter.exe" !ActivateConfig "illustro\Clock" "Clock.ini"
$x1="!ActivateConfig"
$x2='"'+"illustro\icon\$add_name"+'"'
$x3='"'+"$add_name.ini"+'"'
Start-Process -FilePath "C:\Users\brainwatcher\Documents\Rainmeter\Skins\Rainmeter.exe" -ArgumentList $x1,$x2,$x3
& .\script\align.ps1


