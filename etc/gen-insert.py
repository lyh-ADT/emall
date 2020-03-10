import json
import uuid

l = []
with open("items.json", 'rb') as f:
    l = json.load(f)

with open("inserts.sql", 'at+', encoding='utf8') as f:
    for i in l:
        i["goodId"] = str(uuid.uuid4())
        t = "insert into goods(goodId, userId, price, number, goodName, description, imgs) values('{goodId}', 'li', '{price}', '{number}', '{goodName}', '{description}', '{imgId}.jpg');".format_map(i)
        f.write(t+"\n")