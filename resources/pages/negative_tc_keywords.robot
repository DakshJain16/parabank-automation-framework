*** Settings ***
Library    SeleniumLibrary
Resource    ../../locators/transfer_funds_locators.robot
Resource    ../../resources/keywords/common_keywords.robot

*** Keywords ***
Transfer Blank Amount
    [Documentation]    Go to transfer page and submit without entering an amount
    Click Element    ${TRANSFER_FUNDS_LINK}
    Wait Until Page Contains    Transfer Funds    10s
    
    Wait Until Keyword Succeeds    10s    1s
    ...    Verify Dropdown Loaded    id=fromAccountId
    
    Select From List By Index    ${TRANSFER_FROM_DROPDOWN}    0
    Select From List By Index    ${TRANSFER_TO_DROPDOWN}    1

    Click Element    ${TRANSFER_BTN}

Verify Blank Transfer Error Is Shown
    [Documentation]    checks whether page contains 'Error!'
    Sleep    2s

    Page Should Contain
    ...    Error!

Transfer Negative Amount
    [Documentation]    Go to transfer page and submit with negative amount
    Click Element    ${TRANSFER_FUNDS_LINK}
    Wait Until Page Contains    Transfer Funds    10s

    Input Text    ${TRANSFER_AMOUNT_INPUT}    -100

    Wait Until Keyword Succeeds    10s    1s
    ...    Verify Dropdown Loaded    id=fromAccountId

    Select From List By Index    ${TRANSFER_FROM_DROPDOWN}    0
    Select From List By Index    ${TRANSFER_TO_DROPDOWN}    1

    Click Element    ${TRANSFER_BTN}

Verify Negative Transfer Error Is Shown
    [Documentation]    checks whether page contains 'Error!'
    Sleep    2s
    Page Should Not Contain
    ...    Transfer Complete!
