# get the monitor number
$screen_num=(Get-CimInstance -Namespace root\wmi -ClassName WmiMonitorBasicDisplayParams | where {$_.Active -like "True"}).Active.Count
# change monitor num in dual displays
if ($screen_num -eq 2) {$screen=0}
else {$screen=0}
# set parameter
Add-Type -AssemblyName System.Windows.Forms
$w=[System.Windows.Forms.Screen]::AllScreens.Bounds.Size[$screen].Width;
$h=[System.Windows.Forms.Screen]::AllScreens.Bounds.Size[$screen].Height;
$center= New-Object -TypeName 'float[,]' -ArgumentList 2,2
if ($env:UserName -eq "brainwatcher")
{
$center[0,0]=495/1440*$w+$screen*$w+12
$center[0,1]=410/900*$h
$center[1,0]=1030/1440*$w+$screen*$w-36
$center[1,1]=425/900*$h-3
$r=158/1698.1*[math]::Sqrt($w*$w+$h*$h)-10
}
if ($env:UserName -eq "admin")
{
$center[0,0]=495/1440*$w+$screen*$w
$center[0,1]=410/900*$h
$center[1,0]=1030/1440*$w+$screen*$w
$center[1,1]=425/900*$h
$r=158/1698.1*[math]::Sqrt($w*$w+$h*$h)
}
$edge=28
$part_num=24;
# process 
cd $env:Rainmeterini
$text = get-content -Path rainmeter.ini
cd ~\Documents
$list = Import-Excel details.xlsx 
$p_x= New-Object 'object[,]' 2,$part_num
$p_y= New-Object 'object[,]' 2,$part_num
foreach ($j in 0,1)
{
    foreach ($i in 0..($part_num-1))
    {
    $alpha=2*[math]::pi*(-$i/$part_num+1/4);
    $p_x[$j,$i]=[math]::sin($alpha)*$r+$center[$j,0];
    $p_y[$j,$i]=-[math]::cos($alpha)*$r+$center[$j,1];
    }
}
cd $env:Rainmeterini
foreach($i in 0..($list.Count-1))
{
    $part=$list[$i].Name
    $label=$list[$i].label
    $sort=$list[$i].sort
    $aa=Select-String -path .\Rainmeter.ini  -Pattern "\[illustro\\icon\\$part\]"
    $text[ $aa.LineNumber+1]="WindowX="+$p_x[($label-1),($sort-1)];
    $text[ $aa.LineNumber+2]="WindowY="+$p_y[($label-1),($sort-1)];
}
Set-Content -Path .\Rainmeter.ini -Value $text
#Set-Content -Path .\list1.csv -Value $list
Start-Process -FilePath $env:Rainmeterexe -ArgumentList "!RefreshApp"