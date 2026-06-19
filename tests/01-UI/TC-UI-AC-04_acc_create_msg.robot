*** Settings ***
Resource    ../../resources/pages/verify_account_creation.robot
Resource    ../../resources/pages/account_creation.robot
Resource    ../../resources/keywords/common_keywords.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-UI-AC-04 Verify Account Creation Success Message
    [Documentation]    Verify that the account creation success message is displayed
    [Tags]    functional

    Ensure User Is Logged In
    Create Checking Account
    Verify Account Creation Success Message