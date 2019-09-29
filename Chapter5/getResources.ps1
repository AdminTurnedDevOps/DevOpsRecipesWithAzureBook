# Get all resources in Resource Group
Get-AzResource -ResourceGroupName Development

# Get VM Info
$vm = Get-AzResource -ResourceGroupName Development | where {$_.ResourceType -like "Microsoft.Compute/virtualMachines"}
$vm

#Get more VM info
$vm = Get-AzResource -ResourceGroupName Development | where {$_.ResourceType -like "Microsoft.Compute/virtualMachines"} |
Select *

# Get VM info with AZ VM cmdlet
Get-AzVM -ResourceGroupName Development | select * | Where {$_.Id -like $vm.Id}