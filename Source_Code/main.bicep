param vmSize string
param vmNamePrefix string
param location string
param adminUsername string
@secure()
param adminPassword string
param vmCount int

// Referencing the networking deployment module
module networkDeployment 'network.bicep' = {
  name: 'networkDeployment'
  scope: resourceGroup()
  params: {
    location: location
    vnetName: 'vmFleetVNet'
    subnetName: 'default'
    nsgName: 'vmFleetNSG'
    nicNamePrefix: 'vmFleetNic'
    publicIpNamePrefix: 'vmFleetPublicIp'
    vmCount: vmCount
  }
}

// Referencing the VM deployment module
module vmDeployment 'vm.bicep' = {
  name: 'vmDeployment'
  scope: resourceGroup()
  dependsOn: [
    networkDeployment
  ]
  params: {
    vmSize: vmSize
    vmNamePrefix: vmNamePrefix
    location: location
    nicNamePrefix: 'vmFleetNic'
    adminUsername: adminUsername
    adminPassword: adminPassword
    vmCount: vmCount
  }
}
