*** Settings ***
Resource    ../../resources/pages/account_creation.robot
Resource    ../../resources/keywords/common_keywords.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-UI-AC-02 Create Checking Account
    [Documentation]    Test the checking account creation process on the banking application
    [Tags]    functional

    Ensure User Is Logged In
    Create Checking Account