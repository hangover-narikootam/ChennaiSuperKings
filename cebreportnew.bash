#!/bin/bash

#########################################################################################
# Created by: Pandiyan Kuppan                                                           #
# Created on: 01 Jan 2022                                                               #
# Subject:  Eagleview                                                                   #
#########################################################################################

sh /fras/cebscr/checkup/bin/reportchk

ARG_EMAIL_TO=Vijin.Das@fisglobal.com
ARG_EMAIL_FROM=Vijin.Das@fisglobal.com
ARG_EMAIL_SUBJECT="PDC Health Check Report"

report=/fras/cebscr/checkup/out/report.html
inputfile=/fras/cebscr/checkup/pdc_health.csv
gigastat=/fras/cebscr/checkup/out/giga.log
ping_out=/fras/cebscr/checkup/out/ping_pdc.log
cpu_critcal=/fras/cebscr/checkup/logs/pdc_server_cpu.log
disk_critcal=/fras/cebscr/checkup/logs/pdc_server_disk.log
jvm_critcal=/fras/cebscr/checkup/logs/pdc_server_jvm.log
health=/fras_bdc/opsnet/rptview/eaglepdc.php
mount_critical=/fras/cebscr/checkup/logs/pdc_server_mount.log
contm_critcal=/fras/cebscr/checkup/logs/pdc_server_ctm.log
mem_critcal=/fras/cebscr/checkup/logs/pdc_server_mem.log
telnetstat=/fras/cebscr/checkup/logs/telnetstatus.log
ftpresults=/fras/cebscr/checkup/logs/FTPResults.log
oaclogin=/fras/cebscr/checkup/logs/oaclogin.txt
ceblogin=/fras/cebscr/checkup/logs/ceblogin.txt
gigaspacestat=/fras/cebscr/checkup/logs/gigaservice_new.log
telnetimsstat=/fras/cebscr/checkup/out/telnetims.log
services=/fras/cebscr/checkup/logs/services.log
synthlogin=/fras/cebscr/checkup/logs/synthmon.log
splunk_critical=/fras/cebscr/checkup/logs/pdc_server_splunk.log

diskmail=`stat -c%s $disk_critcal`
mountmail=`stat -c%s $mount_critical`
contmmail=`stat -c%s $contm_critcal`
cpumail=`stat -c%s $cpu_critcal`
jvmmail=`stat -c%s $jvm_critcal`
memmail=`stat -c%s $mem_critcal`

CURRENT_TIME=$(date +%H:%M)
dtime=`date +'%m/%d/%Y %H:%M:%S %p'`

sed -i '/^$/d' $inputfile
sed -i '/^$/d' $gigaspacestat
sed -i '/^$/d' $ftpresults
sed -i '/^$/d' $jvm_critcal
sort -o $inputfile $inputfile
sort -o $gigastat $gigastat

cat /fras/cebscr/checkup/logs/pdc2rdftoacap01GCSER.log /fras/cebscr/checkup/logs/pdc2rdftoacap02GCSER.log >$services
sed -i '/^$/d' $services

echo -e '<html style="width:100%;height:100%;padding:0;margin:0;position:relative;text-align:center;">
<head><meta http-equiv="Content-Type" content="text/html; charset=us-ascii"></head><body style="background-color: white; position: relative; text-align: center; padding: 0; margin: 0;display: inline-block;"><div style="position: relative; text-align: center;">
<table style="background-color:#ffcc99; position: relative; text-align: center;" width="1200px" cellspacing="0px" cellpadding="5px">
<tr><td colspan="7"><table style="background-color:#4d4d4d;" width="1200px" cellspacing="0px" cellpadding="5px">
<tr><td width="10"></td><td width="100" align="left"></td><td width="650" align="right">'>$report
echo -e '<h1 style="font-family: Courier; color:orange;text-align: center; font-size: 20px">'>>$report
echo -e "PDC - Eagle View Report $dtime &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h1></td></tr>">>$report
echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier;font-weight: bold; color: Yellow; font-size: 13px; background-color:#ffcc99"><td align="center" width="300"><a href=https://splunk.fnfis.com/en-US/app/ceb/ceb_retail style="text-decoration: none;">Splunk Retail Dashboard</a></td>
<td align="center" width="300"><a href=https://splunk.fnfis.com/en-US/app/ceb/ceb_ws style="text-decoration: none;">Splunk Mobile Dashboard</a></td>
<td align="center" width="300"><a href=https://splunk.fnfis.com/en-US/app/ceb/ceb_sso_banks style="text-decoration: none;">Splunk SSO Dashboard</a></td>
<td align="center" width="300"><a href=https://splunk.fnfis.com/en-US/app/ceb/ccb_error_monitoring style="text-decoration: none;">Splunk CCB Monitoring</a></td></tr>'>>$report

echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier;font-weight: bold; color: Yellow; font-size: 13px; background-color:#ffcc99"><td align="center" width="300"><a href=https://localhost:84/rptview/phxmonitor.php style="text-decoration: none;">Monitor</a></td>
<td align="center" width="300"><a href=https://localhost:84/rptview/retail_activessn.php style="text-decoration: none;">Retail Active Sessions</a></td>
<td align="center" width="300"><a href=https://localhost:84/rptview/responstime.php style="text-decoration: none;">Retail JVM response time</a></td>
<td align="center" width="300"><a href=https://localhost:84/rptview/ws_active_session.php style="text-decoration: none;">Mobile Active Sessions</a></td></tr>'>>$report

echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier;font-weight: bold; color: Yellow; font-size: 13px; background-color:#ffcc99"><td align="center" width="300"><a href=https://localhost:84/rptview/ofxcalls.php style="text-decoration: none;">mbofx Calls</a></td>
<td align="center" width="300"><a href=https://localhost:84/rptview/idscalls.php style="text-decoration: none;">IDS call hits</a></td>
<td align="center" width="300"><a href=https://localhost:84/rptview/ctmadashboard.php style="text-decoration: none;">Batch JOb Status</a></td>
<td align="center" width="300"><a href=https://localhost:84/rptview/FAQ.php style="text-decoration: none;">FAQ</a></td></tr>'>>$report

echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier; color: Yellow; font-size: 17px; background-color:#808080"><td align="center" width="105">Server</td>
<td align="center" width="105">JVM</td><td align="center" width="110">CPU</td><td align="center" width="100">DISK</td><td align="center" width="110">MOUNT</td><td align="center" width="90">CONT-M</td><td align="center" width="90">FREE MEMORY</td></tr>'>>$report

while IFS= read -r line
do
  echo "$line"
  host=`echo "$line" |cut -d ":" -f1`
  jvm=`echo "$line" |cut -d "," -f2`
  cpu=`echo "$line" |cut -d "," -f3`
  disk=`echo "$line" |cut -d "," -f4`
  mounts=`echo "$line" |cut -d "," -f5`
  contm=`echo "$line" |cut -d "," -f6`
  mem=`echo "$line" |cut -d "," -f7`
  splunk=`echo "$line" |cut -d "," -f8`

if [ "$jvm" = "Critical" ]; then jbgclr=#ff8080; else jbgclr=green; fi
if [ "$cpu" = "Critical" ]; then cbgclr=#ff8080; else cbgclr=green; fi
if [ "$disk" = "Critical" ]; then dbgclr=#ff8080; else dbgclr=green; fi
if [ "$mounts" = "Critical" ]; then mbgclr=#ff8080; else mbgclr=green; fi
if [ "$contm" = "Critical" ]; then c2bgclr=#ff8080; else c2bgclr=green; fi
if [ "$mem" -le 5 ]; then c3bgclr=#ff8080; else c3bgclr=green; fi
if [ "$splunk" = "Critical" ]; then sbgclr=#ff8080; else sbgclr=green; fi

echo -e '<tr style="font-family: Courier; color: white; font-size: 15px; background-color:black">'>>$report
echo -e "<td td align="center" width="90">$host</td>">>$report
echo -e "<td align="center" width="90" bgcolor=$jbgclr>$jvm</td>">>$report
echo -e "<td align="center" width="90" bgcolor=$cbgclr>$cpu</td>">>$report
echo -e "<td align="center" width="90" bgcolor=$dbgclr>$disk</td>">>$report
echo -e "<td align="center" width="90" bgcolor=$mbgclr>$mounts</td>">>$report
echo -e "<td align="center" width="90" bgcolor=$c2bgclr>$contm</td>">>$report
echo -e "<td align="center" width="85" bgcolor=$c3bgclr>"${mem}%"</td>">>$report
echo -e "<td align="center" width="85" bgcolor=$sbgclr>$splunk</td>">>$report
echo -e "</tr>">>$report
done < "$inputfile"
echo -e "</table>">>$report

