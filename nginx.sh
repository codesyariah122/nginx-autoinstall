#!/bin/bash
read -p 'Masukan User Linux Anda: ' userver
read -sp 'password Linux Anda: ' passserver 
echo "Installasi Webserver Nginx" 
echo -e "selamat datang $userver di program installasi Nginx\n"
echo -n "Masukan Nama Anda :"
read nama
echo "Hello $nama"
echo "goodluck $nama"
echo "Selamat Melanjutkan Installasi web server nginx"
echo "|=====================================================|"
echo "|                   Sajak Suara                       |"
echo "|=====================================================|"
echo "|     sesungguhnya suara itu tak bisa diredam         |"
echo "|                mulut bisa dibungkam                 |"
echo "|  namun siapa mampu menghentikan nyanyian bimbang    |" 
echo "|    dan pertanyaan-pertanyaan dari lidah jiwaku      |"
echo "|      suara-suara itu tak bisa dipenjarakan          |"
echo "|          di sana bersemayam kemerdekaan             |"
echo "|           apabila engkau memaksa diam               |"
echo "|       akan kusiapkan untukmu: pemberontakan!        |" 
echo "|                                                     |"
echo "|        sesungguhnya suara itu bukan perampok        |"
echo "|             yang ingin meraih hartamu               |" 
echo "|                 ia ingin bicara                     |" 
echo "|            mengapa kau kokang senjata               |"
echo "|         dan gemetar ketika suara-suara itu          |"
echo "|                menuntut keadilan?                   |"
echo "|                                                     |"
echo "|       sesungguhnya suara itu akan menjadi kata      |"
echo "|          ialah yang mengajari aku bertanya          |"
echo "|          dan pada akhirnya tidak bisa tidak         |" 
echo "|                engkau harus menjawabnya             |"
echo "|            apabila engkau tetap bertahan            |"
echo "|         aku akan memburumu seperti kutukan          |"
echo "|           Wiji Thukul - 1996 (Sajak Suara)          |" 
echo "|=====================================================|"
server="nginx/1.2.1"
versi="nginx-version=$server"
echo $versi;
# cek type OS
os=$(uname -o)
echo -e '\E[32m'"Operating System Type :"  $os
cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' > /tmp/osrelease
echo -n -e '\E[32m'"OS Name :"   && cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\"
echo -n -e '\E[32m'"OS Version :"  && cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\"
# Cek Architecture
architecture=$(uname -m)
echo -e '\E[32m'"Architecture :"  $architecture
# Cek Kernel Release
kernelrelease=$(uname -r)
echo -e '\E[32m'"Kernel Release :"  $kernelrelease
# Cek hostname
echo -e '\E[32m'"Hostname :"  $HOSTNAME
# Cek Internal IP
internalip=$(hostname -I)
echo -e '\E[32m'"Internal IP :"  $internalip
# Cek DNS
nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}')
echo -e '\E[32m'"Name Servers :"  $nameservers 
# Cek Logged In Users
who>/tmp/who
echo -e '\E[32m'"Logged In users :"  && cat /tmp/who 
# Cek RAM and SWAP Usages
free -h | grep -v + > /tmp/ramcache
echo -e '\E[32m'"Ram Usages :" 
cat /tmp/ramcache | grep -v "Swap"
echo -e '\E[32m'"Swap Usages :" 
cat /tmp/ramcache | grep -v "Mem"
# Cek Disk Usages
df -h| grep 'Filesystem\|/dev/sda*' > /tmp/diskusage
echo -e '\E[32m'"Disk Usages :"  
cat /tmp/diskusage
# Cek Load Average
loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo -e '\E[32m'"Load Average :"  $loadaverage
# Cek System Uptime
tecuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e '\E[32m'"System Uptime Days/(HH:MM) :"  $tecuptime
echo -e "Selamat datang di installasi server, \n"
while true; do
    read -p "Lanjutkan installasi?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Tolong jawab yes atau no";;
    esac
done

# informasi perangkat keras                                                     
echo "++ Perangkat keras "                                                      
CPU=`grep "model name" /proc/cpuinfo | head -n 1 | cut -f 2 -d ':'`             
RAM=`grep "MemTotal" /proc/meminfo | cut -f 2 -d ':'`                           
echo " |- CPU : " $CPU                                                          
echo " |- RAM : " $RAM                                                          
echo "++ Sistem Operasi "                                                       
# informasi sistem operasi                                                      
OS=`uname -sr`                                                                  
echo " |- OS : " $OS                                                            
echo " |- Shell : " $SHELL
echo -n "Waktu system   :"; date
echo -n "Distro Info    :"; lsb_release -a
echo -n "Anda           :"; whoami
echo -n "Banyak pemakai :"; who | wc -l
echo "ok langsung ajah"
echo "sambil ngopi brayy duduk yang manis yah"

apt-get update && apt-get upgrade -y
echo "pilih apache saat install phpmyadmin"
echo -e "anda telah selesai mengupdate server, \n"
while true; do
    read -p "Lanjuut?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "jawab aja yes atau no";;
    esac
done      
apt-get update && apt-get upgrade -y
cat /etc/issue
apt-get install nginx -y
service nginx start
rm /usr/share/nginx/www/index.html 
cd www/
cp index-old.html /usr/share/nginx/www/
cd -
nginx -v
nginx -t
cp -R nginx/ /etc/
cp config/sources.list /etc/apt/sources.list
wget http://www.dotdeb.org/dotdeb.gpg
apt-key add dotdeb.gpg
apt-get update
apt-get install php5-fpm php5-common php5-mysql php5-curl -y
service php5-fpm restart
cp -R www/ /usr/share/nginx/
/etc/init.d/nginx restart
apt-get install mysql-server mysql-client -y
service mysql restart
echo "isikan password untu secure installation kemudian ikuti perintah dengan memilih Y"
mysql_secure_installation
apt-get install phpmyadmin 
cp nginx/sites-available/phpmyadmin /etc/nginx/sites-available/phpmyadmin
ln -s /etc/nginx/sites-available/phpmyadmin /etc/nginx/sites-enabled/phpmyadmin
service nginx restart
echo -e "selamat anda telah menginstall nginx/1.2.1, \n"
echo -e "untuk mencobanya bisa buka di broser ipserver:5555"
echo "selesai_"
while true; do
    read -p "apakah anda mau merestart terlebih dahulu?" yn
    case $yn in
        [Yy]* ) init 6; break;;
        [Nn]* ) exit;;
        * ) echo "jawab aja yes untuk merestart atau no untuk keluar dari shell";;
    esac
done