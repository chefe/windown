import sys, time
from selenium import webdriver

selectEdition = """
options = Array.from(document.querySelectorAll('#product-edition option'));
optionToSelect = Math.max.apply(null, options.map(o => o.value));
options.filter(o => o.value == optionToSelect)[0].selected=true;
"""

selectLanguage = """
options = Array.from(document.querySelectorAll('#product-languages option'));
options.filter(o => o.value.includes('"English"'))[0].selected=true;
"""

options = webdriver.firefox.options.Options()
options.headless = True
profile = webdriver.FirefoxProfile()
browser = webdriver.Firefox(profile, options=options)

link = ''

try:
    browser.get('https://www.microsoft.com/en-us/software-download/windows10ISO')
    time.sleep(5)
    browser.execute_script(selectEdition)
    browser.find_element_by_id('submit-product-edition').click()
    time.sleep(5)
    browser.execute_script(selectLanguage)
    browser.find_element_by_id('submit-sku').click()
    time.sleep(5)
    link = browser.find_element_by_partial_link_text('64-bit').get_attribute('href')
    time.sleep(5)

finally:
    browser.quit()
    print(link)
    sys.exit(1 if len(link) == 0 else 0)
