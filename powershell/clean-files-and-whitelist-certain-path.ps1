$limit = (Get-Date).AddDays(-2)
$path = "SomePath"

#Deletes files older than X Days from Path and whitelist folders and files that can't be touched.  
Get-ChildItem -Path $path -Force -Recurse | Where-Object {!_.PSIsContainer -and $_.CreationTime -lt $limit} | ?{$_.FullName -CNotmatch "test.*|test2.*"} | Remove-Item -Force
