*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/account_creation.robot
Resource    ../../resources/pages/transfer_funds.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-E2E-03 Transfer Funds Balance API Check
    [Documentation]    Transfer funds through UI and check balance via API
    [Tags]    e2e
    
    Ensure User Is Logged In
    Create Savings Account
    
    Create API Session
    
    ${src_before}    Get Account Balance    ${SOURCE_ACCOUNT_NUMBER}
    ${dest_before}    Get Account Balance    ${SAVINGS_ACCOUNT_NUMBER}

    Log To Console    Source Balance Before: ${src_before}
    Log To Console    Destination Balance Before: ${dest_before}

    Transfer Funds    
    ...    150
    ...    ${SOURCE_ACCOUNT_NUMBER}
    ...    ${SAVINGS_ACCOUNT_NUMBER}

    Transfer Success Confirmation

    ${src_after}    Get Account Balance    ${SOURCE_ACCOUNT_NUMBER}
    ${dest_after}    Get Account Balance    ${SAVINGS_ACCOUNT_NUMBER}

    Log To Console    Source Balance Before: ${src_after}
    Log To Console    Destination Balance Before: ${dest_after}
    
    ${src_diff}=    Evaluate    ${src_before} - ${src_after}
    ${dest_diff}=    Evaluate    ${dest_after} - ${dest_before}
    
    Should Be Equal As Numbers    ${src_diff}    150
    Should Be Equal As Numbers    ${dest_diff}    150
    Should Be Equal    ${src_diff}    ${dest_diff}


    