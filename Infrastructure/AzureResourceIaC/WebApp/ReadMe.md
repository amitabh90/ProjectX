# WebApp

This module deploys an Web App.



## Resource types

|Resource Type|ApiVersion|
|:--|:--|
|`Microsoft.Web/sites`|2019-08-01|
|`microsoft.insights/components`|2015-05-01|
|`config`|2016-03-01|
|`providers/locks`|2016-09-01|

## Parameters

| Parameter Name | Type | Description | DefaultValue | Possible values |
| :-- | :-- | :-- | :-- | :-- |
| `appServicePlanSku` | string | Required.The AppServicePlansku to use for the creating App Service Plan ( Ex- Free,Shared,Basic,Standard,Premium,Dynamic )|  |
| `appServicePlanSkuCode` | string | Required.The AppServicePlansku code to use for selecting the current App Service Plan ( Ex- B1,B2,B3,S1,S2,S3,P1, P2,P3) |  |
| `appServicePlanNumberOfWorkers` | int | Required. The appServicePlanNumberOfWorkers for the App Service Plan will define the worker size |  |
| `enableMonitoring` | bool | Optional. If true, ApplicationInsights will be configured for the Function App. | True |  |
| `httpsOnly` | bool | Optional. Configures a web site to accept only https requests. Issues redirect for http requests. | True |  |
| `location` | string | Optional. Location for all resources. | [resourceGroup().location] |  |
| `lockForDeletion` | bool | Optional. Switch to lock Function App from deletion. | False |  |
| `managedServiceIdentity` | string | Optional. Type of managed service identity. | None | System.Object[] |
| `siteConfig` | object | Required. Configuration of the app. |  |  |
| `tags` | object | Optional. Tags of the resource. |  |  |
| `webAppName` | string | Required. Name of the Web App |  |  |

----------
### Parameter Usage: `siteConfig`

```json
"siteConfig": {
    "value": {
        "alwaysOn": true
    }
}
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
| `webAppName` | string | Name of the Web App. |
| `webAppResourceGroup` | string | The REsource Group in which the resource is created. |
| `webAppResourceId` | string | The Resource ID of the WebApp. |
| `assignedIdentityID` | string | User id of the created system assigned identity |

## Additional resources

- [An introduction to Azure Webs](https://docs.microsoft.com/en-us/azure/azure-Webs/Webs-overview)
- [Microsoft.Web sites template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.web/2019-08-01/sites)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)