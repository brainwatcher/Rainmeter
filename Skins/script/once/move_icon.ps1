#move icon
cd $env:Rainmeter
$list1= Get-content .\list1.csv
$list2= Get-Content .\list2.csv

$mark=$list1.Length-2;
$list2 += $list1[$mark]
$list= $list1[0..($mark-1)] ;
$list += $list1[($mark+1)..$list1.Length]
$list1=$list
Set-Content -Path .\list1.csv -Value $list1
Set-Content -Path .\list2.csv -Value $list2