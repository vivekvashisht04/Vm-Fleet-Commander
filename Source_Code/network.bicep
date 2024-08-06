param location string = 'EastUS'
param vnetName string = 'vmFleetVNet'
param subnetName string = 'default'
param nsgName string = 'vmFleetNSG'
param nicNamePrefix string = 'vmFleetNic'
param publicIpNamePrefix string = 'vmFleetPublicIp'
param vmCount int 

var subnetPrefix = '10.0.0.0/24'
var vnetPrefix = '10.0.0.0/16'

// Virtual Network
resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [vnetPrefix]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
        }
      }
    ]
  }
}

// Network Security Group
resource nsg 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'allowRDP'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}

// Public IP Address
resource publicIp 'Microsoft.Network/publicIPAddresses@2021-02-01' = [for i in range(0, vmCount): {
  name: '${publicIpNamePrefix}-${i}'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}]

// Network Interface Card
resource nic 'Microsoft.Network/networkInterfaces@2021-02-01' = [for i in range(0, vmCount): {
  name: '${nicNamePrefix}-${i}'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIp[i].id
          }
          subnet: {
            id: vnet.properties.subnets[0].id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}]