if [ $jvmmail -gt 1 ]
then
echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier; color: Yellow; font-size: 13px; background-color:#808080"><td align="center" width="500">JVM OBSERVATION</td>
<td align="center" width="255">STAUS</td></tr>'>>$report
while IFS= read -r line
do
  echo "$line"
  jvm=`echo "$line" |awk '{print $1F}'`
echo -e '<tr style="font-family: Courier; color: white; font-size: 12px; background-color:black">'>>$report
echo -e "<td td align="center" width="500">$jvm</td>">>$report
echo -e "<td align="center" width="200">Critical</td>">>$report
echo -e "</tr>">>$report
done < "$jvm_critcal"
echo -e "</table>">>$report
fi

if [ $cpumail -gt 1 ]
then
echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier; color: Yellow; font-size: 13px; background-color:#808080"><td align="center" width="110">SERVER</td>
<td align="center" width="535">HIGH CPU PROCESS</td>
<td align="center" width="100">UTIL</td></tr>'>>$report
while IFS= read -r line
do
  echo "$line"
  host=`echo "$line" |cut -d ":" -f1`
  proc=`echo "$line" |cut -d ":" -f3`
  util=`echo "$line" |cut -d ":" -f4`
echo -e '<tr style="font-family: Courier; color: white; font-size: 12px; background-color:black">'>>$report
echo -e "<td td align="center" width="110">$host</td>">>$report
echo -e "<td td align="center" width="535">$proc</td>">>$report
echo -e "<td align="center" width="100">"${util}"</td>">>$report
echo -e "</tr>">>$report
done < "$cpu_critcal"
echo -e "</table>">>$report
fi

if [ $diskmail -gt 1 ]
then
echo -e '</table></td></tr><tr><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><tr style="font-family: Courier;font-weight: bold; color: black; font-size: 13px; background-color:#ffcc99"><td align="center" width="775"><a href=https://localhost:84/rptview/fsreport.html>Click here for Disk cleanup View</a></td>'>>$report

echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier; color: Yellow; font-size: 13px; background-color:#808080"><td align="center" width="110">SERVER</td>
<td align="center" width="535">FILESYSTEM</td>
<td align="center" width="100">UTIL</td></tr>'>>$report
while IFS= read -r line
do
  echo "$line"
  host=`echo "$line" |cut -d ":" -f1`
  disk=`echo "$line" |cut -d ":" -f4`
  util=`echo "$line" |cut -d ":" -f3`
echo -e '<tr style="font-family: Courier; color: white; font-size: 12px; background-color:black">'>>$report
echo -e "<td td align="center" width="110">$host</td>">>$report
echo -e "<td td align="center" width="535">$disk</td>">>$report
echo -e "<td align="center" width="100">"${util}"</td>">>$report
echo -e "</tr>">>$report
done < "$disk_critcal"
echo -e "</table>">>$report
fi

if [ $memmail -gt 1 ]
then

echo -e '</table></td></tr><tr><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><tr style="font-family: Courier;font-weight: bold; color: black; font-size: 13px; background-color:#ffcc99"><td align="center" width="775"><a href=https://localhost:84/rptview/lrpreport.html>Click here for Long Running Process View</a></td>'>>$report

echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier; color: Yellow; font-size: 13px; background-color:#808080"><td align="center" width="110">SERVER</td>
<td align="center" width="335">PROCESS</td>
<td align="center" width="100">PID</td>
<td align="center" width="100">OWNER</td>
<td align="center" width="100">CPU</td>
<td align="center" width="100">UTIL</td></tr>'>>$report
while IFS= read -r line
do
  echo "$line"
  host=`echo "$line" |cut -d ":" -f1`
  vmem=`echo "$line" |cut -d ":" -f3`
  vcpu=`echo "$line" |cut -d ":" -f4`
  vpid=`echo "$line" |cut -d ":" -f5`
  vusr=`echo "$line" |cut -d ":" -f6`
  proc=`echo "$line" |cut -d ":" -f7`
echo -e '<tr style="font-family: Courier; color: white; font-size: 12px; background-color:black">'>>$report
echo -e "<td td align="center" width="110">$host</td>">>$report
echo -e "<td td align="center" width="335">$proc</td>">>$report
echo -e "<td td align="center" width="100">$vpid</td>">>$report
echo -e "<td td align="center" width="100">$vusr</td>">>$report
echo -e "<td td align="center" width="100">$vcpu</td>">>$report
echo -e "<td align="center" width="100">$vmem</td>">>$report
echo -e "</tr>">>$report
done < "$mem_critcal"
echo -e "</table>">>$report
fi

