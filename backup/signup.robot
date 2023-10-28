*** Settings ***
Documentation     Cenários de testes do cadastro de usuário


Library    FakerLibrary

Resource        ../resources/base.resource

# *** Variables ***      # para ter testes independentes deve-se evitar a utilização das variáveis globais
# ${name}        Shinichi Ishii
# ${email}       shin@fake.com.br
# ${password}    pwd123

# Suite Setup        Log     Tudo aqui ocorre antes da SUITE
# Suite Teardown     Log     Tudo aqui ocorre depois da SUITE

Test Setup        Start Session
Test Teardown     Take Screenshot


*** Test Cases ***
Deve poder cadastrar um novo usuário
    [Tags]    new

    ${user}        Create Dictionary        
    ...    name=Shinichi Ishii        
    ...    email=shin@fake.com         
    ...    password=pwd123

    #Utilização sem o dicionário (Super variáveis)
    # ${name}        Set Variable    Shinichi Ishii
    # ${email}       Set Variable    shin@fake.com.br
    # ${password}    Set Variable    pwd123
    
    Remove user from database    ${user}[email]  #Remove o user do banco

    # Start Session  #Colocado no Test setup

    Go to signup page
    Submit signup form    ${user}
    Notice should be    Boas vindas ao Mark85, o seu gerenciador de tarefas.


     

# Sleep    5          #Temporário enquanto o teste não está completo     

    # Take Screenshot  #Colocado no Test Teardown

# 
Não deve permitir o cadastro com o e-mail duplicado
    [Tags]    dup

    ${user}    Create Dictionary    
    ...    name=Brenda Valente    
    ...    email=brenda@fake.com      
    ...    password=pwd123

    # Utilização sem o dicionário (Super variáveis)
    # ${name}        Set Variable    Brenda Valete
    # ${email}       Set Variable    brenda@fake.com.br
    # ${password}    Set Variable    pwd123

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    # Start Session  #Colocado no Test setup
    
    Go to signup page
    Submit signup form    ${user}
    Notice should be    Oops! Já existe uma conta com o e-mail informado.
    
    # Sleep     10

    # Take Screenshot  #Colocado no Test Teardown

Campos obrigatórios
    [Tags]     required


    ${user}        Create Dictionary
    ...     name=${EMPTY}
    ...     email=${EMPTY}
    ...     password=${EMPTY}
    

    Go to signup page
    Submit signup form    ${user}

    Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos


    # Antes de adicionar o "Alert should be" no SignupPage.resource
    # Wait For Elements State    css=.alert-error >> text=Informe seu nome completo
    # ...    visible        5
    
    # Wait For Elements State    css=.alert-error >> text=Informe seu e-email
    # ...    visible        5
    
    # Wait For Elements State    css=.alert-error >> text=Informe uma senha com pelo menos 6 digitos
    # ...    visible        5

  
Não deve cadastrar com email incorreto

    [Tags]     env_email

    ${user}        Create Dictionary    
    ...    name=Ayumi Ishii
    ...    email=site.com
    ...    password=pwd123
    

    Go to signup page
    Submit signup form    ${user}
    Alert should be    Digite um e-mail válido

Não deve cadastrar com senha muito curta

    [Tags]    temp


    @{password_list}   Create List     1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
            ${user}        Create Dictionary
            ...     name=Shinichi Ishii
            ...     email=shin@fake.com.br
            ...     password=${password}
    

    Go to signup page
    Submit signup form    ${user}


    Alert should be    Informe uma senha com pelo menos 6 digitos
        Log To Console    ${password}
        
    END

Não deve cadastrar com senha de 1 digito
    [Tags]     short_pass
    [Template]
    Short password    1

Não deve cadastrar com senha de 2 digitos
    [Tags]     short_pass
    [Template]
    Short password    12

Não deve cadastrar com senha de 3 digitos
    [Tags]     short_pass
    [Template]
    Short password    123

Não deve cadastrar com senha de 4 digitos
    [Tags]     short_pass
    [Template]
    Short password    1234

Não deve cadastrar com senha de 5 digitos
    [Tags]     short_pass
    [Template]
    Short password    12345


*** Keywords ***

Short password
    [Arguments]    ${short_pass}

    ${user}        Create Dictionary
    ...     name=Shinichi Ishii
    ...     email=shin@fake.com.br
    ...     password=${short_pass}
    

    Go to signup page
    Submit signup form    ${user}


    Alert should be    Informe uma senha com pelo menos 6 digitos


# Colocado no template de testes - Aula 38
# Não deve cadastrar com senha de 2 digitos
#     [Tags]     short_pass


#     ${user}        Create Dictionary
#     ...     name=Shinichi Ishii
#     ...     email=shin@fake.com.br
#     ...     password=12
    

#     Go to signup page
#     Submit signup form    ${user}


#     Alert should be    Informe uma senha com pelo menos 6 digitos

# Não deve cadastrar com senha de 3 digitos
#     [Tags]     short_pass


#     ${user}        Create Dictionary
#     ...     name=Shinichi Ishii
#     ...     email=shin@fake.com.br
#     ...     password=123

#     Go to signup page
#     Submit signup form    ${user}


#     Alert should be    Informe uma senha com pelo menos 6 digitos

# Não deve cadastrar com senha de 4 digitos
#     [Tags]     short_pass


#     ${user}        Create Dictionary
#     ...     name=Shinichi Ishii
#     ...     email=shin@fake.com.br
#     ...     password=1234

#     Go to signup page
#     Submit signup form    ${user}


#     Alert should be    Informe uma senha com pelo menos 6 digitos

# Não deve cadastrar com senha de 5 digitos
    [Tags]     short_pass


    ${user}        Create Dictionary
    ...     name=Shinichi Ishii
    ...     email=shin@fake.com.br
    ...     password=12345

    Go to signup page
    Submit signup form    ${user}


    Alert should be    Informe uma senha com pelo menos 6 digitos