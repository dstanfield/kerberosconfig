cd %windir%\system32\inetsrv

appcmd.exe set config "Default Web Site/MicroStrategy" -section:system.webServer/security/authentication/anonymousAuthentication /enabled:"False"  /commit:apphost

appcmd.exe set config "Default Web Site/MicroStrategy" -section:system.webServer/security/authentication/windowsAuthentication /useAppPoolCredentials:"True"  /commit:apphost

appcmd.exe set config "Default Web Site/MicroStrategy" -section:system.web/identity /impersonate:"False"  

appcmd.exe set config "Default Web Site/MicroStrategy" -section:system.webServer/security/authentication/windowsAuthentication /useKernelMode:"False"  /commit:apphost

appcmd.exe set config "Default Web Site/MicroStrategy" -section:system.webServer/security/authentication/windowsAuthentication /-providers.[value='NTLM'] /commit:apphost

appcmd.exe set config "Default Web Site/MicroStrategy" -section:system.webServer/security/authentication/windowsAuthentication /+providers.[value='NTLM'] /commit:apphost

appcmd.exe set config /section:applicationPools /[name='MicroStrategyWebPool'].processModel.identityType:SpecificUser /[name='MicroStrategyWebPool'].processModel.userName:tech_services\cesar-268949Web /[name='MicroStrategyWebPool'].processModel.password:m$tr!23


appcmd.exe set config "Default Web Site/MicroStrategyMobile" -section:system.webServer/security/authentication/anonymousAuthentication /enabled:"False"  /commit:apphost

appcmd.exe set config "Default Web Site/MicroStrategyMobile" -section:system.webServer/security/authentication/windowsAuthentication /useAppPoolCredentials:"True"  /commit:apphost

appcmd.exe set config "Default Web Site/MicroStrategyMobile" -section:system.web/identity /impersonate:"False"  

appcmd.exe set config "Default Web Site/MicroStrategyMobile" -section:system.webServer/security/authentication/windowsAuthentication /useKernelMode:"False"  /commit:apphost

appcmd.exe set config "Default Web Site/MicroStrategyMobile" -section:system.webServer/security/authentication/windowsAuthentication /-providers.[value='NTLM'] /commit:apphost

appcmd.exe set config "Default Web Site/MicroStrategyMobile" -section:system.webServer/security/authentication/windowsAuthentication /+providers.[value='NTLM'] /commit:apphost

appcmd.exe set config /section:applicationPools /[name='MicroStrategyMobilePool'].processModel.identityType:SpecificUser /[name='MicroStrategyMobilePool'].processModel.userName:tech_services\cesar-268949Web /[name='MicroStrategyMobilePool'].processModel.password:m$tr!23


appcmd.exe set config "Default Web Site/MicroStrategyMDX" -section:system.webServer/security/authentication/anonymousAuthentication /enabled:"False"  /commit:apphost

appcmd.exe set config "Default Web Site/MicroStrategyMDX" -section:system.webServer/security/authentication/windowsAuthentication /useAppPoolCredentials:"True"  /commit:apphost

appcmd.exe set config "Default Web Site/MicroStrategyMDX" -section:system.web/identity /impersonate:"True"  

appcmd.exe set config "Default Web Site/MicroStrategyMDX" -section:system.webServer/security/authentication/windowsAuthentication /useKernelMode:"False"  /commit:apphost

appcmd.exe set config "Default Web Site/MicroStrategyMDX" -section:system.webServer/security/authentication/windowsAuthentication /-providers.[value='NTLM'] /commit:apphost

appcmd.exe set config "Default Web Site/MicroStrategyMDX" -section:system.webServer/security/authentication/windowsAuthentication /+providers.[value='NTLM'] /commit:apphost

appcmd.exe set config /section:applicationPools /[name='MicroStrategyMDXPool'].processModel.identityType:SpecificUser /[name='MicroStrategyMDXPool'].processModel.userName:tech_services\cesar-268949Web /[name='MicroStrategyMDXPool'].processModel.password:m$tr!23

net localgroup Administrators tech_services\cesar-268949Web /add

c:\windows\System32\iisreset.exe
