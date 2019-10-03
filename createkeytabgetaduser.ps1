do {

    $usr = Read-Host -Prompt 'What is the name of the user that was assigned the HTTP SPNs for Web/Library/Mobile? Note that this is different from the SPN (Service Principal Name). If you are not sure, contact an Active Directory administrator in your organization to get the username. The format of the username should be username, not username@domain.com'
    $pwdd = Read-Host -Prompt 'Enter the password of the user specified.'
    
    $getUserInfo = "Get-ADUser -Identity " + $usr + " -Properties UserPrincipalName,TrustedForDelegation,ServicePrincipalNames"
	
    $userInfo = Invoke-Expression $getUserInfo

    $upn = $userInfo.UserPrincipalName
    $trustStatus = $userInfo.TrustedForDelegation
    $spn = $userInfo.ServicePrincipalNames
    $aes = $userInfo.KerberosEncryptionType

    if ($null -eq $spn) {
        $confirm = "y"
        Write-Host "The user " + $usr + " has no SPNs assigned to it. This script will now terminate."
    } elseif ($trustStatus.ToLower() = "false") {
        $confirm = "y"
        Write-Host "The user " + $usr + " is not trusted for delegation. In the user object, go to the delegation tab and set it to the middle radio button. This script will now terminate."
    } elseif (-not($aes -like 'AES256')) {
        Write-Host "The user " + $usr + " cannot use AES256. Enable the use of AES256 for this account. This script will now terminate."
        $confirm = "y"
    } else {
        Write-Host "The user " + $usr + " meets all requirements. The keytab will now be created."
        $confirm = "y"
    }
    
	
	Write-Host "You input the following: 
	Domain: '$domain'
	User: '$usr'
	Password: '$pwdd'"
	$confirm = Read-Host -Prompt "Are these correct? Y/N" 
	
	} while ($confirm.ToLower() -ne "y")
	
	$cmd = "ktpass -out " + $PWD + "microstrategy.keytab -pass " + $pwdd + " -princ " + $upn + " -ptype KRB5_NT_PRINCIPAL /crypto AES256-SHA1"
		Invoke-Expression $cmd
		
	Write-Host "The keytab has been yeeted to " $PWD