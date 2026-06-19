*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot

Suite Setup    Run Keywords
...    Load Environment
...    AND
...    Create API Session
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-API-02 Retrieve Accounts List
    [Documentation]    Test case to retrieve the list of accounts using API
    [Tags]    api

    Ensure User Is Logged In
    ${customer_id}=    Get Customer Login    ${USERNAME}    ${PASSWORD}

    ${response}=    Get Accounts List    ${customer_id}
    Should Be Equal As Strings    ${response.status_code}    200

    ${body}=    Set Variable    ${response.json()}
    Log To Console    ${body}