*** Settings ***
Documentation        Cenários de testes de remoção de tarefas

Resource        ../../resources/base.resource

Test Setup    Start Session
Test Teardown    Take Screenshot



*** Test Cases ***

Deve apagar uma tarefa indesejada

    ${data}        Get fixture      tasks    delete


    # Reiniciar a massa
     Reset user from database    ${data}[user]

    # Cadastro da tarefa
    Create a new task from API    ${data}

    # Login na aplicação Web
    Do Login    ${data}[user]

    Request removal    ${data}[task][name]

    Task should not exist    ${data}[task][name]

    # Deletar os cenários
    

    
    
