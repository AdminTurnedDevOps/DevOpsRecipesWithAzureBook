function New-SickCode {
    [cmdletbinding()]
    param(
        [parameter(Position = 0,
            HelpMessage = 'Write some sick code')]
        [string]$myCode = 'sick'
    )
    Write-Output "my new code is: $myCode"
}