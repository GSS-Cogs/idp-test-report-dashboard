import os 
import shutil

from pathlib import Path
from google.cloud import storage
from zipfile import ZipFile

BUCKET_NAME = os.environ["REPORT_BUCKET_NAME"]

# Remove left overs from last run
if os.path.isdir("allure-results"):
    shutil.rmtree("allure-results")

if os.path.isdir("allure-report"):  
    shutil.rmtree("allure-report")

def get_client():
    """
    Get a storage client
    """
    try:
        storage_client = storage.Client()
    except Exception as err:
        raise Exception("Unable to get storage client. Aborting operation:") from err
        
    return storage_client

storage_client = get_client()
blobs = storage_client.list_blobs(BUCKET_NAME)

p1 = Path("./allure-results")
p1.mkdir(0o777, exist_ok=True)

p2 = Path("./allure-report")
p2.mkdir(0o777, exist_ok=True)

blobs = list(storage_client.list_blobs(BUCKET_NAME))
latest_created_time = max([x.time_created for x in blobs])
latest_data_blob = [x for x in blobs if x.time_created == latest_created_time][0]
latest_data_blob.download_to_filename(latest_data_blob.name)

with ZipFile(latest_data_blob.name, 'r') as zipObj:
   zipObj.extractall()
