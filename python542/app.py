# Use the Flask web framework to handle the POST requests and get results

import numpy as np #create the array of requested data
from flask import Flask, request, jsonify, render_template
import pickle #load our trained model to predict
import sklearn

app = Flask(__name__) #create instance of Flask
model = pickle.load(open('model.pkl', 'rb')) #load model

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict',methods=['POST'])
def predict():
    '''
    For giving results on HTML GUI
    '''
    int_features = [int(x) for x in request.form.values()]
    final_features = [np.array(int_features)]
    prediction = model.predict(final_features)

    output = round(prediction[0], 2)

    return render_template('index.html', prediction_text='Employee Salary should be $ {}'.format(output))

@app.route('/predict_api',methods=['POST'])
def predict_api():
    '''
    For direct API calls through request
    predict_api method gets the data from the json passed by the requestor
    '''
    data = request.get_json(force=True)
    prediction = model.predict([np.array(list(data.values()))])
    '''
    takes input from the json and converts it into 2D numpy array 
    results are stored into the variable named output
    return this variable after converting to json object using flasks jsonify() method
    '''
    output = prediction[0]
    return jsonify(output)

if __name__ == "__main__":
    app.run(debug=True) #can debug error and solve