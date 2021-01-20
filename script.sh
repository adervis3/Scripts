BASE_DIR=$(pwd)
DOM_USER=""
DOMAIN=""
DOM_PASS=""
COMMERCIAL="demo_comp"

mkdir clear
mkdir raw
mkdir resource

echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting Network Enumeration"
nmap -p 21,22,23,25,80,443,445,8080,8081,5900,1433,1521,3306,5432,27017,9300,3260 -T4 -n --open -Pn -oG $BASE_DIR/raw/Ports-raw.txt -iL $BASE_DIR/kapsam.txt
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


#FTP Brute
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/FTP.rc
echo "use auxiliary/scanner/ftp/ftp_login" >> $BASE_DIR/resource/FTP.rc
echo "set RHOSTS file:$BASE_DIR/clear/P21.txt" >> $BASE_DIR/resource/FTP.rc
echo "set USER_FILE $BASE_DIR/user" >> $BASE_DIR/resource/FTP.rc
echo "set PASS_FILE $BASE_DIR/pass" >> $BASE_DIR/resource/FTP.rc
echo "set THREADS 20" >> $BASE_DIR/resource/FTP.rc
echo "spool $BASE_DIR/raw/ftp-brute-raw.txt" >> $BASE_DIR/resource/FTP.rc
echo "run" >> $BASE_DIR/resource/FTP.rc
echo "spool off" >> $BASE_DIR/resource/FTP.rc
echo "exit" >> $BASE_DIR/resource/FTP.rc

#SSH Brute
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/SSH.rc
echo "use auxiliary/scanner/ssh/ssh_login" >> $BASE_DIR/resource/SSH.rc
echo "set RHOSTS file:$BASE_DIR/clear/P22.txt" >> $BASE_DIR/resource/SSH.rc
echo "set USER_FILE $BASE_DIR/user" >> $BASE_DIR/resource/SSH.rc
echo "set PASS_FILE $BASE_DIR/pass" >> $BASE_DIR/resource/SSH.rc
echo "set THREADS 20" >> $BASE_DIR/resource/SSH.rc
echo "spool $BASE_DIR/raw/ssh-brute-raw.txt" >> $BASE_DIR/resource/SSH.rc
echo "run" >> $BASE_DIR/resource/SSH.rc
echo "spool off" >> $BASE_DIR/resource/SSH.rc
echo "exit" >> $BASE_DIR/resource/SSH.rc

#Telnet Brute
echo "workspace -a $COMMERCIAL" > $BASE_DIR/resource/TELNET.rc
echo "use auxiliary/scanner/telnet/telnet_login" >> $BASE_DIR/resource/TELNET.rc
echo "set RHOSTS file:$BASE_DIR/clear/P23.txt" >> $BASE_DIR/resource/TELNET.rc
echo "set USER_FILE $BASE_DIR/user" >> $BASE_DIR/resource/TELNET.rc
echo "set PASS_FILE $BASE_DIR/pass" >> $BASE_DIR/resource/TELNET.rc
echo "set THREADS 20" >> $BASE_DIR/resource/TELNET.rc
echo "spool $BASE_DIR/raw/telnet-brute-raw.txt" >> $BASE_DIR/resource/TELNET.rc
echo "run" >> $BASE_DIR/resource/TELNET.rc
echo "spool off" >> $BASE_DIR/resource/TELNET.rc
echo "exit" >> $BASE_DIR/resource/TELNET.rc
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



echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting SMB Share Without User"
crackmapexec smb $BASE_DIR/clear/P445.txt -d '' -u '' -p '' --shares > $BASE_DIR/raw/SMBSharesNoUser.txt
egrep "(WRITE|READ,WRITE,WRITE)" $BASE_DIR/raw/SMBSharesNoUser.txt > $BASE_DIR/clear/ShareNoUserClear.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended SMB Share Without User"

echo ""
echo "$(tput setaf 4)$(tput bold)[*]$(tput sgr0) Starting SMB Share With User"
crackmapexec smb $BASE_DIR/clear/P445.txt -d $DOMAIN -u $DOM_USER -p $DOM_PASS --shares > $BASE_DIR/raw/SMBSharesWithUser.txt
egrep "(WRITE|READ,WRITE,WRITE)" $BASE_DIR/raw/SMBSharesWithUser.txt > $BASE_DIR/clear/ShareWithUserClear.txt
echo "$(tput setaf 2)$(tput bold)[+]$(tput sgr0) Ended SMB Share With User"
