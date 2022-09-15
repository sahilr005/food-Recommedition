from sklearn.feature_extraction.text import TfidfVectorizer
from fastapi.middleware.cors import CORSMiddleware
from sklearn.metrics.pairwise import linear_kernel
import pandas as pd
from fastapi import FastAPI

data = pd.read_csv("clean_data.csv")
data.dropna(inplace=True)
data["name"] = data["name"].replace("(","").replace(")","")
cv = TfidfVectorizer()
rec_tfidf = cv.fit_transform(data["ingredients_a"])
name_tfidf = cv.fit_transform(data["name"])
rec_consin_sim = linear_kernel(rec_tfidf,rec_tfidf)
name_consin_sim = linear_kernel(name_tfidf,name_tfidf)

# cv = TfidfVectorizer()
# tfid = cv.fit_transform(data["ingredients_a"])
# consin_sim = linear_kernel(tfid,tfid)
def recommendation_n(name,sim):
    mm = []
    try:
        name.replace("(","").replace(")","")
        
        ind = data[data["name"]==name].index[0]
        rec =  list(enumerate(sim[ind]))
        rec = sorted(rec,reverse=True,key=lambda x : x[1])
        rec = rec[0:6]
        for i in rec:
            mm.append(data.iloc[i[0]][["name","image_url"]])
    except:
        mm.append("Reciepe Not Found, run recipe_name api & try those name.")
    return mm

app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def recipe_name():
    return data[["name","image_url"]].sample(20)

@app.post("/detail")
def nameDetail(name:str):
    a = data[data["name"]==name][["name","image_url","description","course","diet","prep_time","ingredients_a","instructions"]]
    return a

@app.post("/name")
def recommendition(reciepe_name:str):
    return recommendation_n(reciepe_name,name_consin_sim)

@app.post("/recipe")
def recommendition(reciepe_name:str):
    return recommendation_n(reciepe_name,rec_consin_sim)