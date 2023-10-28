*** Settings ***
Documentation    Online

Resource        ../resources/base.resource

*** Test Cases ***

Webapp deve estar online

    Start Session

    Get Title       equal        Mark85 by QAx

    # Sleep     5    #Temporário até o código ficar completo