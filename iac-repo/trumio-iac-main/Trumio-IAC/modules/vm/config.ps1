# Configure WinRM to use HTTP
winrm quickconfig -transport:http

# Create a new firewall rule for WinRM over HTTP
New-NetFirewallRule -Name "WinRM over HTTP" -DisplayName "WinRM over HTTP" -Enabled True -Direction Inbound -Protocol TCP -LocalPort 5985

# Allow unencrypted traffic in the WSMan service
Set-Item -Path WSMan:\localhost\Service\AllowUnencrypted -Value $true

# Allow basic authentication in the WSMan service
Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true

# Verify configuration
Write-Output "WinRM has been configured for HTTP with firewall rule and WSMan settings."
