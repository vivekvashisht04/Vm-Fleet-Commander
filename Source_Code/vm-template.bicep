resource myVM 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: 'myVM'
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    osProfile: {
      computerName: 'myVM'
      adminUsername: 'xxxxxxxxxx'
      adminPassword: 'xxxxxxxxxx'
    }
  }
}
