function NewACR {
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = 'newacr', ConfirmImpact = 'low')]
    param(
        [parameter(Position = 0,
            HelpMessage = 'Please enter your Resource Group Name',
            ParameterSetName = 'newacr')]
        [Alias(RG)]
        [ValidateNotNullOrEmpty()]
        [string]$resourceGroup,

        [parameter(Position = 1,
            HelpMessage = 'Please enter the name of your Registry',
            ParameterSetName = 'newacr')]
        [Alias(ACRName)]
        [ValidateNotNullOrEmpty()]
        [string]$registryName,

        [parameter(Position = 2,
            HelpMessage = 'Please enter your SKU type. Default is basic',
            ParameterSetName = 'newacr')]
        [ValidateNotNullOrEmpty()]
        [string]$SKU
    )

    begin {
        $azcontext = Get-AzContextA
        if (-not ($azcontext)) {
            Write-Warning 'No Azure Subscription is set. Please run "Set-AzContext" from your shell, choose your subscriptipn, and try again'
            sleep 3
            break
        }

    }

    process {
        Write-Verbose 'Defining params'
        try {
            $params = @{
                'ResourceGroupName' = $resourceGroup
                'Name'              = $registryName
                'Sku'               = $SKU
            }
        
            Write-Verbose 'Creating new Registry'
            New-AzContainerRegistry @params
        }
        catch {
            Write-Warning 'An error has occurred'
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }

    end {

    }

}