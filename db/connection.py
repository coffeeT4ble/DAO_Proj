import json
import mysql.connector
from pathlib import Path

def get_connection(): 
    config_path = Path(__file__).resolve().parent.parent / "config" / "db_conf.json"
    with open(config_path, "r") as f:
        db_conf = json.load(f)

    return mysql.connector.connect(**db_conf)
