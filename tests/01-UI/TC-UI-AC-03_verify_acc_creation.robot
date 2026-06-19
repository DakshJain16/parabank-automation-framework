*** Settings ***
Resource    ../../resources/pages/verify_account_creation.robot
Resource    ../../resources/pages/account_creation.robot
Resource    ../../resources/keywords/common_keywords.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-UI-AC-03 Verify Account Creation
    [Documentation]    Verify that the account is created
    [Tags]    functional

    Ensure User Is Logged In
    Create Savings Account
    Verify Account Creation    ${SAVINGS_ACCOUNT_NUMBER}
