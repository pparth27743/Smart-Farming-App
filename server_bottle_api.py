from bottle import route, run, response, request
import joblib
import numpy as np
import cv2   
from keras.preprocessing.image import img_to_array
# from keras import backend as K
from json import dumps

file_object = open('cnn_model.pkl', 'rb')
model = joblib.load(file_object)

label_object = open('label_transform.pkl', 'rb')
label = joblib.load(label_object)


@route('/', method='POST')
def predict():
    
    try:
        data = request.body.read()

        # convert string of image data to uint8
        nparr = np.fromstring(data, np.uint8)
        
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
        
        # K.clear_session()
        
        result = {'prediction': '{}'.format(pred_result)}
        response.content_type = 'application/json'
        return dumps(result)

    except Exception as e:
        result = {'error': '{}'.format(e)}
        response.content_type = 'application/json'
        return dumps(result)




run(debug=False, host='0.0.0.0', port = 5000)
