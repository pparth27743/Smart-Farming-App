from flask import Flask, request, Response, jsonify
import jsonpickle
import xlrd 
import pandas as pd

loc = ("DataSet.xlsx") 
dataSet = pd.read_excel(loc, 0)

# app
app = Flask(__name__)

# routes
@app.route('/', methods=['POST'])
def predict():

    try:
        data = request.json
        temp = int(data["temperature"])
        humi = int(data["humidity"])

        print(temp)
        print(humi)

        lst = []
        for ind in dataSet.index:    
            if temp >= dataSet['temperatureLower'][ind] and temp <= dataSet['temperatureHigher'][ind]:
                    if humi >= dataSet['humidityLow'][ind] and humi <= dataSet['humidityHigh'][ind]:
                        lst.append(dataSet['Crop'][ind])

            
        print(lst)    # build a response dict to send back to client
        
        response = {'prediction': '{}'.format(lst)}
        # encode response using jsonpickle
        response_pickled = jsonpickle.encode(response)
        return Response(response=response_pickled, status=200, mimetype="application/json")
    
    except Exception as e:
        response = {'error': '{}'.format(e)}
        response_pickled = jsonpickle.encode(response)
        return Response(response=response_pickled, status=200, mimetype="application/json")


@app.route('/', methods=['GET'])
def getReq():

    response = {'prediction': 'msg from get'}
    response_pickled = jsonpickle.encode(response)
    return Response(response=response_pickled, status=200, mimetype="application/json")



if __name__ == '__main__':
    # app.run(port = 5000, debug=True)
    app.run(debug=True, host='0.0.0.0', port = 6000)


