*** Settings ***
Documentation    Elements and operations for Movies Page

Library    Browser

*** Keywords ***
User Is Logged In
    [Arguments]    ${username}
    Get Text    css=.logged-user    
    ...    equal    
    ...    Olá, ${username}

Go To Movie Form
    Click    css=a[href$="register"]

Submit Movie Form
    Click    css=button >> text="Cadastrar"

Fill Information And Create Movie
    [Arguments]    ${movie}
    Go To Movie Form

    Fill Text    id=title    ${movie}[title]
    Fill Text    id=overview    ${movie}[overview]

    Click    css=#select_company_id .react-select__value-container
    Click    //div[contains(@class, 'react-select__option') and text()='${movie}[company]']

    Click    css=#select_year .react-select__value-container
    Click    //div[contains(@class, 'react-select__option') and text()='${movie}[release_year]']

    Upload File By Selector    
    ...    css=input[name=cover]    
    ...    ${EXECDIR}/resources/fixtures${movie}[cover]

    IF    ${movie}[featured]
        Click    css=.featured .react-switch
    END

    Submit Movie Form

Search Movie
    [Arguments]    ${movie_title}
    Fill Text    //input[@placeholder="Busque pelo nome"]    ${movie_title}
    Click    css=.actions button

Movie Table Should Have Content
    [Arguments]    ${content}
    ${content_list}=    Evaluate    ${content} if isinstance(${content}, list) else [${content}]    sys, os
    
    FOR    ${item}    IN    @{content_list}
        ${locator}=    Set Variable    xpath=//td[text()="${item}"]
        Wait For Elements State    
        ...    ${locator}    
        ...    visible    5
    END

Remove Movie
    [Arguments]    ${title}
    Click    //td[text()="${title}"]/..//button
    Click    .confirm-removal