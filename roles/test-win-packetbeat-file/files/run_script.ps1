Param($script)

#$dir = Split-Path $script
#$filename = Split-Path -leaf $script

#Push-Location $dir
invoke-expression -Command $script
#Pop-Location
