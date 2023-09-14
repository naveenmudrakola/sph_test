from datetime import datetime, timedelta
from flask import Flask, jsonify
import threading
from url_checker import load_urls_from_file, check_urls
import sys
sys.path.append('config')
sys.path.append('setup_logger')

import config
import setup_logger


logger = setup_logger.setup_logger()

app = Flask(__name__)
statuses = []


@app.route('/status', methods=['GET'])
def get_status():
    try:
        one_hour_ago = datetime.now() - timedelta(hours=1)
        recent_statuses = [status for status in statuses if status["timestamp"] >= one_hour_ago]
        return jsonify(recent_statuses)
    except Exception as e:
        logger.error(f"Error retrieving statuses: {e}")
        return jsonify({"error": "Unable to retrieve statuses"}), 500


if __name__ == "__main__":
    urls = load_urls_from_file(config.URLS_FILE)
    if not urls:
        logger.error("Error: No URLs to check.")
    else:
        threading.Thread(target=check_urls, args=(urls, statuses)).start()
        try:
            app.run(host=config.SERVER_HOST, port=config.SERVER_PORT)
        except Exception as e:
            logger.error(f"Error starting the Flask server: {e}")
