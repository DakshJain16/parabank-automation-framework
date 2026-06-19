*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/account_creation.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-API-03 Validate Account Type
    [Documentation]    Verify account type matches in UI and API
    [Tags]    api

    Ensure User Is Logged In
    Create Checking Account
    Create API Session
    
    ${response}=    Get Account Details    ${CHECKING_ACCOUNT_NUMBER}
    Should Be Equal As Integers    ${response.status_code}    200
    
    ${body}=    Set Variable    ${response.json()}
    Log To Console    ${body}
    Should Be Equal As Strings    ${body['type']}    CHECKING
