*** Settings ***
Resource    ../../resources/pages/account_creation.robot
Resource    ../../resources/keywords/common_keywords.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-UI-AC-01 Create Savings Account
    [Documentation]    Test the account creation process on the banking application
    [Tags]    functional

    Ensure User Is Logged In
    Create Savings Account
