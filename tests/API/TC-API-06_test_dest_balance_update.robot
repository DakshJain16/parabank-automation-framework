*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/transfer_funds.robot
Resource    ../../resources/pages/account_creation.robot
Resource    ../../resources/pages/verify_account_creation.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-API-06 Verify Destination Account Balance Update
    [Documentation]    Verify destination account balance increases after transferring funds
    [Tags]    api

    Ensure User Is Logged In
    Create Savings Account
#    Verify Account Creation    ${SAVINGS_ACCOUNT_NUMBER}

    Create API Session
    ${dest_before}=    Get Account Balance    ${SAVINGS_ACCOUNT_NUMBER}
    Log To Console    Destination Balance Before: ${dest_before}
    
#    Transfer Funds
#    ...    150
#    ...    ${SOURCE_ACCOUNT_NUMBER}
#    ...    ${SAVINGS_ACCOUNT_NUMBER}
#
#    Transfer Success Confirmation
#
#    Sleep    5s

    ${response}=    Transfer Funds API
    ...    150
    ...    ${SOURCE_ACCOUNT_NUMBER}
    ...    ${SAVINGS_ACCOUNT_NUMBER}

    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    ${response.text}
    
    ${dest_after}=    Get Account Balance    ${SAVINGS_ACCOUNT_NUMBER}
    Log To Console    Destination Balance After: ${dest_after}
    
    ${difference}=    Evaluate    ${dest_after} - ${dest_before}
    Should Be Equal As Numbers    ${difference}    150
    
    Log To Console    Source: ${SOURCE_ACCOUNT_NUMBER}
    Log To Console    Destination: ${SAVINGS_ACCOUNT_NUMBER}