*** Settings ***
Documentation        Cenário de cadastro de tarefas

Library        JSONLibrary

Resource               ../../resources/base.resource
Resource    ../../resources/pages/TasksPage.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***

Deve poder cadastrar uma nova tarefas
    [Tags]    critical
    

    ${data}    Get fixture    tasks    create

    Reset user from database    ${data}[user]

    Do Login    ${data}[user]
    
    Go to task form
    Submit task form             ${data}[task]
    Task should be registered    ${data}[task][name]

 
Não deve cadastrar com nome duplicado
    [Tags]    dup

    ${data}        Get fixture    tasks    duplicate

    Reset user from database    ${data}[user]

    #E que esse usário já cadastrou uma tarefa
    Create a new task from API    ${data}

    #E que estou logado na aplicação web
    Do Login    ${data}[user]

    #Quando tento um cadastrar essa mesma tarefa que já foi cadastrada
    Go to task form    #Cadastrar primeira vez
    Submit task form             ${data}[task]

    #Então deve ver uma notificação de duplicidade
    Notice should be      Oops! Tarefa duplicada.

Não deve cadastrar uma tarefa quando atinge o limite de Tags
    [Tags]    tags_limit

    ${data}        Get fixture    tasks    tags_limit

    Reset user from database    ${data}[user]

    Do Login    ${data}[user]

    Go to task form   
    Submit task form             ${data}[task]

    Notice should be      Oops! Limite de tags atingido.

    Sleep    5


