# Regex based find and replace on a given file. It uses .NET from PowerShell.
Param($file, $find, $replace)

$content = [System.IO.File]::ReadAllText($file)
$content = [System.Text.RegularExpressions.Regex]::Replace($content, $find, $replace)
[System.IO.File]::WriteAllText($file, $content)
