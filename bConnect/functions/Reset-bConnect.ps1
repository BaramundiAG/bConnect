Function Reset-bConnect() {
    <#
        .Synopsis
            Resets bConnect to uninitialized.   
    #>
	
	
	If ($script:_defaultCertPolicy) {
		# Reset certicate validation
		[System.Net.ServicePointManager]::CertificatePolicy = $script:_defaultCertPolicy
	}
	
	$_uri = $null
	
	$script:_bConnectInfo = $null
	$script:_connectUri = $null
	$script:_connectCredentials = $null
	$script:_connectInitialized = $false
}