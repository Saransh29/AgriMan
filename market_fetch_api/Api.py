import requests
# from PIL import Image
# import io
import sys

resp = requests.get('http://127.0.0.1:8000/my-first-api?state=haryana&city=sonipat&market=sonepat&date=02-dec-2022')
print(resp)
# sys.wait(1000)