if [ $mountmail -gt 1 ]
then
echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier; color: Yellow; font-size: 13px; background-color:#808080"><td align="center" width="100">SERVER</td>
<td align="center" width="655">MOUNT OBSERVATION </td></tr>'>>$report
while IFS= read -r line
do
  echo "$line"
  host=`echo "$line" |awk '{print $1F}'`
  mount=`echo "$line" |awk '{print $NF}'`
echo -e '<tr style="font-family: Courier; color: white; font-size: 12px; background-color:black">'>>$report
echo -e "<td td align="center" width="100">$host</td>">>$report
echo -e "<td align="center" width="655">$mount</td>">>$report
echo -e "</tr>">>$report
done < "$mount_critical"
echo -e "</table>">>$report
fi

if [ $contmmail -gt 1 ]
then
echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier; color: Yellow; font-size: 13px; background-color:#808080"><td align="center" width="500">CONT-M SERVICES</td>
<td align="center" width="255"> STATUS </td></tr>'>>$report
while IFS= read -r line
do
  echo "$line"
  host=`echo "$line" |awk '{print $1F}'`
echo -e '<tr style="font-family: Courier; color: white; font-size: 12px; background-color:black">'>>$report
echo -e "<td td align="center" width="500">$host</td>">>$report
echo -e "<td align="center" width="255">Critical</td>">>$report
echo -e "</tr>">>$report
done < "$contm_critcal"
echo -e "</table>">>$report
fi

sh /fras/cebscr/checkup/bin/probcalls
sh /fras/cebscr/checkup/bin/httpcalls
sh /fras/cebscr/checkup/bin/synthlogin
sh /fras/cebscr/checkup/bin/gigaspace
sh /fras/cebscr/checkup/bin/longprocess
sh /fras/cebscr/checkup/bin/FAQ_rpt

echo -e '</table></td></tr><tr><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><tr style="font-family: Courier;font-weight: bold; color: black; font-size: 13px; background-color:#ffcc99"><td align="center" width="775">Horizon Banks telnet Validations</td>'>>$report

echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier; color: Yellow; font-size: 13px; background-color:#808080"><td align="center" width="90"> IP </td>
<td align="center" width="50"> PORT </td>
<td align="center" width="400">HORIZON_BANKS</td>
<td align="center" width="45">FI</td>
<td align="center" width="50">LPAR</td>
<td align="center" width="100"> STATUS </td></tr>'>>$report
while IFS= read -r line
do
  echo "$line"
IP=`echo "$line" |cut -d " " -f1`
port=`echo "$line" |cut -d " " -f2`
bank=`echo "$line" |cut -d "-" -f1 |awk -F " " '{print $3" "$4" "$5" "$6" "$7}'`
forg=`echo "$line" |awk -F "-" '{print $2}'`
lpar=`echo "$line" |cut -d "-" -f4`
stat=`echo "$line" |cut -d "-" -f5`

if [ $stat = "Success" ]
then
bgclr=green
else
bgclr=red
fi

echo -e '<tr style="font-family: Courier; color: white; font-size: 12px; background-color:black">'>>$report
echo -e "<td td align="center" width="90">$IP</td>">>$report
echo -e "<td td align="center" width="50">$port</td>">>$report
echo -e "<td td align="center" width="400">$bank</td>">>$report
echo -e "<td td align="center" width="45">$forg</td>">>$report
echo -e "<td td align="center" width="50">$lpar</td>">>$report
echo -e "<td align="center" width="100" bgcolor=$bgclr>$stat</td>">>$report
echo -e "</tr>">>$report
done < "$telnetstat"
echo -e "</table>">>$report

echo -e '</table></td></tr><tr><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><tr style="font-family: Courier;font-weight: bold; color: black; font-size: 13px; background-color:#ffcc99"><td align="center" width="775">Successfull Logins in past 1 hour</td>'>>$report

echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier; color: Yellow; font-size: 13px; background-color:#808080"><td align="center" width="485">APPLICATION</td>
<td align="center" width="165">VOLUMES(1hour)</td>
<td align="center" width="100"> STATUS </td></tr>'>>$report

name=`cat $oaclogin |awk -F ":" '{print $1}'`
login=`cat $oaclogin |awk -F ":" '{print $2}'`
stat=`cat $oaclogin |awk -F ":" '{print $3}'`

