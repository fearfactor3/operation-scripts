$servers = $env:COMPUTERNAME
foreach ($servers in $servers)
    {
        $status = (Get-Service -Name LanmanServer -ComputerName $env:COMPUTERNAME).Status
        ##$status = 'Down'
        if ($status -eq "Running")
            {
                $env:COMPUTERNAME + " is " + $status

                $FileContent = Get-IniContent "C:\users\wmajor\Desktop\ReleaseEngineerAuditionPack\ReleaseEngineerAuditionPack\serverState.ini"
                $FileContent.BatchProcessingService
                $FileContent.CmsContentUI 
                $FileContent.FederationResources 

                "Call function get-nh-package(packageName, packageVersion)"
                "List the packages to be deployed here"

                $json = Get-Content "C:\Users\wmajor\Desktop\ReleaseEngineerAuditionPack\ReleaseEngineerAuditionPack\desiredConfig.json" | ConvertFrom-Json
                "Searches for version of BatchProcessingService to be deployed"
                "Shows correct version of BatchProcessingService if found. BatchProcessingService " + $json.package_versions.BatchProcessingService + "." + $json.attributes.BatchProcessingService.Build
                "Shows correct version of CmsContentUI if found. CmsContentUI " + $json.package_versions.CmsContentUI + "." + $json.attributes.CmsContentService.Build
                "Shows correct version of FederationResources if found. FederationResources " + $json.package_versions.FederationResources + "." + $json.attributes.FederationResources.Build
                "Shows correct version of ScmKitProduction if found. ScmKitProduction " + $json.package_versions.ScmKitProduction + "." + $json.attributes.ScmKitProduction.Build
                
                "Call function install-nh-product (installTimeParameters)"
                "Reads information from desiredConfig.json and shows on the screen"
                
                "Here's BatchProcessingService Information"
                $json.attributes.BatchProcessingService.PROJECT_DRIVE + $json.attributes.BatchProcessingService.PROJECT_DIR + $json.attributes.BatchProcessingService.PROJECT_BIN_DIR
                
                "Here's CMSContentUI Information"
                $json.attributes.CmsContentService.PoolIdentity
                $json.attributes.CmsContentService.IdentityPassword | ConvertTo-SecureString -AsPlainText -Force
                $json.attributes.CmsContentService.TargetDirectory_Dynamic 
                
                "Here's CMSContentUI Information"
                $json.attributes.CmsContentService.PoolIdentity
                $json.attributes.CmsContentService.IdentityPassword | ConvertTo-SecureString -AsPlainText -Force
                $json.attributes.CmsContentService.TargetDirectory_Dynamic
                
                "Here's CMSContentUI Information"
                $json.attributes.FederationResources.Drive
                $json.attributes.FederationResources.EnableIISLogging 
                
                "Here's ScmKitProduction Information"
                $json.attributes.ScmKitProduction.BASE_DIR + $json.attributes.ScmKitProduction.NAVISTRINGCACHE_SERVICE_PATH                

                "Creates a log to show log was successful." 
                "Install was successful " > C:\Users\wmajor\Desktop\ReleaseEngineerAuditionPack\ReleaseEngineerAuditionPack\install.log
                "Then add entries to .ini file"
                $Category1 = @{“DateTime”= (Get-Date -Format "MM/dd/yyyy HH:mm:ss");”Version”= ($json.package_versions.BatchProcessingService + "." + $json.attributes.BatchProcessingService.Build);"InstallStatus"="Success";}  
                $Category2 = @{“DateTime”= (Get-Date -Format "MM/dd/yyyy HH:mm:ss");”Version”= ($json.package_versions.CmsContentUI + "." + $json.attributes.CmsContentService.Build);"InstallStatus"="Success";}  
                $Category3 = @{“DateTime”= (Get-Date -Format "MM/dd/yyyy HH:mm:ss");”Version”= ($json.package_versions.FederationResources + "." + $json.attributes.FederationResources.Build);"InstallStatus"="Success";}
                $Category4 = @{“DateTime”= (Get-Date -Format "MM/dd/yyyy HH:mm:ss");”Version”= ($json.package_versions.ScmKitProduction + "." + $json.attributes.ScmKitProduction.Build);"InstallStatus"="Success";}  
                $NewINIContent = @{“BatchProcessingService”=$Category1;”CmsContentUI”=$Category2; "FederationResources"=$Category3; "ScmKitProduction"=$Category4;}  
                Out-IniFile -InputObject $NewINIContent -FilePath "C:\Users\wmajor\Desktop\ReleaseEngineerAuditionPack\ReleaseEngineerAuditionPack\serverState2.ini" -Force
                "Software Deployment was successful."
            }
            else
            {
                "Server is down!  Please contact on-call Windows Admin"
            }
    }