import csv
import time
import requests
from datetime import datetime, timedelta
from flask import Flask, jsonify
import threading

app = Flask(__name__)
statuses = []


        
def check_urls():
    urls = []
    with open("urls.csv", "r") as file:
        reader = csv.DictReader(file)
        urls = list(reader)
        print(urls)
    global statuses
 
    print(urls)
    print("in check_urls")
    while True:
        for url_data in urls:
            try:
                response = requests.get(url_data["url"])
                status_code = response.status_code
            except Exception as e:
                status_code = None

            statuses.append({
                "name": url_data["name"],
                "url": url_data["url"],
                "status_code": status_code,
                "timestamp": datetime.now()
            })
            print(statuses)
        time.sleep(600) # 10 minutes

@app.route('/status', methods=['GET'])
def get_status():
    print("hello")
    global statuses
    one_hour_ago = datetime.now() - timedelta(hours=1)
    recent_statuses = [status for status in statuses if status["timestamp"] >= one_hour_ago]
    return jsonify(recent_statuses)

if __name__ == "__main__":
    threading.Thread(target=check_urls).start()
    #app.run(debug=True, port=5000, threaded=True, use_reloader=False)
    app.run(host='0.0.0.0', port=5000)

    
    