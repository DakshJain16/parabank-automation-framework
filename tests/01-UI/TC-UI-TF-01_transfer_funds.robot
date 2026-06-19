*** Settings ***
Resource    ../../resources/pages/transfer_funds.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/account_creation.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-UI-TF-01 Transfer Funds Between Two Accounts
    [Documentation]    Test the fund transfer process between accounts on the banking application
    [Tags]    functional

    Ensure User Is Logged In
    Create Savings Account

    Transfer Funds
    ...    150
    ...    ${SOURCE_ACCOUNT_NUMBER}
    ...    ${SAVINGS_ACCOUNT_NUMBER}

    Wait Until Page Contains    Transfer Complete!    10s

