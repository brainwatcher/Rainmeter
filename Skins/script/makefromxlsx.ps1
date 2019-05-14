Set-Location $env:Skinpath
$list = @(@(Import-Excel details.xlsx ))
Set-Location $env:Skinpath\illustro\icon
foreach ($i in 0..($list.Count-1))
{ 
    $file=$list[$i].name
    if (-not (Test-Path -Path $file)) {New-item -Name $file -ItemType Directory}
    Set-Location -Path  .\$file
    $inifile=$file + ".ini"
    if (Test-Path -Path $inifile) {remove-item -Path $inifile -Force}
    $exe= $list[$i].link
    $text="[MeterLaunch1Image]`nMeter=Image`nImageName=#@#$file.png`nW=28`nH=28`nX=0r`nY=2R"
    $text=$text + "`nLeftMouseUpAction=[""$exe""]"
    add-content -Path $inifile -value $text
    # rainmeter
    $x1="!ActivateConfig"
    $x2='"'+"illustro\icon\$file"+'"'
    $x3='"'+"$inifile"+'"'
    Start-Process -FilePath $env:Rainmeterexe -ArgumentList $x1,$x2,$x3
    Start-Sleep -s 0.5
    
    cd $env:Skinpath\illustro\icon
}

Start-Process -FilePath $env:Rainmeterexe -ArgumentList "!RefreshApp"
