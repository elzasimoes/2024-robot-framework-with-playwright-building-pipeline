*** Settings ***
Resource    ../resources/serve-rest-front.resource
Suite Setup    Cadastrar Usuário e Logar  
Suite Teardown    Close Browser    ALL

*** Test Cases ***
Login com sucesso Server Rest front
    Abrir o navegador
    Ir para a URL
    Preencher os dados do usuário e cadastrar
    Conferir o usuário que foi cadastrado

Teste com Requisições https
    Abrir o navegador
    Ir para a URL
    Criar usuário via API
    Logar com o usuário cadastrado via API

Utilizando o Storage Armazenado no Contexto
    Abrir o Site do Server Rest Front Logado
    Acessar a Lista de usuários

01 - Desafio: Conferir se o novo usuário é mostrado na listagem de usuários
    Abrir o Site do Server Rest Front Logado
    Acessar a Lista de usuários
    Conferir se o usuário aparece na lista

02 - Desafio: Desenvolva um teste para cadastrar e consultar produto
    Abrir o Site do Server Rest Front Logado
    Acessar Cadastro de Produtos
    Cadastrar um novo produto
    Verificar se o produto está na lista
