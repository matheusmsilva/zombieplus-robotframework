*** Settings *** 
Resource    ../resources/Base.resource

Suite Setup    Run Keywords    
...    Connect To Zombie Database
...    Delete All From Movies

Suite Teardown    Disconnect From All Databases

*** Test Cases ***
Should be able to register a new movie
    ${movie}    Get Json fixture    movies    create
    Open Platform And Do Login
    Fill Information And Create Movie    ${movie}
    Popup Should Have Text    O filme '${movie}[title]' foi adicionado ao catálogo.

Should be able to remove a movie
    ${movie}    Get Json fixture    movies    to_remove

    Post New Movie By API    ${movie}

    Open Platform And Do Login
    Remove Movie    ${movie}[title]
    Popup Should Have Text    Filme removido com sucesso.

Should not register new movie when title already exists
    ${movie}    Get Json fixture    movies    duplicate

    Post New Movie By API    ${movie}

    Open Platform And Do Login
    Fill Information And Create Movie    ${movie}
    Popup Should Have Text    O título '${movie}[title]' já consta em nosso catálogo. Por favor, verifique se há necessidade de atualizações ou correções para este item.


Should not register new movie when mandatory fields are not filled
    Open Platform And Do Login
    Go To Movie Form
    Submit Movie Form
    
    ${expected_alerts}    Create List
    ...    Campo obrigatório
    ...    Campo obrigatório
    ...    Campo obrigatório
    ...    Campo obrigatório 

    Multiple Alerts Should Have Text    ${expected_alerts}

Should return movies which title contains zumbi
    ${movie}    Get Json fixture    movies    search
    
    FOR    ${m}    IN    @{movie}[data]
        Post New Movie By API    ${m}        
    END

    Open Platform And Do Login
    Search Movie    ${movie}[input]
    Movie Table Should Have Content    ${movie}[outputs]