#!/usr/bin/env python
# coding: utf-8

# # DS 542: Python in Data Science
# ## _Ankur Patel_
# ### apatel8@saintpeters.edu

# In[1]:


# Markdown could've been used for this but since this is Python class:

from IPython.display import Image
from IPython.core.display import HTML 
Image(url= "https://s3.amazonaws.com/files.dezyre.com/images/blog/Top+5+Libraries+for+Data+Science+in+Python/Top+5+Libraries+for+Data+Science+in+Python.jpg", width=100, height=100000)


# In[2]:


# Importing the libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


# In[3]:


# Creating a dataset
# dataset = {key: list of values}
hiring = {"experience":["","","five","two","seven"],
          "test_score":["8","8","","10","9"],
          "interview_score":["9","6","7","10","6"],
          "salary":[50000,40000,60000,80000,75000]}


# In[4]:


# Convert into DataFrame 
# Save as CSV
hiring = pd.DataFrame(hiring)
hiring.to_csv("hiring.csv")


# In[5]:


# Read hiring.csv
df = pd.read_csv("hiring.csv")
df.head()


# In[6]:


# Remove first column of repeated row numbers, fill null values
df = df.drop(df.columns[0], axis=1)
df['experience'].fillna(0, inplace=True)
df['test_score'].fillna(df['test_score'].mean(), inplace=True)


# In[8]:


df.columns = ["Experience","Test Score","Interview Score","Salary"]
df


# In[9]:


# Data used to predict
X = df.iloc[:, :3]
X.head()


# In[10]:


# Convert words to integer values
def convert_to_int(word):
    word_dict = {'one':1, 'two':2, 'three':3, 'four':4, 'five':5, 'six':6, 
                 'seven':7, 'eight':8, 'nine':9, 'ten':10, 0:0}
    return word_dict[word]


# In[11]:


# Convert words to integer values
X['Experience'] = X['Experience'].apply(convert_to_int)
# X['Experience'] = X['Experience'].apply(lambda x: convert_to_int(x))
X


# In[12]:


# Target column
y = df.iloc[:, -1]
y


# In[13]:


# Splitting Training and Test Set
# Since it's a very small dataset, train the model with all availabe data.

from sklearn.linear_model import LinearRegression
regressor = LinearRegression()


# In[14]:


# Fitting model with trainig data
regressor.fit(X, y)


# In[15]:


import pickle

# Saving model to disk
pickle.dump(regressor, open('model.pkl','wb'))


# In[16]:


# Loading model to compare the results

model = pickle.load(open('model.pkl','rb'))
print(model.predict([[2, 9, 6]]))
# experience, test score, interview score


# ### Restart Kernel and run model:

# In[17]:


import pickle

model = pickle.load(open('model.pkl','rb'))
print(model.predict([[10, 10, 10]]))


# In[ ]:




