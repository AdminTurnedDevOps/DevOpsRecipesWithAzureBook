param(
    [parameter(Mandatory)][string]$serverName,
    [parameter(Mandatory)][string]$resourceGroup,
    [parameter(HelpMessage = 'Default location is eastus')][string]$location = 'eastus',
    [parameter(HelpMessage = 'Default image is Windows Server 2019')][string]$image,
    [parameter(HelpMessage = 'Default ports are 80 and 443')][int]$openPorts = '80,443',
    [parameter(HelpMessage = 'Default disk size is 100GB')][string]$diskSizeInGB,
    [parameter(Mandatory, HelpMessage'Please enter virtual network name')][string]$vNet

)

begin {
    $sub = Get-AzContext
    if (-not ($sub)) {
        Write-Warning 'An Azure subscription is not set'
        $subscription = Read-Host 'Please enter the name of your Azure Subscription'

        Set-AzContext $subscription
    }

    else {
        Write-Output "Continuing in Azure subscription: $($sub | Select Name)"
    }
}

process {
    
    $network = Get-AzVirtualNetwork $vNet
    New-AzAvailabilitySet
    New-AzVM -Name -ResourceGroupName -VirtualNetworkName -PublicIpAddressName -Location -Credential -Image -OpenPorts -AvailabilitySetName -DataDiskSizeInGb -Size
}

end { }