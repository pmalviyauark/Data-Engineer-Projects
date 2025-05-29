@secure()
param vulnerabilityAssessments_Default_storageContainerPath string
param workspaces_academicinsightssyanal_name string = 'academicinsightssyanal'
param storageAccounts_academicinsightstoreacc_name string = 'academicinsightstoreacc'
param workspaces_academicinsights_databricks_name string = 'academicinsights-databricks'

resource workspaces_academicinsights_databricks_name_resource 'Microsoft.Databricks/workspaces@2024-09-01-preview' = {
  name: workspaces_academicinsights_databricks_name
  location: 'eastus'
  sku: {
    name: 'standard'
  }
  properties: {
    managedResourceGroupId: '/subscriptions/dd8b63d7-72c6-4aa6-9232-5277ee489821/resourceGroups/databricks-rg-${workspaces_academicinsights_databricks_name}-hxk4a4msscz7g'
    parameters: {
      enableNoPublicIp: {
        value: true
      }
      natGatewayName: {
        value: 'nat-gateway'
      }
      prepareEncryption: {
        value: false
      }
      publicIpName: {
        value: 'nat-gw-public-ip'
      }
      requireInfrastructureEncryption: {
        value: false
      }
      storageAccountName: {
        value: 'dbstoragegdwx4lfex5ehi'
      }
      storageAccountSkuName: {
        value: 'Standard_GRS'
      }
      vnetAddressPrefix: {
        value: '10.139'
      }
    }
    authorizations: [
      {
        principalId: '9a74af6f-d153-4348-988a-e2672920bee9'
        roleDefinitionId: '8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
      }
    ]
    createdBy: {}
    updatedBy: {}
  }
}

resource storageAccounts_academicinsightstoreacc_name_resource 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageAccounts_academicinsightstoreacc_name
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    isHnsEnabled: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_academicinsightstoreacc_name_default 'Microsoft.Storage/storageAccounts/blobServices@2024-01-01' = {
  parent: storageAccounts_academicinsightstoreacc_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_academicinsightstoreacc_name_default 'Microsoft.Storage/storageAccounts/fileServices@2024-01-01' = {
  parent: storageAccounts_academicinsightstoreacc_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_academicinsightstoreacc_name_default 'Microsoft.Storage/storageAccounts/queueServices@2024-01-01' = {
  parent: storageAccounts_academicinsightstoreacc_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_academicinsightstoreacc_name_default 'Microsoft.Storage/storageAccounts/tableServices@2024-01-01' = {
  parent: storageAccounts_academicinsightstoreacc_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource workspaces_academicinsightssyanal_name_resource 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: workspaces_academicinsightssyanal_name
  location: 'centralus'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    defaultDataLakeStorage: {
      resourceId: storageAccounts_academicinsightstoreacc_name_resource.id
      createManagedPrivateEndpoint: false
      accountUrl: 'https://academicinsightstoreacc.dfs.core.windows.net'
      filesystem: 'academic-insight-data-container'
    }
    encryption: {}
    managedResourceGroupName: 'synapseworkspace-managedrg-e150cf8e-e0b3-42a4-9199-039076157fe3'
    sqlAdministratorLogin: 'sqladminuser'
    privateEndpointConnections: []
    publicNetworkAccess: 'Enabled'
    cspWorkspaceAdminProperties: {
      initialWorkspaceAdminObjectId: '2eaa128d-0673-4f8f-ba65-a0f733e74192'
    }
    azureADOnlyAuthentication: false
    trustedServiceBypassEnabled: false
  }
}

resource workspaces_academicinsightssyanal_name_Default 'Microsoft.Synapse/workspaces/auditingSettings@2021-06-01' = {
  parent: workspaces_academicinsightssyanal_name_resource
  name: 'Default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource Microsoft_Synapse_workspaces_azureADOnlyAuthentications_workspaces_academicinsightssyanal_name_default 'Microsoft.Synapse/workspaces/azureADOnlyAuthentications@2021-06-01' = {
  parent: workspaces_academicinsightssyanal_name_resource
  name: 'default'
  properties: {
    azureADOnlyAuthentication: false
  }
}

resource Microsoft_Synapse_workspaces_dedicatedSQLminimalTlsSettings_workspaces_academicinsightssyanal_name_default 'Microsoft.Synapse/workspaces/dedicatedSQLminimalTlsSettings@2021-06-01' = {
  parent: workspaces_academicinsightssyanal_name_resource
  name: 'default'
  location: 'centralus'
  properties: {
    minimalTlsVersion: '1.2'
  }
}

resource Microsoft_Synapse_workspaces_extendedAuditingSettings_workspaces_academicinsightssyanal_name_Default 'Microsoft.Synapse/workspaces/extendedAuditingSettings@2021-06-01' = {
  parent: workspaces_academicinsightssyanal_name_resource
  name: 'Default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource workspaces_academicinsightssyanal_name_allowall 'Microsoft.Synapse/workspaces/firewallRules@2021-06-01' = {
  parent: workspaces_academicinsightssyanal_name_resource
  name: 'allowall'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}

resource workspaces_academicinsightssyanal_name_AllowAllWindowsAzureIps 'Microsoft.Synapse/workspaces/firewallRules@2021-06-01' = {
  parent: workspaces_academicinsightssyanal_name_resource
  name: 'AllowAllWindowsAzureIps'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource workspaces_academicinsightssyanal_name_ClientIPAddress_2025_4_24_12_13_18 'Microsoft.Synapse/workspaces/firewallRules@2021-06-01' = {
  parent: workspaces_academicinsightssyanal_name_resource
  name: 'ClientIPAddress-2025-4-24-12-13-18'
  properties: {
    startIpAddress: '70.178.85.92'
    endIpAddress: '70.178.85.92'
  }
}

resource workspaces_academicinsightssyanal_name_AutoResolveIntegrationRuntime 'Microsoft.Synapse/workspaces/integrationruntimes@2021-06-01' = {
  parent: workspaces_academicinsightssyanal_name_resource
  name: 'AutoResolveIntegrationRuntime'
  properties: {
    type: 'Managed'
    typeProperties: {
      computeProperties: {
        location: 'AutoResolve'
      }
    }
  }
}

resource Microsoft_Synapse_workspaces_securityAlertPolicies_workspaces_academicinsightssyanal_name_Default 'Microsoft.Synapse/workspaces/securityAlertPolicies@2021-06-01' = {
  parent: workspaces_academicinsightssyanal_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
}

resource Microsoft_Synapse_workspaces_vulnerabilityAssessments_workspaces_academicinsightssyanal_name_Default 'Microsoft.Synapse/workspaces/vulnerabilityAssessments@2021-06-01' = {
  parent: workspaces_academicinsightssyanal_name_resource
  name: 'Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
    storageContainerPath: vulnerabilityAssessments_Default_storageContainerPath
  }
}

resource storageAccounts_academicinsightstoreacc_name_default_academic_insight_data_container 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_academicinsightstoreacc_name_default
  name: 'academic-insight-data-container'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_academicinsightstoreacc_name_resource
  ]
}

resource storageAccounts_academicinsightstoreacc_name_default_academicinsights_datasourcefile 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  parent: storageAccounts_academicinsightstoreacc_name_default
  name: 'academicinsights-datasourcefile'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_academicinsightstoreacc_name_resource
  ]
}
