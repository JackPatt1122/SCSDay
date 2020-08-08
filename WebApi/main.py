import requests
from bs4 import BeautifulSoup


vgm_url = 'http://example.webscraping.com/'
html_text = requests.get(vgm_url).text
soup = BeautifulSoup(html_text, 'html.parser')
print(soup.find('p'))