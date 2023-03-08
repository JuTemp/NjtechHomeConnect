#!/bin/sh

username="202221140000"
password="passwd123456"
max_retry=200
max_try=3
if [ "$1" ]; then this_try="$1"; else this_try=0; fi 

# 中国电信
channelshow="%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1"
channel="%40telecom"

# 中国移动
channelshow="%E4%B8%AD%E5%9B%BD%E7%A7%BB%E5%8A%A8"
channel="%40cmcc"

curl -i -s -L 'https://u.njtech.edu.cn/cas/login?service=https%3A%2F%2Fu.njtech.edu.cn%2Foauth2%2Fauthorize%3Fclient_id%3DOe7wtp9CAMW0FVygUasZ%26response_type%3Dcode%26state%3Dnjtech%26s%3Df682b396da8eb53db80bb072f5745232' > NjtechHomeHtml

para[1]=`sed -n -r '1,20s/^.*?JSESSIONID=(.*?);.*?;.*?$/\1/gp' NjtechHomeHtml`
para[2]=`sed -n -r '1,20s/^.*?insert_cookie=([0-9]{8});.*?$/\1/gp' NjtechHomeHtml`
para[3]=`sed -n -r '1,200s/^.*?name\=\"lt\" value\=\"(.*?)\"\/>.*?$/\1/gp' NjtechHomeHtml`
para[4]=`sed -n -r '1,200s/^.*?name\=\"execution\" value\=\"(.*?)\"\/>.*?$/\1/gp' NjtechHomeHtml`

curl -s 'https://u.njtech.edu.cn/cas/captcha.jpg?0.29064673903582183' -H "Cookie: JSESSIONID=${para[1]}; insert_cookie=${para[2]}" --output captcha.jpg
shasumCaptcha=`sha1sum captcha.jpg | cut -d ' ' -f 1`
para[5]=`sed -n "/^$shasumCaptcha/p" RainbowNjtechHomeKeys | cut -d ' ' -f 2`

while [ -z ${para[5]} ]; do
  if [ ${max_retry} -eq 0 ] ; then echo "Login fail. Max Retry."; exit; else max_retry=$((max_retry-1)); fi
  curl -s 'https://u.njtech.edu.cn/cas/captcha.jpg?0.29064673903582183' -H "Cookie: JSESSIONID=${para[1]}; insert_cookie=${para[2]}" --output captcha.jpg
  shasumCaptcha=`sha1sum captcha.jpg | cut -d ' ' -f 1`
  para[5]=`sed -n "/^$shasumCaptcha/p" RainbowNjtechHomeKeys | cut -d ' ' -f 2`
done

echo ${para[@]} $shasumCaptcha

curl -s -XPOST "https://u.njtech.edu.cn/cas/login;jsessionid=${para[1]}?service=https%3A%2F%2Fu.njtech.edu.cn%2Foauth2%2Fauthorize%3Fclient_id%3DOe7wtp9CAMW0FVygUasZ%26response_type%3Dcode%26state%3Dnjtech%26s%3Df682b396da8eb53db80bb072f5745232" -H "Cookie: JSESSIONID=${para[1]}; insert_cookie=${para[2]}" -d "username=${username}&password=${password}&captcha=${para[5]}&channelshow=${channelshow}&channel=${channel}&lt=${para[3]}&execution=${para[4]}&_eventId=submit" -L | grep -o 'window.location.href = "/oauth2/logout?retUrl=https://i.njtech.edu.cn";' > /dev/null

if [ $? -eq 0 ]
  then echo "Login Success."
else
  if [ ${this_try} -gt ${max_try} ]
    then echo "Max Try. Exit."
    else echo "Login Fail. Retrying."; bash login.bash $(( $1 + 1 ))
  fi
fi
