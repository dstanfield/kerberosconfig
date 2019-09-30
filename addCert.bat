@ECHO OFF
SET JRE_HOME="C:\Program Files (x86)\Common Files\MicroStrategy\JRE\180_77\Win64"
%JRE_HOME%\bin\keytool -import -alias mstrca -keystore %JRE_HOME%\lib\security\cacerts -storepass changeit -noprompt -file mstrca.cer
