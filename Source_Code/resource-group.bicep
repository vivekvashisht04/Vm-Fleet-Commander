targetScope = 'subscription'

param rgName string = 'vmFleetRG'
param rgLocation string = 'EastUS'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: rgLocation
}

output resourceGroupName string = rg.name
output resourceGroupLocation string = rg.location
