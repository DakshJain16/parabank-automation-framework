*** Settings ***
Library    SeleniumLibrary
Resource    ../../locators/transfer_funds_locators.robot
Resource    ../../resources/keywords/common_keywords.robot

*** Keywords ***
Transfer Funds
    [Documentation]    Transfer funds between accounts
    [Arguments]    ${amount}    ${from_account}    ${to_account}

    Click Element    ${TRANSFER_FUNDS_LINK}
    Wait Until Page Contains    Transfer Funds    10s

    Input Text    ${TRANSFER_AMOUNT_INPUT}    ${amount}

#    Wait Until Page Contains Element    id=fromAccountId    10s
#    Wait Until Page Contains Element    id=toAccountId      10s

    Wait Until Keyword Succeeds    10s    1s
    ...    Verify Dropdown Loaded    id=fromAccountId

#    Wait Until Keyword Succeeds    10s    1s
#    ...    Verify Dropdown Loaded    id=toAccountId

    Select From List By Value    id=fromAccountId    ${from_account}
    ${src_account}=    Get Selected List Value    id=fromAccountId
    Set Suite Variable    ${SRC_ACCOUNT}    ${src_account}

    Select From List By Value    id=toAccountId      ${to_account}
    ${dest_account}=    Get Selected List Value    id=toAccountId
    Set Suite Variable    ${DEST_ACCOUNT}    ${dest_account}

    Click Element    ${TRANSFER_BTN}

    Log To Console    From Accounts: ${src_account}
    Log To Console    To Accounts: ${dest_account}

Transfer Success Confirmation
    [Documentation]    Verify that the transfer success message is displayed
    Wait Until Page Contains    Transfer Complete!    10s
    Page Should Contain    ${SRC_ACCOUNT}
    Page Should Contain    ${DEST_ACCOUNT}
    


