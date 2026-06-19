*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/negative_tc_keywords.robot
Resource    ../../resources/pages/account_creation.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-NEG-02 Blank Transfer Amount
    [Documentation]    Perform transfer funds without entering an amount and check for validation
    [Tags]    negative    defect

    Ensure User Is Logged In
    Create Checking Account
    Transfer Blank Amount
    Verify Blank Transfer Error Is Shown