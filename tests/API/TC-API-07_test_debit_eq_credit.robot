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
TC-API-07 Verify Transfer Debit Equals Credit
    [Documentation]    Check debited amount equals credited amount
    [Tags]    api

    Ensure User Is Logged In
    Create Savings Account

    Create API Session
    
    ${src_before}=  Get Account Balance    ${SOURCE_ACCOUNT_NUMBER}
    ${dest_before}=  Get Account Balance    ${SAVINGS_ACCOUNT_NUMBER}

    Log To Console    Source Balance Before: ${src_before}
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

    ${src_after}=  Get Account Balance    ${SOURCE_ACCOUNT_NUMBER}
    ${dest_after}=  Get Account Balance    ${SAVINGS_ACCOUNT_NUMBER}
    
    Log To Console    Source Balance After: ${src_after}
    Log To Console    Destination Balance After: ${dest_after}

    ${src_debit}=    Evaluate    ${src_before} - ${src_after}
    ${dest_credit}=    Evaluate    ${dest_after} - ${dest_before}
    
    Log To Console    Source Debit: ${src_debit}
    Log To Console    Destination Credit: ${dest_credit}
    
    Should Be Equal As Numbers    ${src_debit}    ${dest_credit}

    