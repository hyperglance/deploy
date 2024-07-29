@description('The name of your virtual machine.')
param vmName string = 'Hyperglance'

@description('The Hyperglance license type to apply to the deployment.')
@allowed([
  'hyperglance_trial_gen2'
  'hyperglance-500_resources_plan_gen2'
  'hyperglance-1000_resources_plan_gen2'
  'hyperglance-2000_resources_plan_gen2'
  'hyperglance-3000_resources_plan_gen2'
  'hyperglance-5000_resources_plan_gen2'
])
param sku string = 'hyperglance_trial_gen2'

@description('The size of the virtual machine')
param vmSize string = 'Standard_D2s_v3'

@description('Username for the virtual machine.')
param adminUsername string

@description('Type of authentication to use on the virtual machine. SSH Public key is strongly recommended.')
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'password'

@description('SSH Public Key or password for the virtual machine. SSH Public key is strongly recommended.')
@secure()
param adminPasswordOrKey string

@description('Secure Boot setting of the virtual machine.')
param secureBoot bool = true

@description('vTPM setting of the virtual machine.')
param vTPM bool = true

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Unique DNS Name for the Public IP used to access the virtual machine.')
param publicIpDns string = toLower('${vmName}-${uniqueString(resourceGroup().id)}')

@description('Name for the Public IP used to access the virtual machine.')
param publicIpName string = 'hyperglance-public-ip'

@description('Allocation method for the Public IP used to access the virtual machine.')
@allowed([
  'Dynamic'
  'Static'
])
param publicIPAllocationMethod string

@description('SKU for the Public IP used to access the virtual machine.')
@allowed([
  'Basic'
  'Standard'
])
param publicIpSku string

@description('Name of the network interface')
param nicName string = 'nic'

@description('Name of the virtual network')
param virtualNetworkName string

@description('Name of the network security group')
param networkSecurityGroupName string = 'nsg'

@description('Custom Attestation Endpoint to attest to. By default, MAA and ASC endpoints are empty and Azure values are populated based on the location of the VM.')
param maaEndpoint string = ''

@description('Source address in CIDR notation to allow access to HTTPS (port 443) from. Eg, 12.34.56.78/32')
param allowedSrcAddressesHTTPS string[]

// default - setting this to none. Should be overwritten if enableSSH is true
@description('Source address in CIDR notation to allow access to SSH (port 22) from. Eg, 12.34.56.78/32')
param allowedSrcAddressesSSH string[] = ['none']

var imageReference = {
  hyperglance_trial_gen2: {
    publisher: 'hyperglance'
    offer: 'hyperglance-dynamic-topology'
    sku: 'hyperglance_trial_gen2'
    version: 'latest'
  }
  hyperglance_500_gen2: {
    publisher: 'hyperglance'
    offer: 'hyperglance-dynamic-topology'
    sku: 'hyperglance-500_resources_plan_gen2'
    version: 'latest'
  }
  hyperglance_1000_gen2: {
    publisher: 'hyperglance'
    offer: 'hyperglance-dynamic-topology'
    sku: 'hyperglance-1000_resources_plan_gen2'
    version: 'latest'
  }
  hyperglance_2000_gen2: {
    publisher: 'hyperglance'
    offer: 'hyperglance-dynamic-topology'
    sku: 'hyperglance-2000_resources_plan_gen2'
    version: 'latest'
  }
  hyperglance_3000_gen2: {
    publisher: 'hyperglance'
    offer: 'hyperglance-dynamic-topology'
    sku: 'hyperglance-3000_resources_plan_gen2'
    version: 'latest'
  }
  hyperglance_5000_gen2: {
    publisher: 'hyperglance'
    offer: 'hyperglance-dynamic-topology'
    sku: 'hyperglance-5000_resources_plan_gen2'
    version: 'latest'
  }
}
@description('')
param addressPrefixes array

@description('')
param subnetName string

@description('')
param subnetPrefix string

