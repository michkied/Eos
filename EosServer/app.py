import board
import neopixel

from flask import Flask
from flask import request

import json

N = 45
app = Flask(__name__)
pixels = neopixel.NeoPixel(board.D18, N)

@app.route('/', methods=['POST'])
def fill():
    print(request.data)
    data = json.loads(request.data)
    if data['start'] == 0 and data['end'] == N - 1:
        pixels.fill((data['red'], data['blue'], data['green']))
    else:
        for i in range(44 - data['end'], (44 - data['start']) + 1):
            pixels[i] = (data['red'], data['blue'], data['green'])
        pixels.show()
    return 'ok'

@app.route('/data', methods=['POST'])
def from_data_string():
    print(request.data)
    data = json.loads(request.data)
    for i in range(N):
        pixels[i] = (data[i][0], data[i][1], data[i][2])
    return 'ok'

@app.route('/pull', methods=['GET'])
def get_pixels():
    data = '['
    for i in range(N):
        data += str(pixels[i]) + ','
    return data[:-1] + ']'

@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, port=5000)
