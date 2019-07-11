#!/bin/bash

echo "Executing a bash statement"
export bashvar=100

cat << EOF > cyberautologin.py
#!/usr/bin/python3
import urllib.request
import re
import time 
import ssl

host_url = 'https://172.16.1.1:8090/httpclient.html'
username = ['be1050616' , 'be1044416']
password = ['xxx','xxx']

def user_validity(num):
    try:
            req = urllib.request.Request(host_url)
            data = 'mode=191&username='+username[num]+'&password='+password[num] +'&a=1549598897889'
            data = data.encode('utf-8')
            context = ssl._create_unverified_context()
            get = urllib.request.urlopen(host_url,data, context=context)
            getData = get.read()
            getData = getData.decode('ascii')
            message = re.findall(r'<message>(.*?)</message>',str(getData))
            return message[0]
        
    except urllib.error.URLError as err:
            print(str(err))


num = 0
while(1):
    message = user_validity(num)
    if(message == '<![CDATA[You have successfully logged in]]>'):
        print(''+username[num]+'= CONNECTED')
        break
    else:
        print(''+username[num]+'= FAILED CONNECTION'+' Reason ='+message)
        num=num+1

'''while(num<=20171800):
    message = user_validity(num)
    if(message == '<![CDATA[You have successfully logged in]]>'):
        print('f'+str(num))
    num=num+1'''

EOF

chmod 755 cyberautologin.py

./cyberautologin.py
