*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/negative_tc_keywords.robot
Resource    ../../resources/pages/account_creation.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-NEG-03 Negative Transfer Amount
    [Documentation]    Perform transfer funds with negative amount and check for validation
    [Tags]    negative    defect

    Ensure User Is Logged In
    Create Savings Account
    Transfer Negative Amount
    Verify Negative Transfer Error Is Shown

