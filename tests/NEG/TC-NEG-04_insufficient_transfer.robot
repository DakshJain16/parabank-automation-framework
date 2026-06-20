*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/account_creation.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-NEG-04 Transfer API Insufficient Balance
    [Documentation]    Verify transfer API rejects transfers exceeding available balance.
    [Tags]    negative    api    defect

    Ensure User Is Logged In
    Create Savings Account

    Create API Session
    
    ${balance}=  Get Account Balance    ${SOURCE_ACCOUNT_NUMBER}
    ${invalid_amt}=  Evaluate    ${balance} + 1000
    
    ${response}=  Transfer Funds API    
    ...    ${invalid_amt}
    ...    ${SOURCE_ACCOUNT_NUMBER}
    ...    ${SAVINGS_ACCOUNT_NUMBER}

    Log To Console    Status: ${response.status_code}
    Log To Console    Response: ${response.text}

    Should Not Be Equal As Integers   ${response.status_code}    200

#    Should Not Contain
#    ...    ${response.text}
#    ...    Successfully transferred