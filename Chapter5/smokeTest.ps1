function New-SmokeTest {

    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low', DefaultParameterSetName = 'SmokeTest')]
    param(
        [Parameter(Mandatory = $true, 
            position = 0,
            HelpMessage = 'Enter the URL for you wish to smoke test',
            ValueFromPipeline = $true)]
        [ValidateNotnullOrEmpty()]
        [uri]$URL,

        [Parameter(Mandatory = $true, 
            position = 1,
            HelpMessage = 'Please specify the status code you expect to be returned')]
        [ValidateNotnullOrEmpty()]
        [Alias('statusCode')]
        [uri]$returnCode,

        [Parameter(position = 2,
            HelpMessage = 'Please specify where you would like you log to go')]
        [string]$outFile
    )

    begin {
        [Console]::WriteLine('Testing basic network connectivity')
        $netTest = Test-Connection 8.8.8.8 -Quiet
        try {
            if (-not ($netTest)) {
                Write-Warning 'No outbound connection to the internet'
            }
        }

        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }

        try {
            $api = [System.Net.WebRequest]::Create($URL)
            $response = $api.GetResponse()
            if ($response.StatusCode -notlike 'OK') {
                Write-Warning '200 GET Request: Not Available'    
            }
        
            else {
                [Console]::WriteLine('200 GET Request: Successful')
                $api.GetResponse()
            } 
        }

        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }

    process {
        try {
            if ($PSCmdlet.ShouldProcess('URL') -and $PSCmdlet.ShouldProcess('returnCode')) {
                Write-Verbose 'Making API Call'
                $apiCallParams = @{
                    'uri'             = $URL
                    'UseBasicParsing' = $true
                }

                Write-Verbose 'Confirming Status code...'
                if ($(Invoke-WebRequest @apiCallParams).StatusCode -notlike $returnCode) {
                    Write-Warning "$returnCode : Not available from GET request"
                }

                if ($outFile) {
                    $(Invoke-WebRequest @apiCallParams) | Out-File "$outFile.log"
                }

                else {
                    $(Invoke-WebRequest @apiCallParams)
                }
            }
        }

        catch {
            Write-Warning 'An error has occurred'
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }

    end { $response.Close() }
}