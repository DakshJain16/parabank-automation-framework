*** Settings ***
Library    SeleniumLibrary
Resource    ../../locators/login_locators.robot

*** Keywords ***
Login User
    [Arguments]    ${user}    ${pass}
    Input Text    ${LGN_USERNAME}    ${user}
    Input Text    ${LGN_PASSWORD}    ${pass}
    Click Button    ${LOGIN_BTN}