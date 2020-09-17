# StorageAccounts

This module is used to deploy an Azure Storage Account.



## Resource types

| Resource Type | Api Version |
| :-- | :-- |
| `Microsoft.Storage/storageAccounts/blobServices/containers` | 2019-06-01 |
| `Microsoft.Storage/storageAccounts/blobServices` | 2019-06-01 |
| `Microsoft.Storage/storageAccounts` | 2019-06-01 |
| `providers/locks` | 2016-09-01 |

## Parameters

| Parameter Name | Type | Description | DefaultValue | Possible values |
| :-- | :-- | :-- | :-- | :-- |
| `location` | string | Optional. Location for all resources. | [resourceGroup().location] |  |
| `storageAccountAccessTier` | string | Optional. Storage Account Access Tier. | Hot | System.Object[] |
| `storageAccountKind` | string | Optional. Type of Storage Account to create. | StorageV2 | System.Object[] |
| `storageAccountName` | string | Required. Name of the Storage Account. |  |  |
| `storageAccountSku` | string | Optional. Storage Account Sku Name. | Standard_GRS | System.Object[] |
| `tags` | object | Optional. Tags of the resource. |  |  |
| `vNetId` | string | Optional. Virtual Network Identifier used to create a service endpoint. |  |  |


```

### Parameter Usage: `tags`

Tag names and tag values can be provided as needed. A tag can be left without a value.

```json
"tags": {
    "value":{
                "Env": "nonprod",
                "DevOwner": "Shmuel.Laufer@ab-inbev.com",
                "ProjectName": "brewdatportal",
                "Type": "frontend"
            }
}
```
## Outputs

| Output Name | Value | Type |
| :-- | :-- | :-- |
| `blobContainers` | array | The array of the blob containers created. |
| `storageAccountAccessKey` | securestring | The Access Key for the Storage Account. |
| `storageAccountName` | string | The Name of the Storage Account. |
| `storageAccountResourceGroup` | string | The name of the Resource Group the Storage Account was created in. |
| `storageAccountResourceId` | string | The Resource Id of the Storage Account. |

## Considerations

This is a generic module for deploying a Storage Account. Any customization for different storage needs (such as a diagnostic or other storage account) need to be done through the Archetype.

## Additional resources

- [Introduction to Azure Storage](https://docs.microsoft.com/en-us/azure/storage/common/storage-introduction)
- [ARM Template format for Microsoft.Storage/storageAccounts](https://docs.microsoft.com/en-us/azure/templates/microsoft.storage/2019-06-01/storageaccounts)
- [Storage Account Sku Type options](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.management.storage.fluent.storageaccountskutype?view=azure-dotnet)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
