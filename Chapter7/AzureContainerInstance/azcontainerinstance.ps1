$sub = Get-AzContext
if (-not ($sub)) {
    Write-Warning 'Warning: No subscription set. Please set a subscription'
    $newSub = Read-Host 'Please enter your subscription name'

    Set-AzContext -Subscription $newSub
}



$containerParams = @{
    'ResourceGroupName' = 'Development'
    'Name' = 'iis-container'
    'Image' = 'mcr.microsoft.com/windows/servercore/iis:nanoserver'
    'OsType' = 'Windows'
    'DnsNameLabel' = 'mlevan-iis'
}

New-AzContainerGroup @containerParams