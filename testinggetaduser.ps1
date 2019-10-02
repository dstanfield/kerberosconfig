$usr = Read-Host -Prompt 'What is the name of the user that was assigned the HTTP SPNs for Web/Library/Mobile? Note that this is different from the SPN (Service Principal Name). If you are not sure, contact an Active Directory administrator in your organization to get the username. The format of the username should be username, not username@domain.com'
    
    $getUserInfo = "Get-ADUser -Identity" + $usr + " -Properties UserPrincipalName,TrustedForDelegation,ServicePrincipalNames"
	
	$userInfo = Invoke-Expression $getUserInfo
    $upn = $userInfo.UserPrincipalName

    Write-Host $upn