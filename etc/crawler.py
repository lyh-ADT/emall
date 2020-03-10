import bs4
import random
import uuid
import json
import requests

f = open("苏宁超市.html", encoding="utf8")
soup = bs4.BeautifulSoup(f)

items = soup.findAll(class_="comm-item")
# print(items)
l = []
for i in items:
    a = i.a
    img = i.img

    price = random.randint(1, 1000) / 10
    number = random.randint(1, 1000)
    description = img['alt']
    imgId = str(uuid.uuid4())
    goodName = a['title']
    imgLink = img['lazy-src']
    print(imgLink)
    r = requests.get("https:"+imgLink, headers={
        'Referer': 'https://chaoshi.suning.com/?utm_source=360&utm_medium=cpc_chaoshi&utm_campaign=%E7%AB%9E%E5%93%81%E8%AF%8D-A&utm_content=%E8%B6%85%E5%B8%82+%E4%B8%BB%E8%AF%8D&utm_term=u1385913107.c3015806268.g937583746.k29171509201.a8448775703.pz',
        'Sec-Fetch-Dest': 'image',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36'
    })
    with open("./imgs/"+imgId+".jpg", 'wb') as f:
        f.write(r.content)

    item = {
        'goodName':goodName,
        'number':number,
        'price':price,
        'description':description,
        'imgId':imgId
    }
    l.append(item)

with open("items.json", 'wt', encoding='utf8') as f:
    f.write(json.dumps(l))