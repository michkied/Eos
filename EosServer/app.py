import board
import neopixel

from flask import Flask
from flask import request

import json

app = Flask(__name__)
pixels = neopixel.NeoPixel(board.D18, 45)

@app.route('/', methods=['POST'])
def fill():  # put application's code here
    print(request.data)
    data = json.loads(request.data)
    pixels.fill((data['red'], data['blue'], data['green']))
    return 'ok'

@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, port=5000)
