*** Settings ***
Library    SeleniumLibrary
Resource    ../../locators/account_creation_locators.robot

*** Keywords ***
Verify Account Creation
    [Documentation]    Verify that account is created and present in the accounts overview
    [Arguments]    ${account_number}
    Click Element    ${ACCOUNTS_OVERVIEW_LINK}

    Wait Until Element Is Visible    xpath=//a[text()='${account_number}']    10s

    Log To Console    Account ${account_number} is present in accounts overview

Verify Account Creation Success Message
    [Documentation]    Verify that the account creation success message is displayed
    Wait Until Page Contains    Congratulations, your account is now open.    10s
