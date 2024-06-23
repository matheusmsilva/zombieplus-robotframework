*** Settings ***
Resource    ../resources/Base.resource

Test Setup    Visit Login Page

*** Test Cases ***
Should log in as admin
    Fill Login Credentials And Submit   admin@zombieplus.com    pwd123
    User Is Logged In    Admin

Should not log in when e-mail is invalid
    Fill Login Credentials And Submit    admin.zombieplus.com    pwd123
    Alert Should Have Text    Email incorreto

Should not log in when password is incorrect
    Fill Login Credentials And Submit    admin@zombieplus.com    abc123
    Popup Should Have Text    Ocorreu um erro ao tentar efetuar o login. Por favor, verifique suas credenciais e tente novamente.

Should not log in when e-mail is not filled
    Fill Login Credentials And Submit    ${EMPTY}    pwd123
    Alert Should Have Text    Campo obrigatório

Should not log in when password is not filled
    Fill Login Credentials And Submit    admin@zombieplus.com    ${EMPTY}
    Alert Should Have Text    Campo obrigatório

Should not log in when mandatory fields are not filled
    Fill Login Credentials And Submit    ${EMPTY}    ${EMPTY}
    @{expected_alerts}    Create List   Campo obrigatório    Campo obrigatório 
    Multiple Alerts Should Have Text    ${expected_alerts}