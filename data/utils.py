import time
from http import HTTPStatus
from os.path import exists

import requests


def save_download_data_to_path(file_path_to_save: str, url_to_download: str):
    try:
        response = requests.get(url_to_download, stream=True)
        if response.status_code == HTTPStatus.OK and "404: Page Not Found" not in str(response.content):
            with open(file_path_to_save, "wb") as file_to_write:
                file_to_write.write(response.content)
        else:
            print(f"Skipping {url_to_download} because it was missing or not found!")
    except Exception as e:
        print("Unable to retrieve data for some reason", e)


def download_and_save_file_if_needed(url_to_download: str, file_path_to_save: str):
    if not exists(file_path_to_save):
        print(f"Downloading file as it does not exist: {url_to_download}")
        save_download_data_to_path(str(file_path_to_save), url_to_download)
        time.sleep(1)
