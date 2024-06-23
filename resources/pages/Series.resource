*** Settings ***
Documentation    Elements and operations for Series Page

Library    Browser

*** Keywords ***
Go To Series Page
    Click    css=a[href*=tvshows]

Go To Series Form
    Click    css=a[href$="register"]

Submit Serie Form
    Click    css=button >> text="Cadastrar"

Fill Information And Create Serie
    [Arguments]    ${serie}
    Go To Series Form

    Fill Text    id=title    ${serie}[title]
    Fill Text    id=overview    ${serie}[overview]

    Click    css=#select_company_id .react-select__indicator
    Click    //div[contains(@class, 'react-select__option') and text()='${serie}[company]']

    Click    css=#select_year .react-select__indicator
    Click    //div[contains(@class, 'react-select__option') and text()='${serie}[release_year]']

    Fill Text    css=input[name=seasons]    ${serie}[season]

    Upload File By Selector    
    ...    css=input[name=cover]    
    ...    ${EXECDIR}/resources/fixtures${serie}[cover]

    IF    ${serie}[featured]
        Click    css=.featured .react-switch
    END

    Submit Serie Form

Search Serie
    [Arguments]    ${serie_title}
    Fill Text    //input[@placeholder="Busque pelo nome"]    ${serie_title}
    Click    css=.actions button

Serie Table Should Have Content
    [Arguments]    ${content}
    ${content_list}=    Evaluate    ${content} if isinstance(${content}, list) else [${content}]    sys, os
    
    FOR    ${item}    IN    @{content_list}
        ${locator}=    Set Variable    xpath=//td[text()="${item}"]
        Wait For Elements State    
        ...    ${locator}    
        ...    visible    5
    END

Remove Serie
    [Arguments]    ${title}
    Click    //td[text()="${title}"]/..//button
    Click    .confirm-removal