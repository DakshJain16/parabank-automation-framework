*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://parabank.parasoft.com

*** Keywords ***
Create API Session
    ${headers}=    Create Dictionary
    ...    Accept=application/json

    Create Session
    ...    parabank
    ...    ${BASE_URL}
    ...    headers=${headers}
    ...    verify=False

Verify Account Exists
    [Arguments]    ${account_id}
    ${response}=    GET On Session
    ...    parabank
    ...    /parabank/services/bank/accounts/${account_id}

    RETURN  ${response}

Get Customer Login
    [Arguments]    ${username}    ${password}
    
    ${response}=    GET On Session
    ...    parabank
    ...    /parabank/services/bank/login/${username}/${password}

    Should Be Equal As Strings    ${response.status_code}    200
    ${body}=    Set Variable    ${response.json()}
    
    ${customer_id}=    Set Variable    ${body['id']}
    
    RETURN    ${customer_id}

Get Accounts List
    [Arguments]    ${customer_id}

    ${response}=    GET On Session
    ...    parabank
    ...    /parabank/services/bank/customers/${customer_id}/accounts

    RETURN    ${response}

Get Account Details
    [Arguments]    ${account_id}

    ${response}=    GET On Session
    ...    parabank
    ...    /parabank/services/bank/accounts/${account_id}

    RETURN    ${response}

Get Account Balance
    [Arguments]    ${account_id}

    ${response}=    Get Account Details    ${account_id}
    ${account}=    Set Variable    ${response.json()}

    RETURN    ${account['balance']}

Transfer Funds API
    [Arguments]    ${amt}    ${src_acc}    ${to_acc}    
    
    ${params}=    Create Dictionary
    ...    amount=${amt}
    ...    fromAccountId=${src_acc}
    ...    toAccountId=${to_acc}
    
    ${response}=    POST On Session
    ...    parabank
    ...    /parabank/services/bank/transfer
    ...    params=${params}

    RETURN    ${response}
