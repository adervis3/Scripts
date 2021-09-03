#sed -i 's/\r//g' script.sh

msfdb init&  #Kontrol edilecek

BASE_DIR=$(pwd)
DOM_USER=""
DOMAIN=""
DOM_PASS=""
COMMERCIAL="demo_comp"

mkdir clear
mkdir raw
mkdir resource

echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting Network Enumeration"
nmap -p 21,22,23,25,80,443,445,3389,8080,8081,5900,1433,1521,3306,5432,27017,9300,3260 -T4 -n --open -Pn -oG $BASE_DIR/raw/Ports-raw.txt -iL $BASE_DIR/kapsam.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended Network Enumeration"

echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting Ports Grep"
grep "21/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P21.txt
grep "22/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P22.txt
grep "23/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P23.txt
grep "25/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P25.txt
grep "80/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P80.txt
grep "443/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P443.txt
grep "445/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P445.txt
grep "3389/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P3389.txt
grep "8080/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P8080.txt
grep "8081/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P8081.txt
grep "5900/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P5900.txt
grep "1433/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P1433.txt
grep "1521/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P1521.txt
grep "3306/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P3306.txt
grep "5432/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P5432.txt
grep "27017/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P27017.txt
grep "9300/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P9300.txt
grep "3260/open" $BASE_DIR/raw/Ports-raw.txt | cut -d " " -f2 > $BASE_DIR/clear/P3260.txt
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

#SMBSid
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/SMBsid.rc
echo "use auxiliary/scanner/smb/smb_lookupsid" >> $BASE_DIR/resource/SMBsid.rc
echo "set MaxRID 1200" >> $BASE_DIR/resource/SMBsid.rc
echo "set RHOSTS file:$BASE_DIR/clear/P445.txt" >> $BASE_DIR/resource/SMBsid.rc
echo "set THREADS 20" >> $BASE_DIR/resource/SMBsid.rc
echo "spool $BASE_DIR/raw/smbsid-raw.txt" >> $BASE_DIR/resource/SMBsid.rc
echo "run" >> $BASE_DIR/resource/SMBsid.rc
echo "spool off" >> $BASE_DIR/resource/SMBsid.rc
echo "exit" >> $BASE_DIR/resource/SMBsid.rc

#SNMP
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/SNMP.rc
echo "use auxiliary/scanner/snmp/snmp_enum" >> $BASE_DIR/resource/SNMP.rc
echo "set RHOSTS file:$BASE_DIR/kapsam.txt" >> $BASE_DIR/resource/SNMP.rc
echo "set THREADS 40" >> $BASE_DIR/resource/SNMP.rc
echo "spool $BASE_DIR/raw/snmp-raw.txt" >> $BASE_DIR/resource/SNMP.rc
echo "run" >> $BASE_DIR/resource/SNMP.rc
echo "spool off" >> $BASE_DIR/resource/SNMP.rc
echo "exit" >> $BASE_DIR/resource/SNMP.rc

#FTP Anonymous
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/FTP.rc
echo "use auxiliary/scanner/ftp/anonymous" >> $BASE_DIR/resource/FTP.rc
echo "set RHOSTS file:$BASE_DIR/clear/P21.txt" >> $BASE_DIR/resource/FTP.rc
echo "set THREADS 20" >> $BASE_DIR/resource/FTP.rc
echo "spool $BASE_DIR/raw/ftp-anon-raw.txt" >> $BASE_DIR/resource/FTP.rc
echo "run" >> $BASE_DIR/resource/FTP.rc
echo "spool off" >> $BASE_DIR/resource/FTP.rc
echo "cat $BASE_DIR/raw/ftp-anon-raw.txt | grep + | cut -d\" \" -f2 | cut -d\":\" -f1 > $BASE_DIR/clear/P21-anon.txt " >> $BASE_DIR/resource/FTP.rc
echo "while read -r line;" >> $BASE_DIR/resource/shFTP.sh
echo "    do echo \"\$(grep -v \$line $BASE_DIR/clear/P21.txt)\" > $BASE_DIR/clear/P21.txt;" >> $BASE_DIR/resource/shFTP.sh
echo "done < $BASE_DIR/clear/P21-anon.txt" >> $BASE_DIR/resource/shFTP.sh
echo "chmod +x $BASE_DIR/resource/shFTP.sh" >> $BASE_DIR/resource/FTP.rc
echo "$BASE_DIR/resource/shFTP.sh" >> $BASE_DIR/resource/FTP.rc
#FTP Brute
echo "rm $BASE_DIR/resource/shFTP.sh" >> $BASE_DIR/resource/FTP.rc
echo "use auxiliary/scanner/ftp/ftp_login" >> $BASE_DIR/resource/FTP.rc
echo "set RHOSTS file:$BASE_DIR/clear/P21.txt" >> $BASE_DIR/resource/FTP.rc
echo "set USER_FILE $BASE_DIR/resource/user" >> $BASE_DIR/resource/FTP.rc
echo "set PASS_FILE $BASE_DIR/resource/pass" >> $BASE_DIR/resource/FTP.rc
echo "set THREADS 20" >> $BASE_DIR/resource/FTP.rc
echo "spool $BASE_DIR/raw/ftp-brute-raw.txt" >> $BASE_DIR/resource/FTP.rc
echo "run" >> $BASE_DIR/resource/FTP.rc
echo "spool off" >> $BASE_DIR/resource/FTP.rc
echo "exit" >> $BASE_DIR/resource/FTP.rc

