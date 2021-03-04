import os 
import shutil

from pathlib import Path
from google.cloud import storage

# Remove left overs from last run
if os.path.isdir("allure-results"):
    shutil.rmtree("allure-results")

if os.path.isdir("allure-report"):  
    shutil.rmtree("allure-report")

BUCKET_NAME = os.environ["REPORT_BUCKET_NAME"]

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

for blob in storage_client.list_blobs(BUCKET_NAME):
    if not blob.name.endswith("/"): # don't download empty directories
        if "/" in blob.name:
            needs_path = "/".join(str(blob.name).split("/")[:-1])
            this_path = Path(needs_path)
            this_path.mkdir(0o755, exist_ok=True, parents=True)
        blob.download_to_filename(blob.name)