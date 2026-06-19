*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/account_creation.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-API-04 Validate Account Balance Field
    [Documentation]    verify balance is numeric
    [Tags]    api

    Ensure User Is Logged In
    Create Savings Account
    Create API Session
    
    ${balance}=    Get Account Balance    ${SAVINGS_ACCOUNT_NUMBER}

    Log To Console    Balance: ${balance}
    Should Be True    ${balance} >= 0
    Should Be True    isinstance(${balance}, (int, float))

    
