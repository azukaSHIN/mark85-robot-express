*** Settings ***
Documentation        Ações e elemntos do componentes de menssagem de alerta

Library    Browser

*** Keywords ***

Alert should be
    [Arguments]        ${expected_text}

        Wait For Elements State    css=.alert-error >> text=${expected_text}
        ...    visible        5