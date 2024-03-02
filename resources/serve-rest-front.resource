*** Settings ***
Library        Browser
...            timeout=00:00:05
...            enable_presenter_mode=${true}
Library        FakerLibrary
Library        DateTime


*** Variables ***
${BROWSER}        chromium
${HEADLESS}        ${false}
${URL}             https://front.serverest.dev/
${VIEW_PORT}        {'width': 1200, 'height': 800}

*** Keywords ***
Abrir o navegador    
    New Browser    browser=${BROWSER}    headless=${HEADLESS} 
    New Context    viewport=${VIEW_PORT}
    ${NOW}         Get Current Date  result_format=%d-%m-%Y_%H%M%S 
    &{recordVideo}    Create Dictionary        dir=./evidences/video/${NOW}   
    New Context    viewport={'width': 1200, 'height': 800}
    ...            recordVideo=&{recordVideo}
    ...            tracing=${OUTPUT_DIR}/browser/traces/${NOW}

Ir para a URL
    New Page        url=${URL}
    ${GET_TITLE}    Get Title    ==     Front - ServeRest 
    Log   ${GET_TITLE}

 Preencher os dados do usuário e cadastrar
     #Record selector ajuda a pegar o css do elemento da página
     Click     css=.btn-link
    #  Click    text="Cadastre-se"
    #  Click    css=a[data-testid='cadastrar']
    ${EMAIL}        FakerLibrary.Email
    ${NOME}         FakerLibrary.Name Female
    ${PASSWORD}     FakerLibrary.PASSWORD
    Set Test Variable        ${NOME}
    Set Test Variable        ${EMAIL}
    Set Test Variable        ${PASSWORD}

    Fill Text      css=input[data-testid='nome']     ${NOME}
    Fill Text      css=input[data-testid='email']     ${EMAIL}
    Fill Text      css=input[data-testid='password']     ${PASSWORD} 
    #Cascata
    # Click     xpath=//*[@id="root"]//button >> text="Cadastrar" 
    Take Screenshot 
    Check Checkbox    css=input[data-testid='checkbox']
    Click     css=button[data-testid='cadastrar']
    Take Screenshot  

Conferir o usuário que foi cadastrado
    Wait For Elements State    h1    visible
    Take Screenshot
    Get Text    h1     ==     Bem Vindo ${NOME}
    Get Element States    css=button[data-testid='logout']    validate    value & visible 

Acessar a Lista de usuários
    Click         css=a[data-testid='listarUsuarios']
    Get Text    h1     ==     Lista dos usuários
    Take Screenshot

Conferir se o usuário aparece na lista
    ${elemento}      Get Table Cell Element    css=table    "Nome"    "${EMAIL}"
    ${usuario_nome}  Get Text  ${elemento}  ==  ${NOME}
    Highlight Elements    ${elemento}
    Take Screenshot       fullPage=${true}   

Acessar Cadastro de Produtos
    Click         css=a[data-testid='cadastrarProdutos']
    Get Text    h1     ==     Cadastro de Produtos
    Take Screenshot

Cadastrar um novo produto
    Fill Text    css=input[data-testid='nome']     Xbox One
    ${produto_price}    FakerLibrary.Random Number
    Fill Text   css=input[data-testid='preco']     ${produto_price}
    Set Global Variable    ${produto_price}
    ${produto_description}    FakerLibrary.Text
    Fill Text    css=textarea[data-testid='descricao']     ${produto_description}  
    ${produto_quantity}    FakerLibrary.Random Number
    Fill Text    css=input[data-testid='quantity']     ${produto_quantity}
    Upload File By Selector   css=input[data-testid='imagem']    imagem.png
    Click         css=button[data-testid='cadastarProdutos']
    Sleep    2

Verificar se o produto está na lista
    Get Text    h1     ==     Lista dos Produtos
    ${elemento}      Get Table Cell Element    css=table    "Nome"    "${produto_price}"
    ${usuario_nome}  Get Text  ${elemento}  ==  Xbox One
    Highlight Elements    ${elemento}
    Take Screenshot       fullPage=${true}

Criar usuário via API
    ${EMAIL}        FakerLibrary.Email
    ${NOME}         FakerLibrary.Name Female
    ${PASSWORD}     FakerLibrary.PASSWORD
    Set Test Variable        ${NOME}
    Set Test Variable        ${EMAIL}
    Set Test Variable        ${PASSWORD}

    ${resposta}  Http    url=https://serverest.dev/usuarios
    ...                  method=POST
    ...                  body={"nome": "${NOME}","email": "${EMAIL}","password": "${PASSWORD}","administrador": "true"}   

    Should Be Equal As Integers    ${resposta["status"]}    201

Logar com o usuário cadastrado via API
    ${resposta}  Http    url=https://serverest.dev/login
    ...                  method=POST
    ...                  body={"email": "${EMAIL}","password": "${PASSWORD}"}
    
    Should Be Equal As Integers    ${resposta["status"]}    200

    LocalStorage Set Item    serverest/userEmail    ${EMAIL}
    LocalStorage Set Item    serverest/userToken    ${resposta["body"]["authorization"]}
    LocalStorage Set Item    serverest/userNome     ${NOME}

    Go To    url=https://front.serverest.dev/admin/home

    Take Screenshot

    
    


    