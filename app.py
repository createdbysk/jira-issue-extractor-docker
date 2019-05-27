import jira
import logging
import os 

log_level = os.getenv("LOG_LEVEL", "INFO")
logging.basicConfig(level=log_level)

def load_environment():
    import dotenv
    dotenv.load_dotenv(dotenv.find_dotenv())

def create_jira():
    import os
    from jira import JIRA
    jira_url = os.getenv("JIRA_URL")
    username = os.getenv("USERNAME")
    password = os.getenv("PASSWORD")
    jira = JIRA(jira_url, basic_auth=(username, password))
    return jira

def main():
    from jira_issue_extractor.factories import output_issue_details_for_jql_list_to_file_strategies
    from jira_issue_extractor.algorithm import output_issue_details_for_jql_list
    from jira_issue_extractor.strategies.output_issue_details_to_file_inputs_from_environment_strategy import OutputIssueDetailsToFileInputsFromEnvironmentStrategy
    load_environment()
    jira = create_jira()
    output_issue_details_to_file_inputs_strategy = \
        OutputIssueDetailsToFileInputsFromEnvironmentStrategy()
    strategies = output_issue_details_for_jql_list_to_file_strategies.create(
        jira, 
        output_issue_details_to_file_inputs_strategy
    )
    output_issue_details_for_jql_list(
        strategies
    )

if __name__ == "__main__":
    main()
