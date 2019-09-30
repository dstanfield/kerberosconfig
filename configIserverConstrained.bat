net localgroup Administrators tech_services\cesar-268949Iserver /add

cd C:\Program Files (x86)\Windows Resource Kits\Tools

ntrights +r SeServiceLogonRight -u cesar-268949Iserver -m \\%COMPUTERNAME%

ntrights -u tech_services\cesar-268949Iserver +r SeTcbPrivilege

sc.exe config "MicroStrategy Intelligence Server" obj= tech_services\cesar-268949Iserver password= m$tr!23
