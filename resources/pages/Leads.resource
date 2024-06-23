*** Settings ***
Documentation    Elements and operations of Leads Page

Library    Browser

Resource    ../Base.resource

Variables    ../Env.py

*** Keywords ***
Visit Lead Page
    Start session    ${WEB_URL}

Open Lead Modal
    Click    css=button >> text=Aperte o play... se tiver coragem
    ${text}    Get Text
    ...    css=div[data-testid='modal'] h2
    ...    equal    Fila de espera

Submit Lead Form
    [Arguments]    ${name}    ${email}
    Fill Text    //input[@placeholder='Informe seu nome']    ${name}
    Fill Text    //input[@placeholder='Informe seu email']   ${email}
    Click        //button[text()='Quero entrar na fila!']