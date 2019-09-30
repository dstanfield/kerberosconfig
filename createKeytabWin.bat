@ECHO OFF
SET JRE_HOME="C:\Program Files (x86)\Common Files\MicroStrategy\JRE\180_77\Win64"

%JRE_HOME%\bin\ktab -a cesar-268949Web@LABS.MICROSTRATEGY.COM m$tr!23 -k "C:\kerbutil\krb5.keytab"
%JRE_HOME%\bin\ktab -a HTTP/cesar-268949.labs.microstrategy.com@LABS.MICROSTRATEGY.COM m$tr!23 -k "C:\kerbutil\krb5.keytab"
%JRE_HOME%\bin\ktab -a HTTP/cesar-268949@LABS.MICROSTRATEGY.COM m$tr!23 -k "C:\kerbutil\krb5.keytab"
