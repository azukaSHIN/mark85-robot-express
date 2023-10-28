*** Settings ***

Library         libs/database.py
Library         Browser
Library        JSONLibrary

Resource        env.resource

Resource        pages/components/Notice.resource
Resource        pages/components//Alert.resource
Resource        pages/components/Header.resource

Resource        pages/SignupPage.resource
Resource        pages/LoginPage.resource
Resource        pages/TaskCreatePage.resource
Resource        pages/TasksPage.resource

Resource        services.resource

*** Keywords ***

Start Session

        New Browser     browser=${BROWSER}       headless=false
        New Page        ${BASE_URL}


# Short password
#     [Arguments]    ${short_pass}

#     ${user}        Create Dictionary
#     ...     name=Shinichi Ishii
#     ...     email=shin@fake.com.br
#     ...     password=${short_pass}
    

#     Go to signup page
#     Submit signup form    ${user}


#     Alert should be    Informe uma senha com pelo menos 6 digitos



# Helpers

Get fixture
    [Arguments]    ${file_name}            ${scenario}

        ${data}     Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json  #Diretorio de execução do projeto - cmd -> pwd
    ...    encoding=utf-8   #Devido a acentuação de palavras
    
    [Return]    ${data}[${scenario}]

Reset user from database
    [Arguments]       ${user}

        
    Clean user from database    ${user}[email]
    Insert user from database    ${user}


Create a new task from API
    [Arguments]     ${data}

    Post user session    ${data}[user]
    Post a new task    ${data}[task]

Do Login
    [Arguments]    ${user}

    Submit login form           ${user}[email]        ${user}[password]
    User should be logged in    ${user}[name]