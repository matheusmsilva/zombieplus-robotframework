*** Settings ***
Documentation    Base resource of the Robot Project

Library    Browser
Library    libs/Account.py
Library    libs/MultpartEncoder.py
Library    Collections
Library    JSONLibrary

Resource   pages/Leads.resource
Resource   pages/Login.resource
Resource   pages/Movies.resource
Resource   pages/Series.resource

Resource   pages/components/Popup.resource

Resource   database/Scripts.resource
Resource   api/Service.resource

Variables  Env.py

*** Keywords ***
Start session
    [Arguments]    ${url}
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Page    ${url}

Alert Should Have Text
    [Arguments]    ${expected_text}

    Get Text    css=.alert    
    ...    equal    
    ...    ${expected_text}

Multiple Alerts Should Have Text
    [Arguments]    ${expected_text}
    
    ${expected_texts}    Convert To List    ${expected_text}

    ${alerts}    Get Elements    css=.alert
    ${expected_count}    Get Length    ${expected_texts}
    Length Should Be    ${alerts}    ${expected_count}

    FOR     ${index}    IN RANGE    0    ${expected_count}
        ${alert_text}=    Get Text    ${alerts}[${index}]
        Should Be Equal    ${alert_text}    ${expected_text}[${index}]
    END

Get Json fixture
    [Arguments]        ${file_name}   ${scenario}

    ${data}    Load Json From File
    ...        ${EXECDIR}/resources/fixtures/${file_name}.json
    ...        encoding=utf-8
    
    RETURN    ${data}[${scenario}]