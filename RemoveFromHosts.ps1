#Requires -runasadministrator
<#
    Created by Tom Chantler - https://tomssl.com/2019/04/30/a-better-way-to-add-and-remove-windows-hosts-file-entries/
    Updated by dskeller

    Script to remove entries from windows hosts file

    Version:
    1.2
    
    History:
    v1.0 2019-05-01 First commit
    v1.1 2023-01-11 Added encoding to Out-File
    v1.2 2023-01-11 Reformat and output only in debug mode
#>
[CmdletBinding()]
param (
  [Parameter(Mandatory = $true)]$Hostname
)

# Remove entry from hosts file (Removes all entries that match the hostname (i.e. both IPv4 and IPv6)).
$hostsFilePath = "$($Env:WinDir)\system32\Drivers\etc\hosts"
$hostsFile = Get-Content $hostsFilePath
Write-Debug "About to remove $Hostname from hosts file"
$escapedHostname = [Regex]::Escape($Hostname)
If (($hostsFile) -match ".*\s+$escapedHostname.*")  {
    Write-Debug "$Hostname - removing from hosts file... "
    $hostsFile -notmatch ".*\s+$escapedHostname.*" | Out-File $hostsFilePath -Encoding utf8 -Force
    Write-Debug " done"
} 
Else {
    Write-Debug "$Hostname - not in hosts file (perhaps already removed)" 
}