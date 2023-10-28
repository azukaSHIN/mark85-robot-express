*** Settings ***
Documentation        Ações e elementos da página de cadastro de tarefas

Library        Browser

*** Keywords ***
Submit task form
    [Arguments]    ${task}
    
    # <input name="name" type="text" placeholder="Nome da tarefa" value="">
    # O type="text" não é muito recomendado o uso
    # type="placeholder" -> css=input[placeholder="Nome da tarefa"]
    # Termina com ($)    -> css=input[placeholder$="tarefa"]
    # Inicia com (^)     -> css=input[placeholder^="Nome"]
    # Entre (*)          -> css=input[placeholder*="da"]
    # type="name" -> css=input[name=name] 

    Fill Text    css=input[placeholder$="tarefa"]    ${task}[name]

    ${tags_element}        Set Variable        css=input[name=tags]

    FOR    ${tag}    IN    @{task}[tags]
        Fill Text    ${tags_element}        ${tag}
        Sleep   1        #Think time
        Press Keys   ${tags_element}         Enter
    END

    Click        css=button >> text=Cadastrar

    