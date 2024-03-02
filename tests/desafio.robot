*** Settings ***
Resource    ../resources/serve-rest-front.resource
Suite Teardown    Close Browser    ALL

*** Test Cases ***
01 - Desafio: Conferir se o novo usuário é mostrado na listagem de usuários
    Abrir o navegador
    Ir para a URL
    Preencher os dados do usuário e cadastrar
    Conferir o usuário que foi cadastrado
    Acessar a Lista de usuários
    Conferir se o usuário aparece na lista

02 - Desafio: Desenvolva um teste para cadastrar e consultar produto
    Ir para a URL
    Preencher os dados do usuário e cadastrar
    Acessar Cadastro de Produtos
    Cadastrar um novo produto
    Verificar se o produto está na lista





