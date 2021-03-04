python3 get_data.py
docker run -p 5050:5050 -e KEEP_HISTORY=1 \
                 -v ${PWD}/allure-results:/app/allure-results \
                 -v ${PWD}/allure-report:/app/default-reports \
                 frankescobar/allure-docker-service