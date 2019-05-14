$label=2
cd $env:Rainmeter
$list= Get-content .\list$label.csv
$list += $add_name
Set-Content -Path .\list$label.csv -Value $list