if [ "$stat" = "GOOD" ]
then
bgclr=green
elif [ "$stat" = "OKAY" ]
then
bgclr=#FFC300
else
bgclr=red
fi

echo -e '<tr style="font-family: Courier; color: white; font-size: 12px; background-color:black">'>>$report
echo -e "<td td align="center" width="485">$name</td>">>$report
echo -e "<td align="center" width="165">$login</td>">>$report
echo -e "<td align="center" width="100" bgcolor=$bgclr>$stat</td>">>$report
ceblogcount=`stat -c%s $ceblogin`
echo "$CURRENT_TIME : $ceblogcount">>/fras/cebscr/checkup/out/ceblog.log
sleep 1
name1=`cat $ceblogin |awk -F ":" '{print $1}'`
login1=`cat $ceblogin |awk -F ":" '{print $2}'`
stat1=`cat $ceblogin |awk -F ":" '{print $3}'`

if [ "$stat1" = "GOOD" ]
then
bgclr=green
elif [ "$stat1" = "OKAY" ]
then
bgclr=#FFC300
else
bgclr=red
fi

echo -e '<tr style="font-family: Courier; color: white; font-size: 13px; background-color:black">'>>$report
echo -e "<td td align="center" width="485">$name1</td>">>$report
echo -e "<td align="center" width="165">$login1</td>">>$report
echo -e "<td align="center" width="100" bgcolor=$bgclr>$stat1</td>">>$report
echo -e "</tr>">>$report
echo -e "</table>">>$report

echo -e '</table></td></tr><tr><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><tr style="font-family: Courier;font-weight: bold; color: black; font-size: 13px; background-color:#ffcc99"><td align="center" width="775">OAC Service Status</td>'>>$report

echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier; color: Yellow; font-size: 13px; background-color:#808080"><td align="center" width="110">SERVER</td>
<td align="center" width="525">APPLICATION SERVICE NAME</td>
<td align="center" width="100"> STATUS </td></tr>'>>$report

while IFS= read -r line
do
  host=`echo "$line" |awk -F "," '{print $1}'`
  name=`echo "$line" |awk -F "," '{print $2}'`
  stat1=`echo "$line" |awk -F "," '{print $3}'`

if [ $stat1 = "1" ]
then
stat="RUNNING"
bgclr=green
else
stat="NOT RUNNING"
bgclr=#FFC300
fi

echo -e '<tr style="font-family: Courier; color: white; font-size: 12px; background-color:black">'>>$report
echo -e "<td td align="center" width="110">$host</td>">>$report
echo -e "<td align="center" width="525">$name</td>">>$report
echo -e "<td align="center" width="100" bgcolor=$bgclr>$stat</td>">>$report
echo -e "</tr>">>$report
done < "$services"
echo -e "</table>">>$report

echo -e '</table></td></tr><tr><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><tr style="font-family: Courier;font-weight: bold; color: black; font-size: 13px; background-color:#ffcc99"><td align="center" width="775">Ping VIP Validations</td>'>>$report

while IFS= read -r line
do
  echo "$line"
  host=`echo "$line" |awk '{print $1F}'`
  stat=`echo "$line" |awk '{print $NF}'`
if [ "$stat" = "Success" ]
then
bgclr=green
else
bgclr=red
fi

echo -e '<tr style="font-family: Courier; color: white; font-size: 12px; background-color:black">'>>$report
echo -e "<td td align="center" width="655">$host</td>">>$report
echo -e "<td align="center" width="120" bgcolor=$bgclr>$stat</td>">>$report
echo -e "</tr>">>$report
done < "$ping_out"
echo -e "</table>">>$report

sh /fras/cebscr/checkup/bin/certcheck

echo -e '</table></td></tr><tr><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><tr style="font-family: Courier;font-weight: bold; color: black; font-size: 13px; background-color:#ffcc99"><td align="center" width="775">OAC-IMS telnet Validations</td>'>>$report

echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier; color: Yellow; font-size: 13px; background-color:#808080"><td align="center" width="45">IMSA</td>
<td align="center" width="45">IMSC</td>
<td align="center" width="45">IMSE</td>
<td align="center" width="45">IMSF</td>
<td align="center" width="45">IMSG</td>
<td align="center" width="45">IMSH</td>
<td align="center" width="45">IMSI</td>
<td align="center" width="45">IMSK</td>
<td align="center" width="45">IMSL</td>
<td align="center" width="45">IMSM</td>
<td align="center" width="45">IMSO</td>
<td align="center" width="45">IMSQ</td>
<td align="center" width="45">IMSR</td>
<td align="center" width="45">IMSS</td>
<td align="center" width="45">IMST</td>
<td align="center" width="45">IMSV</td></tr>'>>$report

