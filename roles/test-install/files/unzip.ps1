Param($file, $destination)

$shell = new-object -com shell.application
$zip = $shell.NameSpace($file)
foreach($item in $zip.items())
{
  # 0x14 is a copy flag to overwrite existing.
  $shell.Namespace($destination).copyhere($item, 0x14)
}
