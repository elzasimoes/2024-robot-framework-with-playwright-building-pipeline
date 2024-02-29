*** Settings ***
Resource    ../resources/serve-rest-front.resource

*** Test Cases ***
Desafio: Conferir se o novo usuário é mostrado na listagem de usuários
    Abrir o navegador
    Ir para a URL
    Preencher os dados do usuário e cadastrar
    Conferir o usuário que foi cadastrado
    Acessar a Lista de usuários
    Conferir se o usuário aparece na lista



