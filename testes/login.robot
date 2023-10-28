*** Settings ***
Documentation            Cenários de autenticação do usuário

Library    Collections

Resource    ../resources/base.resource


Test Setup        Start Session
Test Teardown    Take Screenshot


*** Test Cases ***

Deve poder logar com um usuário pré-cadastrado

    ${user}        Create Dictionary 
    ...    name=Shinichi Ishii    
    ...    email=shin@fake.com.br        
    ...    password=pwd123
   
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    # Submit login form      $(user)
    Submit login form           ${user}[email]        ${user}[password]
    User should be logged in    ${user}[name] 

Não deve locar com senha inválida
    ${user}        Create Dictionary 
    ...    name=Ayumi Ishii   
    ...    email=ayumi@fake.com.br        
    ...    password=pwd123
   
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Set To Dictionary    ${user}    password=pwdxxx

    # Submit login form      $(user)
    Submit login form        ${user}[email]        ${user}[password]

    Notice should be    Ocorreu um erro ao fazer login, verifique suas credenciais.