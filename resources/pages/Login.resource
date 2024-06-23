*** Settings ***
Documentation    Elements and operations for Login Page

Library    Browser

Resource    ../Base.resource

Variables    ../Env.py

*** Keywords ***
Visit Login Page
    Start session    ${WEB_URL}/admin/login

Fill Login Credentials And Submit
    [Arguments]    ${email}    ${password}
    Fill Text    //input[@placeholder="E-mail"]    ${email}
    Fill Text    //input[@placeholder="Senha"]    ${password}
    Click        //button[text()="Entrar"]

Open Platform And Do Login
    Visit Login Page
    Fill Login Credentials And Submit    admin@zombieplus.com    pwd123