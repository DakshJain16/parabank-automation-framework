*** Settings ***
Resource    ../../resources/pages/transfer_funds.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/account_creation.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-UI-TF-02 Verify Transfer Confirmation Message
    [Documentation]    Verify that the transfer success message is displayed after transferring funds
    [Tags]    functional

    Ensure User Is Logged In
    Create Checking Account

    Transfer Funds
    ...    50
    ...    ${SOURCE_ACCOUNT_NUMBER}
    ...    ${CHECKING_ACCOUNT_NUMBER}

    Transfer Success Confirmation