#SSH Brute
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/SSH.rc
echo "use auxiliary/scanner/ssh/ssh_login" >> $BASE_DIR/resource/SSH.rc
echo "set RHOSTS file:$BASE_DIR/clear/P22.txt" >> $BASE_DIR/resource/SSH.rc
echo "set USER_FILE $BASE_DIR/resource/user" >> $BASE_DIR/resource/SSH.rc
echo "set PASS_FILE $BASE_DIR/resource/pass" >> $BASE_DIR/resource/SSH.rc
echo "set THREADS 20" >> $BASE_DIR/resource/SSH.rc
echo "set VERBOSE True" >> $BASE_DIR/resource/SSH.rc
echo "spool $BASE_DIR/raw/ssh-brute-raw.txt" >> $BASE_DIR/resource/SSH.rc
echo "run" >> $BASE_DIR/resource/SSH.rc
echo "spool off" >> $BASE_DIR/resource/SSH.rc
echo "exit" >> $BASE_DIR/resource/SSH.rc

#Telnet Brute
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/TELNET.rc
echo "use auxiliary/scanner/telnet/telnet_login" >> $BASE_DIR/resource/TELNET.rc
echo "set RHOSTS file:$BASE_DIR/clear/P23.txt" >> $BASE_DIR/resource/TELNET.rc
echo "set USER_FILE $BASE_DIR/resource/user" >> $BASE_DIR/resource/TELNET.rc
echo "set PASS_FILE $BASE_DIR/resource/pass" >> $BASE_DIR/resource/TELNET.rc
echo "set THREADS 20" >> $BASE_DIR/resource/TELNET.rc
echo "spool $BASE_DIR/raw/telnet-brute-raw.txt" >> $BASE_DIR/resource/TELNET.rc
echo "run" >> $BASE_DIR/resource/TELNET.rc
echo "spool off" >> $BASE_DIR/resource/TELNET.rc
echo "exit" >> $BASE_DIR/resource/TELNET.rc

#Unauth VNC
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/VNC-anon.rc
echo "use auxiliary/scanner/vnc/vnc_none_auth" >> $BASE_DIR/resource/VNC-anon.rc
echo "set RHOSTS file:$BASE_DIR/clear/P5900.txt" >> $BASE_DIR/resource/VNC-anon.rc
echo "set THREADS 20" >> $BASE_DIR/resource/VNC-anon.rc
echo "spool $BASE_DIR/raw/vnc-anon-raw.txt" >> $BASE_DIR/resource/VNC-anon.rc
echo "run" >> $BASE_DIR/resource/VNC-anon.rc
echo "spool off" >> $BASE_DIR/resource/VNC-anon.rc
echo "exit" >> $BASE_DIR/resource/VNC-anon.rc

