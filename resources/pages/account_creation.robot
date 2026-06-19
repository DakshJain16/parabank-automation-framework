*** Settings ***
Library    SeleniumLibrary
Resource    ../../locators/account_creation_locators.robot
Resource    ../../resources/keywords/common_keywords.robot

*** Keywords ***
Create Savings Account
    [Documentation]    Create a savings account with the provided details
    Click Element    ${OPEN_NEW_ACCOUNT_LINK}

    Wait Until Page Contains    Open New Account    10s
#    Wait Until Element Is Visible    id=type    10s
#    Wait Until Element Is Visible    id=fromAccountId    10s

    Wait Until Keyword Succeeds    10s    1s
    ...    Verify Dropdown Loaded    id=fromAccountId

    ${accounts}=    Get List Items    id=fromAccountId
    ${source_account}=    Set Variable    ${accounts}[0]
    Set Suite Variable    ${SOURCE_ACCOUNT_NUMBER}    ${source_account}

    Select From List By Label    id=type  SAVINGS
    Select From List By Index    id=fromAccountId    0

    Click Element    ${OPEN_NEW_ACCOUNT_BTN}

    Wait Until Element Is Visible    xpath=//a[@id="newAccountId"]    10s

    ${account_number}=    Get Text    xpath=//a[@id="newAccountId"]
    Set Suite Variable    ${SAVINGS_ACCOUNT_NUMBER}    ${account_number}
    Log To Console    New account number: ${account_number}

    Set Suite Variable    ${ACCOUNT_TYPE}    SAVINGS

Create Checking Account
    [Documentation]    Create a checking account with the provided details
    Click Element    ${OPEN_NEW_ACCOUNT_LINK}

    Wait Until Page Contains    Open New Account    10s
#    Wait Until Element Is Visible    id=type    10s
#    Wait Until Element Is Visible    id=fromAccountId    10s

    Wait Until Keyword Succeeds    10s    1s
    ...    Verify Dropdown Loaded    id=fromAccountId

    ${accounts}=    Get List Items    id=fromAccountId
    ${source_account}=    Set Variable    ${accounts}[0]
    Set Suite Variable    ${SOURCE_ACCOUNT_NUMBER}    ${source_account}

    Select From List By Label    id=type  CHECKING
    Select From List By Index    id=fromAccountId    0

    Click Element    ${OPEN_NEW_ACCOUNT_BTN}
    
    Wait Until Element Is Visible    xpath=//a[@id="newAccountId"]    10s
    
    ${account_number}=    Get Text    xpath=//a[@id="newAccountId"]
    Set Suite Variable    ${CHECKING_ACCOUNT_NUMBER}    ${account_number}
    Log To Console    New account number: ${account_number}

    Set Suite Variable    ${ACCOUNT_TYPE}    CHECKING
