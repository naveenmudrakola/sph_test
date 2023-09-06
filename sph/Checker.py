import csv
import time
import requests
from datetime import datetime, timedelta
from flask import Flask, jsonify

app = Flask(__name__)
statuses = []

def read_csv(file_name="urls.csv"):
    with open(file_name, "r") as file:
        reader = csv.DictReader(file)
        return list(reader)

def check_urls(urls):
    global statuses
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
        time.sleep(600) # 10 minutes

@app.route('/status', methods=['GET'])
def get_status():
    global statuses
    one_hour_ago = datetime.now() - timedelta(hours=1)
    recent_statuses = [status for status in statuses if status["timestamp"] >= one_hour_ago]
    return jsonify(recent_statuses)

if __name__ == "__main__":
    urls = read_csv()
    app.run(debug=True, port=5000, threaded=True, use_reloader=False)
