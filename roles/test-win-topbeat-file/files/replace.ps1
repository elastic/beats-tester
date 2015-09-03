Param($file, $regexp, $replace)

$content = Get-Content -path $file | Out-String
$content -Replace $regexp, $replace | Out-File $file
