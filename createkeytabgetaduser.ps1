do {

    $usr = Read-Host -Prompt 'What is the name of the user that was assigned the HTTP SPNs for Web/Library/Mobile? Note that this is different from the SPN (Service Principal Name). If you are not sure, contact an Active Directory administrator in your organization to get the username. The format of the username should be username, not username@domain.com'
    $pwdd = Read-Host -Prompt 'Enter the password of the user specified.'
    

    $message  = 'Is AES256 required? If not, RC4-HMAC will be used.'
    $question = 'Use AES256?'
    $choices  = '&Y', '&N'
    $encType  = 'AES256-SHA1'

    $decision = $Host.UI.PromptForChoice($message, $question, $choices, 1)
    if ($decision -eq 0) {
        Write-Host 'AES256 will be verified as enabled and used to create the keytab.'
    } else {
        Write-Host 'RC4-HMAC will be used to create the keytab.'
        $encType = 'RC4-HMAC-NT'
    }


    $getUserInfo = 'Get-ADUser -Identity ' + $usr + ' -Properties UserPrincipalName,TrustedForDelegation,ServicePrincipalNames'
	
    $userInfo = Invoke-Expression $getUserInfo

    $upn = $userInfo.UserPrincipalName
    $trustStatus = $userInfo.TrustedForDelegation
    $spn = $userInfo.ServicePrincipalNames
    $aes = $userInfo.KerberosEncryptionType

    if ($spn.count -eq 0) {
        Write-Host 'The user ' $usr ' has no SPNs assigned to it. This script will now terminate.'
        $messagespn  = 'Adding SPNs requires input the base URLs that users will connect to Web/Library/Mobile/IntelligenceServer with, along with the hostname and FQDN of the machine. Note that any base URLs must just be the base: no http://, nothing after the .com, and no slashes or special characters. '
        $questionspn = 'Would you like to submit SPNs?'
        $choicesspn  = '&Y', '&N'
        $spnSubmit  = 'AES256-SHA1'
        $moreSPN = 'Yes'
        $setSPN = 'setspn -a '
        $decision = $Host.UI.PromptForChoice($messagespn, $questionspn, $choicesspn, 1)
        if ($decision -eq 0) {
            do {
                $spnSubmit = Read-Host -Prompt 'Enter the SPN to be attached to' $usr '. Valid SPN formats include HTTP/website.com, MSTRSVRSvc/exampleserver.example.com, HTTP/fully.qualified.domain.com.'
                Invoke-Expression 
            } while ($moreSPN -eq 'Yes')
      } else {
            Write-Host 'RC4-HMAC will be used to create the keytab.'
            $spnSubmit = 'nothing'
        }
        break
    } if ($trustStatus -eq $false) {
        Write-Host 'The user ' $usr ' is not trusted for delegation. In the user object, go to the delegation tab and set it to the middle radio button. This script will now terminate.'
        break
    } if (-not $aes -match 'AES256') {
        Write-Host 'The user ' $usr ' cannot use AES256. Enable the use of AES256 for this account. This script will now terminate.'
        break
    } else {
        Write-Host 'The user ' $usr ' meets all requirements. The keytab will now be created.'
        $confirm = 'y'
        $createKeytab = 'True'
    }
    
	
	} while ($confirm.ToLower() -ne 'y')
	
    if ($createKeytab -eq 'True`') {
        $cmd = 'ktpass -out ' + $PWD + '\microstrategy.keytab -pass ' + $pwdd + ' -princ ' + $upn + ' -ptype KRB5_NT_PRINCIPAL /crypto ' + $encType
		Invoke-Expression $cmd
		
	Write-Host 'The keytab has been yeeted to ' $PWD 
    }
    