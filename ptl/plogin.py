#!/opt/local/bin/python3

from selenium import webdriver
import config

chromeDriver = "/Users/iwamoto/utils/ptl/chromedriver"
browser = webdriver.Chrome(chromeDriver)
browser.get('https://portal.nap.gsic.titech.ac.jp/GetAccess/Login?Template=userpass_key&AUTHMETHOD=UserPassword')
browser.implicitly_wait(10)
browser.find_element_by_name('usr_name').send_keys(config.account)
browser.find_element_by_name('usr_password').send_keys(config.password)
browser.find_element_by_name('OK').click()
browser.implicitly_wait(10)
message4 = browser.find_element_by_xpath('/html/body/center[3]/form/table/tbody/tr/td/table/tbody/tr[4]/th[1]').text
message5 = browser.find_element_by_xpath('/html/body/center[3]/form/table/tbody/tr/td/table/tbody/tr[5]/th[1]').text
message6 = browser.find_element_by_xpath('/html/body/center[3]/form/table/tbody/tr/td/table/tbody/tr[6]/th[1]').text
browser.find_element_by_name('message3').send_keys(config.matrix[message4])
browser.find_element_by_name('message4').send_keys(config.matrix[message5])
browser.find_element_by_name('message5').send_keys(config.matrix[message6])
browser.find_element_by_name('OK').click()


