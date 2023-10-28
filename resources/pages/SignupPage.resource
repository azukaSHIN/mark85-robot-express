*** Settings ***
Documentation         Elementos e ações da página de cadastro

Library             Browser
Resource            ../env.resource


*** Keywords ***

Go to signup page
    Go To        ${BASE_URL}/signup

    # Checkpoint
    Wait For Elements State    css=h1     visible       5
    Get Text                   css=h1     equal         Faça seu cadastro

Submit signup form
    [Arguments]        ${user}
    Fill Text    id=name                          txt=${user}[name]
    #            css=input[name=name]
    #            css=input[placeholder="Nome"]
    Fill Text    css=#email                       txt=${user}[email]
    #            css=input[name=email]
    Fill Text    xpath=//input[@id="password"]    txt=${user}[password]
    #            css=input[name=password]
    
    Click    css=button[type=submit] >> text=Cadastrar
    #        id=buttonSignup
    #        css=button[type=submit]
    #        xpath=//button[text()="Cadastrar"]




