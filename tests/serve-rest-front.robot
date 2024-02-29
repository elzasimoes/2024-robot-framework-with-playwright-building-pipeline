*** Settings ***
Resource    ../resources/serve-rest-front.resource

*** Test Cases ***
Login com sucesso Server Rest front
    Abrir o navegador
    Ir para a URL
    Preencher os dados do usuário e cadastrar
    Conferir o usuário que foi cadastrado