#PostgreSQL Brute
#msfconsole listesini cek ekle
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/PostgreSQL.rc
echo "use auxiliary/scanner/postgres/postgres_login" >> $BASE_DIR/resource/PostgreSQL.rc
echo "set RHOSTS file:$BASE_DIR/clear/P5432.txt" >> $BASE_DIR/resource/PostgreSQL.rc
echo "spool $BASE_DIR/raw/postgresql-brute-raw.txt" >> $BASE_DIR/resource/PostgreSQL.rc
echo "run" >> $BASE_DIR/resource/PostgreSQL.rc
echo "spool off" >> $BASE_DIR/resource/PostgreSQL.rc
echo "exit" >> $BASE_DIR/resource/PostgreSQL.rc
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#MongoDB Brute
#msfconsole listesini cek ekle
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/MongoDB.rc
echo "use auxiliary/scanner/mongodb/mongodb_login" >> $BASE_DIR/resource/MongoDB.rc
echo "set RHOSTS file:$BASE_DIR/clear/P27017.txt" >> $BASE_DIR/resource/MongoDB.rc
echo "spool $BASE_DIR/raw/mongodb-brute-raw.txt" >> $BASE_DIR/resource/MongoDB.rc
echo "run" >> $BASE_DIR/resource/MongoDB.rc
echo "spool off" >> $BASE_DIR/resource/MongoDB.rc
echo "exit" >> $BASE_DIR/resource/MongoDB.rc
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#MySQL Brute
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/MySQL.rc
echo "use auxiliary/scanner/mysql/mysql_login" >> $BASE_DIR/resource/MySQL.rc
echo "set RHOSTS file:$BASE_DIR/clear/P3306.txt" >> $BASE_DIR/resource/MySQL.rc
echo "spool $BASE_DIR/raw/mysql-brute-raw.txt" >> $BASE_DIR/resource/MySQL.rc
echo "run" >> $BASE_DIR/resource/MySQL.rc
echo "spool off" >> $BASE_DIR/resource/MySQL.rc
echo "exit" >> $BASE_DIR/resource/MySQL.rc
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

#CVE-2019-0708 Bluekeep
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/Bluekeep.rc
echo "use auxiliary/scanner/rdp/cve_2019_0708_bluekeep" >> $BASE_DIR/resource/Bluekeep.rc
echo "set RHOSTS file:$BASE_DIR/clear/P3389.txt" >> $BASE_DIR/resource/Bluekeep.rc
echo "spool $BASE_DIR/raw/bluekeep-raw.txt" >> $BASE_DIR/resource/Bluekeep.rc
echo "run" >> $BASE_DIR/resource/Bluekeep.rc
echo "spool off" >> $BASE_DIR/resource/Bluekeep.rc
echo "exit" >> $BASE_DIR/resource/Bluekeep.rc
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Created MSF Files"

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

#iSCSi
echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting Unauth iSCSi Vuln"
nmap -p 3260 -n -Pn --script iscsi-info.nse -iL $BASE_DIR/clear/P3260.txt -oN $BASE_DIR/raw/iscsi-raw.nmap > /dev/null
cat $BASE_DIR/raw/iscsi-raw.nmap | grep "Authentication: NOT required" -B 2 | grep -w Address: | cut -d ' ' -f 2 | cut -d ":" -f 1 >> $BASE_DIR/clear/Ms08_067.txt
while read -r line; 
    do echo "$(tput setaf 1)$(tput bold)[*] $line$(tput sgr0)"; 
done < $BASE_DIR/clear/iSCSi-Auth-Not-Req.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended Unauth iSCSi Vuln"

#SMBSigning
echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting SMB Signing"
crackmapexec smb $BASE_DIR/clear/P445.txt --gen-relay-list $BASE_DIR/clear/targets.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended SMB Signing"

#HTTP Default Creds
echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting Default Web Creds"
git -C /opt clone https://github.com/InfosecMatter/default-http-login-hunter.git
chmod +x /opt/default-http-login-hunter/default-http-login-hunter.sh
/opt/default-http-login-hunter/default-http-login-hunter.sh $BASE_DIR/clear/80.txt > $BASE_DIR/raw/p80-default-creds.txt

#HTTPS Default Creds
sed -e 's/^/https:\/\//' $BASE_DIR/clear/P443.txt > $BASE_DIR/clear/P443-https.txt
sed -i 's/$/:443/' $BASE_DIR/clear/P443-https.txt
/opt/default-http-login-hunter/default-http-login-hunter.sh $BASE_DIR/clear/P443-https.txt > $BASE_DIR/raw/p443-default-creds.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended Default Web Creds"

echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting SMB Share Without User"
crackmapexec smb $BASE_DIR/clear/P445.txt -d '' -u '' -p '' --shares > $BASE_DIR/raw/SMBSharesNoUser.txt
egrep -e "(WRITE|READ)" $BASE_DIR/raw/SMBSharesNoUser.txt > $BASE_DIR/clear/ShareNoUserClear.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended SMB Share Without User"

echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting SMB Share With User"
crackmapexec smb $BASE_DIR/clear/P445.txt -d $DOMAIN -u $DOM_USER -p $DOM_PASS --shares > $BASE_DIR/raw/SMBSharesWithUser.txt
egrep -e "(WRITE|READ)" $BASE_DIR/raw/SMBSharesWithUser.txt > $BASE_DIR/clear/ShareWithUserClear.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended SMB Share With User"
