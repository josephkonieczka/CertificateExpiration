$today = Get-Date
$certFriendlyName = 'CERT_NAME'
#Recursion gets all of the certificates but there could be multiple ones if full path not specified
#$allCertificates = Get-ChildItem -Path Cert:\LocalMachine\ -Recurse
$allCertificates = Get-ChildItem -Path Cert:\LocalMachine\Root
$selectedCert = $allCertificates `
| Where-Object { $_.FriendlyName -eq $certFriendlyName } `
| Select-Object -First 1
$expirationDate = ($selectedCert).NotAfter
if ($expirationDate -as [DateTime])
{
    $daysUntilExpiration = (New-TimeSpan -Start $today -End $expirationDate).Days     
}
else
{
    $daysUntilExpiration = 9999
}

$metricString = "name=Custom Metrics|Server Tools|certificateExpiration|$($certFriendlyName)|daysUntilExpiration,value=$($daysUntilExpiration),aggregator=OBSERVATION"
Write-Output $metricString