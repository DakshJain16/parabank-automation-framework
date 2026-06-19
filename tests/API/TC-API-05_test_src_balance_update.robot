*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/account_creation.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-API-05 Verify Source Account Balance Update
    [Documentation]    Verify source account balance decreases after transferring funds
    [Tags]    api

    Ensure User Is Logged In
    Create Savings Account

    Create API Session

    ${bal_before}=    Get Account Balance    ${SOURCE_ACCOUNT_NUMBER}
    Log To Console    BEFORE: ${bal_before}

    ${response}=    Transfer Funds API
    ...    150
    ...    ${SOURCE_ACCOUNT_NUMBER}
    ...    ${SAVINGS_ACCOUNT_NUMBER}
    
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    ${response.text}

#    Transfer Success Confirmation
#    Sleep    5s

    ${bal_after}=    Get Account Balance    ${SOURCE_ACCOUNT_NUMBER}
    Log To Console    AFTER: ${bal_after}
    
    ${difference}=    Evaluate    ${bal_before} - ${bal_after}
    Should Be Equal As Numbers    ${difference}    150

    Log To Console    Source: ${SOURCE_ACCOUNT_NUMBER}
    Log To Console    Destination: ${SAVINGS_ACCOUNT_NUMBER}
    