# Create the keyvault
az keyvault create --location 'your_azure_location' --name VMDeploy --resource-group your_resource_group


#Create the secret for the password
$secret = ConvertTo-SecureString 'MySuperSickPassword01!@' -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName "VMDeployKV" -Name "VMIIS" -SecretValue $secret