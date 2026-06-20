*** Settings ***
Library    SeleniumLibrary
Library    DataDriver   file=${EXECDIR}/testdata'/login_data.csv  dialect=excel
Resource    locators/register_locators.robot
Resource    resources/keywords/common_keywords.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

Test Template  User Registration

*** Test Cases ***
Test Case For Data Driven   ${UserFirstname}    ${UserLastname}    ${UserAddress}    ${UserCity}    ${UserState}    ${UserZipcode}    ${Phno}    ${UserSSN}    ${User_name}    ${User_Pwd}    ${Confirm}
   [Documentation]      Data driven testing using csv
   [Tags]   datadriver

*** Keywords ***
User Registration
    [Arguments]    ${UserFirstname}    ${UserLastname}    ${UserAddress}    ${UserCity}    ${UserState}    ${UserZipcode}    ${Phno}    ${UserSSN}    ${User_name}    ${User_Pwd}    ${Confirm}

    Wait Until Element Is Visible    ${REGISTER_LINK}    10s
    Click Element    ${REGISTER_LINK}

    Input Text    ${FIRST_NAME}   ${UserFirstname}
    Input Text    ${LAST_NAME}  ${UserLastname}
    Input Text    ${ADDRESS}  ${UserAddress}
    Input Text    ${CITY}  ${UserCity}
    Input Text    ${STATE}  ${UserState}
    Input Text    ${ZIPCODE}  ${UserZipcode}
    Input Text    ${PHONE}  ${Phno}
    Input Text    ${SSN}  ${UserSSN}
    Input Text    ${REG_USERNAME}  ${User_name}
    Input Text    ${REG_PASSWORD}  ${User_Pwd}
    Input Text    ${CONFIRM_PASSWORD}  ${Confirm}
    Click Element  ${REGISTER_BTN}

#CLick Register After Navigating
#    Open Application
#    CLick Register Button






