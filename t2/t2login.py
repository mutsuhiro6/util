#!/opt/local/bin/python3
import requests
import config
from bs4 import BeautifulSoup


payload = {
    'username': config.account,
    'password': config.password,
    'buttonClicked': '4',
    'redirect_url': '',
    'err_flag': '0'
}

s = requests.Session()
r = s.post('https://wlanauth.noc.titech.ac.jp/login.html', data=payload)
soup = BeautifulSoup(r.text, "html.parser")
print(soup.title.string)
