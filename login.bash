#!/bin/sh

username="202221140000"
password="passwd123456"

curl -i -s -L 'https://u.njtech.edu.cn/cas/login?service=https%3A%2F%2Fu.njtech.edu.cn%2Foauth2%2Fauthorize%3Fclient_id%3DOe7wtp9CAMW0FVygUasZ%26response_type%3Dcode%26state%3Dnjtech%26s%3Df682b396da8eb53db80bb072f5745232' > NjtechHomeC1Html

para[1]=`sed -n -r '1,20s/^.*?JSESSIONID=(.*?);.*?;.*?$/\1/gp' NjtechHomeC1Html`
para[2]=`sed -n -r '1,20s/^.*?insert_cookie=([0-9]{8});.*?$/\1/gp' NjtechHomeC1Html`
para[3]=`sed -n -r '1,200s/^.*?name\=\"lt\" value\=\"(.*?)\"\/>.*?$/\1/gp' NjtechHomeC1Html`
para[4]=`sed -n -r '1,200s/^.*?name\=\"execution\" value\=\"(.*?)\"\/>.*?$/\1/gp' NjtechHomeC1Html`

curl -s 'https://u.njtech.edu.cn/cas/captcha.jpg?0.29064673903582183' -H "Cookie: JSESSIONID=${para[1]}; insert_cookie=${para[2]}" --compressed  --output captcha.jpg
shasumCaptcha=`sha1sum captcha.jpg | cut -d ' ' -f 1`
para[5]=`sed -n "/^$shasumCaptcha/p" RainbowNjtechHomeKeys | cut -d ' ' -f 2`

while [ -z ${para[5]} ]; do
  curl -s 'https://u.njtech.edu.cn/cas/captcha.jpg?0.29064673903582183' -H "Cookie: JSESSIONID=${para[1]}; insert_cookie=${para[2]}" --compressed  --output captcha.jpg
  shasumCaptcha=`sha1sum captcha.jpg | cut -d ' ' -f 1`
  para[5]=`sed -n "/^$shasumCaptcha/p" RainbowNjtechHomeKeys | cut -d ' ' -f 2`
done

echo ${para[@]} $shasumCaptcha

curl -s -XPOST "https://u.njtech.edu.cn/cas/login;jsessionid=${para[1]}?service=https%3A%2F%2Fu.njtech.edu.cn%2Foauth2%2Fauthorize%3Fclient_id%3DOe7wtp9CAMW0FVygUasZ%26response_type%3Dcode%26state%3Dnjtech%26s%3Df682b396da8eb53db80bb072f5745232" -H "Cookie: JSESSIONID=${para[1]}; insert_cookie=${para[2]}" -d "username=${username}&password=${password}&captcha=${para[5]}&channelshow=%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1&channel=%40telecom&lt=${para[3]}&execution=${para[4]}&_eventId=submit" \ --compressed  -L | grep -o 'window.location.href = "/oauth2/logout?retUrl=https://i.njtech.edu.cn";' > /dev/null

if [ $? -eq 0 ] ; then echo "Login Success." ; else echo "Login Fail. Retrying." ; bash login.bash ; fi

