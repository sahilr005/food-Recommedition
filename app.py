from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel
import pandas as pd
from fastapi import FastAPI

data = pd.read_csv("clean_data.csv")
data.dropna(inplace=True)
cv = TfidfVectorizer()
tfid = cv.fit_transform(data["ingredients_a"])
consin_sim = linear_kernel(tfid,tfid)
def recommendation_n(name):
    mm = []
    try:
        ind = data[data["name"]==name].index[0]
        rec =  list(enumerate(consin_sim[ind]))
        rec = sorted(rec,reverse=True,key=lambda x : x[1])
        rec = rec[0:10]
        for i in rec:
            mm.append(data.iloc[i[0]]["name"])
    except:
        mm.append("Reciepe Not Found, run recipe_name api & try those name.")
    return mm

app = FastAPI()

@app.get("/")
def recipe_name():
    return data["name"]

@app.post("/")
def recommendition(reciepe_name:str):
    return recommendation_n(reciepe_name)