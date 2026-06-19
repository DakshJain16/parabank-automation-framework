*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/login.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-NEG-01 Login With Non-Existent User
    [Documentation]    verify login is rejected for non-existent user
    [Tags]    negative

    Login User    invalidUser123    invalidPass123

    Page Should Contain    
    ...    The username and password could not be verified.