from __future__ import print_function
import requests
import json
import cv2
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
# from keras.preprocessing.image import img_to_array


url = 'http://127.0.0.1:5000'

# prepare headers for http requestz
content_type = 'image/jpeg'
headers = {'content-type': content_type}

img1 = cv2.imread('paper_bell_healthy.JPG')


_, img_encoded = cv2.imencode('.jpg', img1)



# send http request with image and receive response
response = requests.post(url, data=img_encoded.tostring(), headers=headers)
# decode response
print(json.loads(response.text))

