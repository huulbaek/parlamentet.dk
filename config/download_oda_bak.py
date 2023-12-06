import requests

url = "https://oda.ft.dk/odapublish/oda.bak"
username = "ODAwebpublish"
password = "b56ff26a-c19b-4322-a3c4-614de155781d"

response = requests.get(url, auth=(username, password))

with open("oda.bak", "wb") as f:
    f.write(response.content)
