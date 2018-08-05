Function Resume-bConnectJobInstance() {
    <#
        .Synopsis
            Resume the specified jobinstance.
        .Parameter JobInstanceGuid
            Valid GUID of a jobinstance.
        .Outputs
            Bool
    #>
	
	Param (
		[string]$JobInstanceGuid
	)
	
	$_connectVersion = Get-bConnectVersion
	If ($_connectVersion -ge "1.0") {
		$_body = @{
			Id	   = $JobInstanceGuid;
			Cmd    = "resume"
		}
		
		return Invoke-bConnectGet -Controller "JobInstances" -Data $_body
	}
	else {
		return $false
	}
}