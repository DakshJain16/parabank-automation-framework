*** Variables ***
${REGISTER_LINK}  xpath=//a[contains(@href,'register.htm')]
${FIRST_NAME}  id=customer.firstName
${LAST_NAME}  id=customer.lastName
${ADDRESS}  id=customer.address.street
${CITY}  id=customer.address.city
${STATE}  id=customer.address.state
${ZIPCODE}  id=customer.address.zipCode
${PHONE}  id=customer.phoneNumber
${SSN}  id=customer.ssn
${REG_USERNAME}  id=customer.username
${REG_PASSWORD}  id=customer.password
${CONFIRM_PASSWORD}  id=repeatedPassword
${REGISTER_BTN}  xpath=//input[@value="Register"]
