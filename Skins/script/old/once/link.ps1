cd $env:Rainmeter
cd .\illustro\icon
$d=dir |Select-Object Name
$link=@()
$label=@(2,1,1,1,1,1,1,2,1,1,1,2,2,2,2,1,1,1,1,2,1,1,2,2)
$sort= @(1,1,2,3,4,5,6,2,7,8,9,3,4,5,6,10,11,12,13,7,14,15,8,9)
foreach ($i in 0 ..($d.Count-1))
{
    $filename=$d.name[$i]
    cd .\$filename
    $aa=Get-content -Path .\$filename.ini -Tail 1
    $link0=$aa.Substring($aa.IndexOf("[")+2,$aa.IndexOf("]")-$aa.IndexOf("[")-3)
    $d[$i] | Add-Member -type NoteProperty -name link -Value $link0 -Force
    $d[$i] | Add-Member -type NoteProperty -name label -Value $label[$i] -Force
    $d[$i] | Add-Member -type NoteProperty -name sort -Value $sort[$i] -Force
    cd ..
}

cd $env:Rainmeter
$d | Export-Excel .\details.xlsx 

