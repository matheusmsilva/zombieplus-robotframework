*** Settings ***
Documentation    Layer responsible for making requests

Library      RequestsLibrary
Library      Collections

Resource    ../Base.resource

Variables    Env.py

*** Keywords ***
Set user token
    ${payload}    Create Dictionary    
    ...    email=admin@zombieplus.com    
    ...    password=pwd123
    
    ${response}    POST    
    ...    url=${API_URL}/sessions
    ...    json=${payload}

    ${token}    Set Variable    Bearer ${response.json()}[token]

    RETURN    ${token}
    
Post New Lead By API
    [Arguments]    ${account}
    ${payload}    Create Dictionary    
    ...    name=${account}[name]
    ...    email=${account}[email]

    ${response}    POST    
    ...    url=${API_URL}/leads
    ...    json=${payload}


Get Company Id By Name
    [Arguments]    ${company_name}    ${auth_token}
    
    ${headers}=    Create Dictionary    
    ...    Authorization=${auth_token}

    ${response}=    GET    
    ...    url=${API_URL}/companies?name=${company_name}    
    ...    headers=${headers}
    
    ${company_id}    Set Variable    ${response.json()}[data][0][id]
    RETURN    ${company_id}

Post New Movie By API
    [Arguments]    ${movie}
    ${auth_token}    Set user token    
    ${company_id}    Get Company Id By Name    ${movie}[company]    ${auth_token}
    
    ${data}    Create Dictionary    
    ...    title=${movie}[title]    
    ...    overview=${movie}[overview]    
    ...    company_id=${company_id}    
    ...    release_year=${movie}[release_year]    
    ...    featured=${movie}[featured]
    

    ${response}    Post Multipart Formdata
    ...    ${API_URL}/movies
    ...    ${data}
    ...    ${auth_token}


Post New Serie By API
    [Arguments]    ${serie}
    ${auth_token}    Set user token    
    ${company_id}    Get Company Id By Name    ${serie}[company]    ${auth_token}
    
    ${data}    Create Dictionary    
    ...    title=${serie}[title]    
    ...    overview=${serie}[overview]    
    ...    company_id=${company_id}    
    ...    seasons=${serie}[season]
    ...    release_year=${serie}[release_year]    
    ...    featured=${serie}[featured]
    

    ${response}    Post Multipart Formdata
    ...    ${API_URL}/tvshows
    ...    ${data}
    ...    ${auth_token}