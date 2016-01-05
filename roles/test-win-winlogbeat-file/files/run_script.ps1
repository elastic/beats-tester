# Workaround for lack of a "shell" module for Windows.
Param($script)

invoke-expression -Command $script
