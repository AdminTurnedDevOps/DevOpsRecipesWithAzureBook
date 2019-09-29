param(
    [parameter(Mandatory)][string]$serverName,
    [parameter(Mandatory)][string]$resourceGroup,
    [parameter(HelpMessage = 'Default location is eastus')][string]$location = 'eastus',
    [parameter(HelpMessage = 'Default ports are 80 and 443')][int]$openPorts = '80,443',
    [parameter(HelpMessage = 'Default disk size is 100GB')][int]$diskSizeInGB = 100,
    [parameter(Mandatory, HelpMessage = 'Please enter virtual network name')][string]$vNet,
    [parameter(HelpMessage = 'Please enter VM size. By default it is Standard B1ls')]$vmSize = 'Standard_B1ls'

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

    $user = Read-Host 'Please enter username'
    $password = Read-Host -assecurestring "Please enter your password"

    $creds = New-Object System.Management.Automation.PSCredential ($user, $password)

    $rand = Get-Random -Count 5

    $scaleSetParams = @{
        'ResourceGroupName' = $resourceGroup
        'DataDiskSizeInGb' = $diskSizeInGB
        'Credential' = $creds
        'Location' = $location
        'VMScaleSetName' = $('IIS2016-' + $rand[0])
        'VirtualNetworkName' = $vNet
        'VmSize' = $vmSize
        'LoadBalancerName' = 'IIS-' + $rand[1]
        'InstanceCount' = 2
        'SubnetName' = 'IIS' + $rand[2]

    }

    New-AzVmss @scaleSetParams
}

end { }