imsa=`cat $telnetimsstat |grep -i 'IMSA' |cut -d "-" -f2`
imsc=`cat $telnetimsstat |grep -i 'IMSC' |cut -d "-" -f2`
imse=`cat $telnetimsstat |grep -i 'IMSE' |cut -d "-" -f2`
imsf=`cat $telnetimsstat |grep -i 'IMSF' |cut -d "-" -f2`
imsg=`cat $telnetimsstat |grep -i 'IMSG' |cut -d "-" -f2`
imsh=`cat $telnetimsstat |grep -i 'IMSH' |cut -d "-" -f2`
imsi=`cat $telnetimsstat |grep -i 'IMSI' |cut -d "-" -f2`
imsk=`cat $telnetimsstat |grep -i 'IMSK' |cut -d "-" -f2`
imsl=`cat $telnetimsstat |grep -i 'IMSL' |cut -d "-" -f2`
imsm=`cat $telnetimsstat |grep -i 'IMSM' |cut -d "-" -f2`
imso=`cat $telnetimsstat |grep -i 'IMSO' |cut -d "-" -f2`
imsq=`cat $telnetimsstat |grep -i 'IMSQ' |cut -d "-" -f2`
imsr=`cat $telnetimsstat |grep -i 'IMSR' |cut -d "-" -f2`
imss=`cat $telnetimsstat |grep -i 'IMSS' |cut -d "-" -f2`
imst=`cat $telnetimsstat |grep -i 'IMST' |cut -d "-" -f2`
imsv=`cat $telnetimsstat |grep -i 'IMSV' |cut -d "-" -f2`

echo -e '<tr style="font-family: Courier; color: white; font-size: 14px; background-color:green">'>>$report
echo -e "<td td align="center" width="40">$imsa</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imsc</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imse</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imsf</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imsg</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imsh</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imsi</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imsk</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imsl</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imsm</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imso</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imsq</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imsr</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imss</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imst</td>">>$report
echo -e "<td align="center" width="40" bgcolor=green>$imsv</td>">>$report
echo -e "</tr>">>$report
echo -e "</table>">>$report

echo -e '</table></td></tr><tr><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><td colspan="0"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="0px"><tr style="font-family: Courier;font-weight: bold; color: black; font-size: 13px; background-color:#ffcc99"><td align="center" width="775">FTP Validations</td>'>>$report

echo -e '</table></td></tr><tr><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><td colspan="8"><table style="background-color:#ffcc99;" width="1200px" cellspacing="0px" cellpadding="1px"><tr style="font-family: Courier; color: Yellow; font-size: 13px; background-color:#808080"><td align="center" width="115">FTP_NAME</td>
<td align="center" width="400"> FTP_SERVER </td>
<td align="center" width="100"> STATUS </td></tr>'>>$report
sed -i '/^$/d' $ftpresults
while IFS= read -r line
do

  name=`echo "$line" |awk -F "|" '{print $1}'`
  host=`echo "$line" |awk -F "|" '{print $2}'`
  stat=`echo "$line" |awk -F "|" '{print $5}'`

if [ "$stat" = "Success" ]
then
bgclr=green
else
bgclr=red
fi

echo -e '<tr style="font-family: Courier; color: white; font-size: 12px; background-color:black">'>>$report
echo -e "<td td align="center" width="115">$name</td>">>$report
echo -e "<td align="center" width="535">$host</td>">>$report
echo -e "<td align="center" width="100" bgcolor=$bgclr>$stat</td>">>$report
echo -e "</tr>">>$report
done < "$ftpresults"
echo -e "</table>">>$report

cp $report $health

mail=`stat -c%s $inputfile`
CURDATE=`date +'%Y-%m-%d:%H:%M:%S'`
sh /fras/cebscr/checkup/bin/mailalert 2>>/fras/cebscr/temp/mailalerterr.log

#if [ $mail -gt 1 ]
#then
#python /fras/cebscr/checkup/bin/cebrep.py
#else
#echo "$CURDATE report not ready for email">>/fras/cebscr/checkup/out/maillog.log
#fi
