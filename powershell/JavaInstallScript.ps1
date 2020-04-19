$JavaArguments = @('/i', "CHANGEME!", "/quiet", 'INSTALLDIR="CHANGEME!"')

Write-Host "Copying and Installing Java 8 onto $ENV:COMPUTERNAME"
Copy-Item -path 'somepath here' -Destination 'CHANGEME!' -Recurse
Start-Process "msiexec.exe" -ArgumentList $JavaArguments -Wait
Remove-Item 'SomeFile'

# Run Line 9 on powershell command prompt before you actually run powershell script to verify correct version numbers.
# Get-WmiObject Win32_Product -Filter "name like 'CHANGEME!%' AND vendor like 'CHANGEME!%' AND not version = 'CHANGEME!'"
# Command below will automatically restart VM after execution.
Get-WmiObject Win32_Product -Filter "name like 'CHANGEME!%' AND vendor like 'CHANGEME!%' AND not version = 'CHANGEME!'" | ForEach-Object { $_.Uninstall() }

# The msi package should set JAVA_HOME automatically but leaving it here just in case it doesn't.
# [System.Environment]::SetEnvironmentVariable("JAVA_HOME", 'CHANGEME!', [System.EnvironmentVariableTarget]::Machine)

Write-Host "Installing Certificate onto $ENV:COMPUTERNAME"
Copy-Item -path 'CHANGEME!' -Destination 'CHANGEME!' -Recurse -Force; keytool.exe -importcert -trustcacerts -file 'CHANGEME!' -keystore 'CHANGEME!' -storepass 'changeit' -alias 'CHANGEME!' -noprompt
Remove-Item 'CHANGEME!' -Force -Recurse