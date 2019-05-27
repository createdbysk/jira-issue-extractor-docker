# jira-issue-extractor-docker
Docker image that allows you to execute the jira-issue-extractor.

# Usage
## Windows Powershell
    docker run --rm -it -v /c/Users/your_username/path/to/env/file/.env:/opt/app/.env -v /c/Users/your_username/path/to/output/location:/opt/results satvidh/jira-issue-extractor:0.1.0

## MacOs
    docker run --rm -it -v ${HOME}/path/to/env/file/.env:/opt/app/.env -v ${HOME}/path/to/output/location:/opt/results satvidh/jira-issue-extractor:0.1.0
