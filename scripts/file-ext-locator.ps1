param(
    [string]$targetPath = ".\",
    [string]$ext = "ps1"
)

$date = Get-Date
$epoch = ([System.DateTimeOffset]$date).ToUnixTimeSeconds()
$fileName = ".\File-Report-" + $epoch + ".csv"

Get-ChildItem -Path $targetPath -Recurse -Filter "*.$ext" |
Select-Object FullName, Length, LastWriteTime |
ConvertTo-Csv | 
Out-File $fileName