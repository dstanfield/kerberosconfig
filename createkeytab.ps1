do {

	$domain = Read-Host -Prompt 'What domain is the server in? For instance, if your server Fully Qualified Domain Name is servername.corp.company.com, you would enter corp.company.com as the domain.'
	
	$usr = Read-Host -Prompt 'What is the name of the user that was assigned the HTTP SPNs for Web/Library/Mobile? Note that this is different from the SPN (Service Principal Name). If you are not sure, contact an Active Directory administrator in your organization to get the username. The format of the username should be username, not username@domain.com'
	
	$pwdd = Read-Host -Prompt 'What is the password of the user specified?'
	
	
	Write-Host "You input the following: 
	Domain: '$domain'
	User: '$usr'
	Password: '$pwdd'"
	$confirm = Read-Host -Prompt "Are these correct? Y/N" 
	
	} while ($confirm.ToLower() -ne "y")
	
	$cmd = "ktpass -out " + $PWD + "microstrategy.keytab -pass " + $pwdd + " -princ " + $usr + "@" + $domain + " -ptype KRB5_NT_PRINCIPAL /crypto AES256-SHA1"
		Invoke-Expression $cmd
		
	Write-Host "The keytab has been yeeted to " $PWD