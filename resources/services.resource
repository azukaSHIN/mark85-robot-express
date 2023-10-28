*** Settings ***
Documentation        Consumindo a API Rest do sistema Mark85

Library    RequestsLibrary

*** Keywords ***

Post user session
    [Arguments]    ${user}

    ${payload}    Create Dictionary    
    ...    email=${user}[email]
    ...    password=${user}[password]

    ${resp}    POST    url=http://localhost:3333/sessions
    ...    json=${payload}
    ...    expected_status=200
    
    ${token}        Set Variable    ${resp.json()}[token]

    Set Test Variable    ${token}

Post a new task
    [Arguments]    ${payload}

    ${headres}    Create Dictionary
    ...    Authorization=${token}

    POST    url=http://localhost:3333/tasks
    ...    json=${payload}
    ...    headers=${headres}
    ...    expected_status=201