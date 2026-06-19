*** Settings ***
Resource    ../../resources/pages/register.robot
Resource    ../../resources/keywords/common_keywords.robot
Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-UI-01 Register User with Valid Details
    [Documentation]    Test user registration with valid details
    [Tags]    functional
    Register User