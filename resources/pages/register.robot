*** Settings ***
Library    SeleniumLibrary
Resource    ../../locators/register_locators.robot
Resource    ../../resources/keywords/common_keywords.robot

*** Keywords ***
Register User
    ${url}=    Get Location
    Log To Console    Current URL: ${url}
    Wait Until Element Is Visible    ${REGISTER_LINK}    10s
    Click Element    ${REGISTER_LINK}

    Input Text    ${FIRST_NAME}    Daksh
    Input Text    ${LAST_NAME}    Jain
    Input Text    ${ADDRESS}    123 Main Street
    Input Text    ${CITY}    Ahmedabad
    Input Text    ${STATE}    Gujarat
    Input Text    ${ZIPCODE}    380001
    Input Text    ${PHONE}    9876543210
    Input Text    ${SSN}    123-45-6789
    Input Text    ${REG_USERNAME}    ${USERNAME}
    Input Text    ${REG_PASSWORD}    ${PASSWORD}
    Input Text    ${CONFIRM_PASSWORD}    ${PASSWORD}
    Click Element    ${REGISTER_BTN}
    Sleep    2s
    
    ${already_exists}=    Run Keyword And Return Status  
    ...    Page Should Contain    This username already exists.  

    IF  ${already_exists}
        Log To Console    Already Registered!
    ELSE    
        Wait Until Page Contains    Your account was created successfully. You are now logged in.
        Log To Console    User registered successfully
    END