var disableAlerts = 'false'
var extensionName = 'GuestAttestation'
var extensionPublisher = 'Microsoft.Azure.Security.LinuxAttestation'
var extensionVersion = '1.0'
var maaTenantName = 'GuestAttestation'
var useAlternateToken = 'false'
var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${adminUsername}/.ssh/authorized_keys'
        keyData: adminPasswordOrKey
      }
    ]
  }
}

@description('Determines whether or not a new virtual network should be provisioned.')
@allowed([
  'new'
  'existing'
])
param virtualNetworkNewOrExisting string = 'new'

// replace the name where required
@description('Name of the resource group for the existing virtual network')
param virtualNetworkResourceGroupName string = resourceGroup().name

@description('Determines whether or not a new public ip should be provisioned.')
@allowed([
  'new'
  'existing'
  'none'
])
param publicIpNewOrExisting string = 'new'

@description('Name of the resource group for the public ip address')
param publicIpResourceGroupName string = resourceGroup().name

var publicIpAddressId = {
  id: resourceId(publicIpResourceGroupName, 'Microsoft.Network/publicIPAddresses', publicIpName)
}

@description('')
param enableSSH bool = false

var baseNSGRules = [
  {
    name: 'Allow_Inbound_HTTPS'
    properties: {
      priority: 1000
      access: 'Allow'
      direction: 'Inbound'
      destinationPortRange: '443'
      protocol: 'Tcp'
      sourcePortRange: '*'
      sourceAddressPrefixes: allowedSrcAddressesHTTPS
      destinationAddressPrefix: '*'
    } 
  }
]

var sshRule = [
  {
    name: 'Allow_Inbound_SSH'
    properties: {
      priority: 1100
      access: 'Allow'
      direction: 'Inbound'
      destinationPortRange: '22'
      protocol: 'Tcp'
      sourcePortRange: '*'
      sourceAddressPrefixes: allowedSrcAddressesSSH
      destinationAddressPrefix: '*'
    }
  }
]

var nsgRules = concat(
  baseNSGRules,
  (enableSSH ? sshRule : [])
)


resource publicIp 'Microsoft.Network/publicIPAddresses@2022-05-01' = if (publicIpNewOrExisting == 'new') {
  name: publicIpName
  location: location
  sku: {
    name: publicIpSku
  }
  properties: {
    publicIPAllocationMethod: publicIPAllocationMethod
    dnsSettings: {
      domainNameLabel: publicIpDns
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-05-01' = if (virtualNetworkNewOrExisting == 'new') {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
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

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: nsgRules
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: ((publicIpNewOrExisting != 'none') ? publicIpAddressId : null)
          subnet: {
            id: resourceId(virtualNetworkResourceGroupName, 'Microsoft.Network/virtualNetworks/subnets/', virtualNetworkName, subnetName)
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: vmName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPasswordOrKey
      linuxConfiguration: ((authenticationType == 'password') ? null : linuxConfiguration)
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
      imageReference: imageReference[sku]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: secureBoot
        vTpmEnabled: vTPM
      }
      securityType: 'TrustedLaunch'
    }
  }
  plan: {
    name: sku
    publisher: 'hyperglance'
    product: 'hyperglance-dynamic-topology'
  }
}

resource vmExtension 'Microsoft.Compute/virtualMachines/extensions@2022-03-01' = if (vTPM && secureBoot) {
  parent: vm
  name: extensionName
  location: location
  properties: {
    publisher: extensionPublisher
    type: extensionName
    typeHandlerVersion: extensionVersion
    autoUpgradeMinorVersion: true
    settings: {
      AttestationConfig: {
        MaaSettings: {
          maaEndpoint: maaEndpoint
          maaTenantName: maaTenantName
        }
        AscSettings: {
          ascReportingEndpoint: substring(maaEndpoint, 0, 0)
          ascReportingFrequency: substring(maaEndpoint, 0, 0)
        }
        useCustomToken: useAlternateToken
        disableAlerts: disableAlerts
      }
    }
  }
}

output hostname string = publicIp.properties.dnsSettings.fqdn
