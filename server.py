from flask import Flask, request, Response, jsonify
import jsonpickle
import pickle, joblib
import numpy as np
import cv2   
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from keras.preprocessing.image import img_to_array
from sklearn import preprocessing
from keras import backend as K


# app
app = Flask(__name__)

# routes
@app.route('/', methods=['POST'])

def predict():
    try:
        file_object = open('cnn_model.pkl', 'rb')
        model = joblib.load(file_object)

        label_object = open('label_transform.pkl', 'rb')
        label = joblib.load(label_object)

        r = request

        # convert string of image data to uint8
        nparr = np.fromstring(r.data, np.uint8)
        
        # decode image
        img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)    
    
        default_image_size = tuple((256, 256))
        imar = cv2.resize(img, default_image_size)   
        imar = img_to_array(imar)
        npimagelist = np.array([imar], dtype=np.float16) / 255.0 


        predictResult = model.predict(npimagelist)
        result = np.argmax(predictResult, axis=1)
        pred_result = label.classes_[result[0]]

        print(pred_result)
        
        # for clearing up session so that flask api not get crashed when we call it multiple times
        K.clear_session()
        
        # build a response dict to send back to client
        response = {'prediction': '{}'.format(pred_result)}
        # encode response using jsonpickle
        response_pickled = jsonpickle.encode(response)
        return Response(response=response_pickled, status=200, mimetype="application/json")

    except Exception as e:
        response = {'error': '{}'.format(e)}
        response_pickled = jsonpickle.encode(response)
        return Response(response=response_pickled, status=400, mimetype="application/json")
    

        

if __name__ == '__main__':
    # app.run(port = 5000, debug=True)
    app.run(debug=False, host='0.0.0.0', port = 5000)


