*** Settings ***
Documentation    Elements and operations of Popup Component

Library    Browser

*** Keywords ***
Popup Should Have Text
    [Arguments]    ${expect_msg}

    Get Text    css=.swal2-html-container
    ...    equal    
    ...    ${expect_msg}