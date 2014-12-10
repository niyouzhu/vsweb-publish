<#
    Add the following snippet to your .ps1 file to ensure that the publish-module is loaded and ready for use
#>

function Ensure-PublishModuleLoaded{
    [cmdletbinding()]
    param($versionToInstall = '0.0.10-beta',
        $installScriptUrl = 'https://raw.githubusercontent.com/sayedihashimi/publish-module/master/GetPublishModule.ps1',
        $toolsDir = ("$env:LOCALAPPDATA\Microsoft\Web Tools\Publish\tools\"),
        $installScriptPath = (Join-Path $toolsDir 'GetPublishModule.ps1'))
    process{
        if(!(Test-Path $installScriptPath)){
            if(!(Test-Path $toolsDir)){
                New-Item -Path $toolsDir -ItemType Directory | Out-Null
            }

            'Downloading from [{0}] to [{1}]' -f $installScriptUrl, $installScriptPath| Write-Verbose
            (new-object Net.WebClient).DownloadFile($installScriptUrl,$installScriptPath) | Out-Null
        }
        $installScriptArgs = @($versionToInstall,$toolsDir)
        # seems to be the best way to invoke a .ps1 file with parameters
        Invoke-Expression "& `"$installScriptPath`" $installScriptArgs"
    }
}

Ensure-PublishModuleLoaded
