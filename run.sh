# Ensure env vars are set
# export REPORT_BUCKET_NAME=idp-test-report-store
# export GOOGLE_APPLICATION_CREDENTIALS=~/credentials.json

# Get the latest reports from google drive
pipenv run python3 ./get_data.py

# Relaunch the container
docker run --user="$(id -u):$(id -g)" -d -p 5050:5050 -e KEEP_HISTORY=1 \
                 -v ${PWD}/out/allure-results:/app/allure-results \
                 -v ${PWD}/out/allure-report:/app/default-reports \
                 frankescobar/allure-docker-service
