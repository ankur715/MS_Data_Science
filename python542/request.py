# Send requests with the features to the server and receive the results

import requests

url = 'http://localhost:5000/predict_api'
r = requests.post(url,json={'experience':2, 'test_score':9, 'interview_score':6})
'''
requests.post() takes URL and the data to be passed in the POST request
returned results from the servers are stored into the variable r 
printed by r.json()
'''
print(r.json())