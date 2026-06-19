*** Settings ***
Resource    ../../resources/pages/account_creation.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-API-01 Verify Account Exists In API
    [Documentation]    Test case to verify that the newly created account exists using API
    [Tags]    api

    Ensure User Is Logged In
    Create Savings Account
    Create API Session
    ${response}=    Verify Account Exists    ${SAVINGS_ACCOUNT_NUMBER}
    Should Be Equal As Strings    ${response.status_code}    200

    ${body}=    Set Variable    ${response.json()}
    Log To Console    ${body}
    Should Be Equal As Integers    ${body['id']}    ${SAVINGS_ACCOUNT_NUMBER}