# Fast API Url :- https://food-recommendation-ml.herokuapp.com/docs


## Food-Recmmendation-System-Python


This is the Recommendation Engine that will be used in building the <b>Recipe App</b>,Ttake Recipe name and Suggesting the relative Recipe.


## Content Based Filtering

We will analyse the past recipes of the user and suggest back those items which are similar.

We will be use <b>TfidfVectorizer</b>  <b>linear_kernel</b> from <b>Scikit-Learn</b> to find similarity between items based on their name, recipe_step and tags. To bring all these properties of each item together, we create a <b>"rec"</b> of tags. rec is a processed string correspnding to each item, formed using the constituents of tags & name.


## Sample Recommendation

```python
recommendation_n(reciepe_name)
```

## Deploy

Build Recmmendation-System API in FastAPI ,which gives <b>All Recipes Name</b> and <b>Top 5 Similar Recipes Name</b>

http://127.0.0.1:8000/docs/
