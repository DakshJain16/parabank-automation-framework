*** Settings ***
Library    SeleniumLibrary
Library    ../../config/environment.py
Resource   ../pages/login.robot
Resource    ../pages/register.robot

*** Variables ***
${BROWSER}    chrome
${ENV}    qa

*** Keywords ***
Load Environment
    Load Env    ${ENV}
    ${url}=  Get Env    baseurl
    ${username}=  Get Env    username
    ${password}=  Get Env    password

    Set Global Variable    ${BASE_URL}  ${url}
    Set Global Variable    ${USERNAME}  ${username}
    Set Global Variable    ${PASSWORD}  ${password}

    Log    Loaded BASE_URL=${BASE_URL}

Open Application
    [Documentation]  Opens the application
    Should Not Be Empty    ${BASE_URL}    Base URL must not be empty. Please set it in config/env.yaml
    Open Browser  ${BASE_URL}  ${BROWSER}
    Maximize Browser Window
    Sleep    2s

Close Application
    [Documentation]  Closing the application
    Close All Browsers

Ensure User Is Logged In
    Login User    ${USERNAME}    ${PASSWORD}

    ${login_success}=    Run Keyword And Return Status
    ...    Wait Until Page Contains    
    ...    Accounts Overview
    ...    10s

    IF    not ${login_success}
        Go To    ${BASE_URL}
        Register User
    END
    
Verify Dropdown Loaded
    [Arguments]    ${loc}
    ${items}=    Get List Items    ${loc}
    Log To Console    Available Accounts: ${items}
    Should Not Be Empty    ${items}