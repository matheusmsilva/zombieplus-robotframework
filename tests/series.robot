*** Settings *** 
Resource    ../resources/Base.resource

Suite Setup    Run Keywords    
...    Connect To Zombie Database
...    Delete All From Series

Suite Teardown    Disconnect From All Databases

*** Test Cases ***
Should be able to register a new serie
    ${serie}    Get Json fixture    series    create
    Open Platform And Do Login
    Go To Series Page
    Fill Information And Create Serie    ${serie}
    Popup Should Have Text    A série '${serie}[title]' foi adicionada ao catálogo.

Should be able to remove a serie
    ${serie}    Get Json fixture    series    to_remove

    Post New Serie By API    ${serie}

    Open Platform And Do Login
    Go To Series Page
    Remove Serie    ${serie}[title]
    Popup Should Have Text    Série removida com sucesso.

Should not register new movie when title already exists
    ${serie}    Get Json fixture    series    duplicate

    Post New Serie By API    ${serie}

    Open Platform And Do Login
    Go To Series Page
    Fill Information And Create Serie    ${serie}
    Popup Should Have Text    O título '${serie}[title]' já consta em nosso catálogo. Por favor, verifique se há necessidade de atualizações ou correções para este item.


Should not register new serie when mandatory fields are not filled
    Open Platform And Do Login
    Go To Series Page
    Go To Series Form
    Submit Serie Form

    ${expected_alerts}    Create List
    ...    Campo obrigatório
    ...    Campo obrigatório
    ...    Campo obrigatório
    ...    Campo obrigatório 
    ...    Campo obrigatório (apenas números)

    Multiple Alerts Should Have Text    ${expected_alerts}

Should return series which title contains zumbi
    ${serie}    Get Json fixture    series    search
    
    FOR    ${s}    IN    @{serie}[data]
        Post New Serie By API    ${s}        
    END

    Open Platform And Do Login
    Go To Series Page
    Search Serie    ${serie}[input]
    Serie Table Should Have Content    ${serie}[outputs]