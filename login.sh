username="202221140000"
password="passwd123456"
ip=`curl http://10.50.255.11/a79.htm 2>/dev/null | sed -n "s/^.*v46ip='\(.*\)'.*$/\1/p"`

# 中国移动
isp="cmcc"
# 中国电信
# isp="telecom"

curl "http://10.50.255.11:801/eportal/portal/login?callback=dr1003&user_account=%2C0%2C${username}%40${isp}&user_password=${password}&wlan_user_ip=${ip}&wlan_user_mac=000000000000&lang=zh"
