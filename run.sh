<<<<<<< HEAD
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
=======
# Note you'll need to pipenv install first
pipenv run python3 get_data.py

docker run -d -p 5050:5050 -e KEEP_HISTORY=1 \
                 -v ${PWD}/allure-results:/app/allure-results \
                 -v ${PWD}/allure-report:/app/default-reports \
                 frankescobar/allure-docker-service
>>>>>>> 862b46299675d6d473c1a7e228959b318ce9f298
