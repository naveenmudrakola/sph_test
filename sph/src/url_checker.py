import csv
import time
import requests
from datetime import datetime
import sys


sys.path.append('config')
sys.path.append('setup_logger')

import setup_logger

logger = setup_logger.setup_logger()


from config import URLS_FILE, CHECK_INTERVAL


def load_urls_from_file(file_path):
    try:
        with open(file_path, "r") as file:
            reader = csv.DictReader(file)
            return list(reader)
    except Exception as e:
        logger.error(f"Error reading the URLs from file: {e}")
        return []


def check_urls(urls, statuses):
    while True:
        for url_data in urls:
            try:
                response = requests.get(url_data["url"])
                status_code = response.status_code
            except Exception as e:
                print(f"Error checking the URL {url_data['url']}: {e}")
                status_code = None

            statuses.append({
                "name": url_data["name"],
                "url": url_data["url"],
                "status_code": status_code,
                "timestamp": datetime.now()
            })
        time.sleep(CHECK_INTERVAL)
