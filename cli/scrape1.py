import os
import mechanize
from bs4 import BeautifulSoup
import urllib2 
import cookielib
import re

cj = cookielib.CookieJar()
br = mechanize.Browser()
br.set_handle_robots(False)
br.set_cookiejar(cj)
br.open("https://github.com/login/")
br.select_form(nr=0)
br.form['login'] = 'sahilchilana'
br.form['password'] = os.environ['GITHUB_PASSWORD']
br.submit()
result=br.open('https://github.com/innovaccer/GitHubactions-for-AWS-Lambda/pulls').read()
soup=BeautifulSoup(result,"lxml")
element = soup.find('div', attrs={'aria-label':'Issues'}).find('div', 
						   attrs={'class':'js-navigation-container js-active-navigation-container'}).find_all('a')
result='https://github.com'+element[0]['href']+'/files'
result=br.open(result).read()
soup=BeautifulSoup(result, "lxml")
element=soup.select("div.file-info.flex-auto > a.link-gray-dark")
titles = [ele["title"] for ele in element]
item='lambda_function/functions/subtract_function/subtract.py'
if item in titles:
	print item
