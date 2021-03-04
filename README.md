
# idp-test-report-dashboard

An mvp way of spinning up a dashboard to view the test reports genreated by https://github.com/GSS-Cogs/idp-test-report-generator

## what it does?

- Pulls the reports from a google cloud bucket
- Spins up a local server dashbaord to display them

**Note** - we're running the dashboard locally but the data is coming out of the cloud, so it's the content you'd have if/when this is hosted somewhere. 

## Required Environment Variables

You'll need to set two environment variables to make this work.

| Name    | What is this?  |  Why?  |
|---------|----------------|--------|
| GOOGLE_APPLICATION_CREDENTIALS | Path to a .json with your google cloud credentials in. | So you can read/write to the bucket. |
| REPORT_BUCKET_NAME | The bucket to read/write from/to | So if developing you can choose to view a different set of reports |


## Usage

To get the data and start the server
- clone this repo
- do `pipenv install && pipenv shell`
- `./run.sh`

### To view the dashboard
Navigate to `http://localhost:5050/allure-docker-service/projects/default/reports/latest/index.html`

### Housekeeping
You'll need to kill teh docker conainer once you're done
- do `docker ps`
- get the id from the first column then `docker kill <that id>`