Function New-bConnectApplication() {
    <#
        .Synopsis
            Create a new application.
        .Parameter Type
            enum bConnectEndpointType.
        .Parameter DisplayName
            DisplayName of the new endpoint. This is also used as hostname for Windows-Endpoints.
        .Parameter GroupGuid
            Valid GUID of the target OU (default: "Logical Group").
        .Parameter PrimaryUser
            Primary user of this endpoint. Mandatory for WindowsPhone-Endpoints.
        .Outputs
            NewEndpoint (see bConnect documentation for more details).
    #>
	
	
	Param (
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[Parameter(Mandatory = $true)]
		[string]$Vendor,
		[Parameter(Mandatory = $true)]
		[ValidateSet("NT4", "Windows2000", "WindowsXP", "WindowsServer2003", "WindowsVista", "WindowsServer2008", "Windows7", "WindowsServer2008R2", "WindowsXP_x64", "WindowsServer2003_x64", "WindowsVista_x64", "WindowsServer2008_x64", "Windows7_x64", "WindowsServer2008R2_x64", "Windows8", "WindowsServer2012", "Windows8_x64", "WindowsServer2012_x64", "Windows10", "Windows10_x64", "WindowsServer2016_x64", ignoreCase = $true)]
		[string[]]$ValidForOS,
		[string]$Comment,
		[string]$ParentGuid,
		# = "C1A25EC3-4207-4538-B372-8D250C5D7908", #guid of "Logical Group" as fallback

		[string]$Version,
		[string]$Category,
		[PSCustomObject]$InstallationData,
		[PSCustomObject]$UninstallationData,
		[string]$ConsistencyChecks,
		[PSCustomObject[]]$ApplicationFile,
		[float]$Cost = 0,
		[ValidateSet("AnyUser", "InstallUser", "LocalInstallUser", "LocalSystem", "LoggedOnUser", "RegisteredUser", "SpecifiedUser", ignoreCase = $true)]
		[string]$SecurityContext,
		[PSCustomObject[]]$Licenses,
		[PSCustomObject[]]$AUT
	)
	
	$_connectVersion = Get-bConnectVersion
	If ($_connectVersion -ge "1.0") {
		$_body = @{
			Name		  = $Name;
			Vendor	      = $Vendor;
			ValidForOS    = $ValidForOS;
			Cost		  = $Cost
		}
		
		If (![string]::IsNullOrEmpty($Comment)) {
			$_body += @{ Comment = $Comment }
		}
		
		If (![string]::IsNullOrEmpty($ParentGuid)) {
			$_body += @{ ParentGuid = $ParentGuid }
		}
		
		If (![string]::IsNullOrEmpty($Version)) {
			$_body += @{ Version = $Version }
		}
		
		If (![string]::IsNullOrEmpty($Category)) {
			$_body += @{ Category = $Category }
		}
		
		If ($InstallationData) {
			$_body += @{ Installation = $InstallationData }
		}
		
		If ($UninstallationData) {
			$_body += @{ Uninstallation = $UninstallationData }
		}
		
		If (![string]::IsNullOrEmpty($ConsistencyChecks)) {
			$_body += @{ ConsistencyChecks = $ConsistencyChecks }
		}
		
		If (![string]::IsNullOrEmpty($SecurityContext)) {
			$_body += @{ SecurityContext = $SecurityContext }
		}
		
		If ($Licenses.Count -gt 0) {
			$_body += @{ Licenses = $Licenses }
		}
		
		If ($AUT.Count -gt 0) {
			$_body += @{ EnableAUT = $true; AUT = $AUT }
		}
		
		return Invoke-bConnectPost -Controller "Applications" -Data $_body
	}
	else {
		return $false
	}
}