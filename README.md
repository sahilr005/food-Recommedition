## Website : https://food-recommendation-ml.web.app/#/
![image](https://user-images.githubusercontent.com/76276129/193652706-633d2845-63fc-4898-841c-0d952c51856c.png)
![1](https://user-images.githubusercontent.com/76276129/193652468-0c15a992-8733-4511-8ddc-7bf28409db58.PNG)
![image](https://user-images.githubusercontent.com/76276129/193652388-6ea0051d-8eff-432d-9dc2-56a612bdd7af.png)

## Fast API Url :- https://food-recommendation-ml.herokuapp.com/docs

## Food-Recmmendation-System-Python


This is the Recommendation Engine that will be used in building the <b>Recipe App</b>,Ttake Recipe name and Suggesting the relative Recipe.


## Content Based Filtering

We will analyse the past recipes of the user and suggest back those items which are similar.

We will be use <b>TfidfVectorizer</b> & <b>linear_kernel</b> from <b>Scikit-Learn</b> to find similarity between items based on their name, recipe_step and tags. To bring all these properties of each item together, we create a <b>"rec"</b> of tags. rec is a processed string correspnding to each item, formed using the constituents of tags & name.


## Sample Recommendation

```python
recommendation_n(reciepe_name)
```

## Deploy

Build Recmmendation-System API in FastAPI ,which gives <b>All Recipes Name</b> and <b>Top 5 Similar Recipes Name</b>
