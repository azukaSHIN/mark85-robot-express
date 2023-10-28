*** Settings ***
Documentation        Ações e elementos da página de Login


Library    Browser

*** Keywords ***

Submit login form
    #ANTES
    [Arguments]        ${email}        ${password}

    Fill Text    css=input[placeholder$=mail]    ${email}
    Fill Text    css=input[placeholder=Senha]    ${password}

    #DEPOIS
    # [Arguments]        ${user}

    # Fill Text    css=input[placeholder$=mail]    ${user}[email]
    # Fill Text    css=input[placeholder=Senha]    ${user}[password]


    # Click    xpath=//button[text()="Entrar"]
    Click    css=button >> text=Entrar




