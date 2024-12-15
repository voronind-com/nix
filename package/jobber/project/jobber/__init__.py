#!/usr/bin/env python3 -u

from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import subprocess
import datetime
import time
import random
import os
import sys

# sys.stdout = os.fdopen(sys.stdout.fileno(), 'w', 0)

print('starting jobber..')

# config.
DELAY_CYCLE   = 300  # Check time every in seconds.
DELAY_SUCCESS = 3600 # Delay after successful in/out in seconds.
DELAY_CAP     = 120  # Delay between users in seconds.
DELAY_VPN     = 30   # Delay waiting for VPN connection in seconds.
DELAY_ERROR   = 30   # Delay in case of errors in seconds.
DELAY_CLICK   = 30   # Delay after button click.
SHIFT_START   = 10    # Work starts at hour.
SHIFT_END     = 19   # Work ends at hour.
TRIES_MAX     = 5    # Maximum tries to press button before give up.
URL_SCHEME    = "https://"
URL           = "portal.fsight.ru/"
# DRIVER        = "/data/geckodriver"
DRIVER        = "geckodriver"
USERS         = "/data/users.txt"
OVPN          = "/data/fsight.ovpn"
BUTTON        = "//*[contains(@id, '_InOutButton')]"
TEXT_HERE     = "Пришёл"
TEXT_GONE     = "Ушёл"

VPN = None


def toggle_vpn(state):
	print("toggle_vpn(state = {})".format(state))
	try:
		if state:
			print('waiting for VPN for {}s'.format(DELAY_VPN))
			global VPN
			VPN = subprocess.Popen(['openvpn', OVPN])
			time.sleep(DELAY_VPN)
		else:
			VPN.kill()
	except: pass


def toggle_button(cred, at_work):
	tag = 'toggle(cred = {}, at_work = {})'.format(cred.strip('\n'), at_work)
	print(tag)

	# start Firefox
	options = Options()
	options.set_preference("browser.tabs.remote.force-enable", True)
	options.set_preference("network.negotiate-auth.trusted-uris", URL_SCHEME + URL)
	options.set_preference("network.negotiate-auth.delegation-uris", URL_SCHEME + URL)
	options.set_preference("network.automatic-ntlm-auth.trusted-uris", URL_SCHEME + URL)
	options.headless = True
	firefox_capabilities = DesiredCapabilities.FIREFOX
	firefox_capabilities['marionette'] = True
	driver = webdriver.Firefox(options=options, executable_path=DRIVER, service_log_path=None, capabilities=firefox_capabilities)

	# load page and click button
	tries  = 0
	button = None
	while button is None and tries <= TRIES_MAX:
		toggle_vpn(True)

		# try:
		driver.get(URL_SCHEME + cred + "@" + URL)
		# button = driver.find_element_by_xpath(BUTTON)
		button = driver.find_element(by=By.XPATH, value=BUTTON)
		# except: print()

		if button is None:
			print('{} : button not found, trying again after {}s'.format(tag, DELAY_VPN))
			toggle_vpn(False)
			tries += 1
			time.sleep(DELAY_ERROR)

	if (tries <= TRIES_MAX):
		# time.sleep(DELAY_CLICK)
		text = button.get_attribute('value')
		if (text == TEXT_HERE and at_work) or (text == TEXT_GONE and not at_work):
			print('{} : clicking button'.format(tag))
			# button.submit()
			# driver.execute_script('arguments[0].click();', button)
			button.click()
			time.sleep(DELAY_CLICK)

	# stop firefox
	driver.quit()

	# kill vpn
	toggle_vpn(False)

def main():
	# load users
	users = open(USERS, 'r').readlines()
	for user in users:
		if user.startswith('#'):
			users.remove(user)
	print('loaded {} users'.format(len(users)))

	# loop forever
	while True:
		print('time is {}h'.format(datetime.datetime.now().hour))

		# check for day start
		if datetime.datetime.now().hour == SHIFT_START and datetime.datetime.now().isoweekday() < 6:
			print('starting work day..')
			for user in users:
				toggle_button(user, True)
				time.sleep(random.random() * DELAY_CAP)

			time.sleep(DELAY_SUCCESS)
			continue

		# check for day end
		if datetime.datetime.now().hour == SHIFT_END and datetime.datetime.now().isoweekday() < 6:
			print('ending work day..')
			for user in users:
				toggle_button(user, False)
				time.sleep(random.random() * DELAY_CAP)

			time.sleep(DELAY_SUCCESS)
			continue

		# loop delay
		print('not the right time, waiting {}s'.format(DELAY_CYCLE))
		time.sleep(DELAY_CYCLE)

