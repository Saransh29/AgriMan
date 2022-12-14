from fastapi import FastAPI
app = FastAPI()

@app.get("/my-first-api")
def fun(state,city,market,date):
    from bs4 import BeautifulSoup
    import requests
    import html_to_json
    import re
    u = 'https://www.napanta.com/market-price/'+state+'/'+city+'/'+market+'/'+date
    r = requests.get(u)

    soup = BeautifulSoup(r.text, 'lxml')
    resultset = soup.find_all('tr')
    output_json = html_to_json.convert(str(resultset[0]))

    with open('crop_data.json', 'w', encoding='utf-8') as f1:
        x = re.findall(r'>(.*?)<',str(resultset))
        x = list(filter(lambda a: a not in {"","'"," '"} , x))
        res = []
        temp = []
        for i in x:
            if i==", ":
                res.append(temp)
                temp = []
            else:
                temp.append(i)
        res[0].pop()
        st = "["
        for i in res[1:]:
            st += "{"
            for j in range(len(res[0])):
                st += '"' +res[0][j]+ '"'+ ":" + '"'+i[j]+'"' + ", "
            st = st[:-2]
            st += "},"
        st = st[:-1]
        st += "]"
        f1.write(str(st))
        f1.close()
        return st