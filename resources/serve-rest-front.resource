*** Settings ***
Library        Browser
...            timeout=00:01:00
...            enable_presenter_mode=${true}
Library        FakerLibrary
Library        DateTime


*** Variables ***
${BROWSER}        chromium
${HEADLESS}        ${false}
${URL}             https://front.serverest.dev/
${VIEW_PORT}        {'width': 1200, 'height': 800}
${NOME}         Elza
${PASSWORD}     123456


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
    ${EMAIL}        FakerLibrary.Email
    Set Global Variable    ${EMAIL} 
    Click    css=a[data-testid='cadastrar']
    Fill Text      css=input[data-testid='nome']     ${NOME}
    Fill Text      css=input[data-testid='email']     ${EMAIL}
    Fill Text      css=input[data-testid='password']     ${PASSWORD}
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
    ${produto_price}    FakerLibrary.Random Number
    Set Global Variable    ${produto_price}
    ${produto_description}    FakerLibrary.Text
    ${produto_quantity}    FakerLibrary.Random Number
    ${product_name}    FakerLibrary.Word
    Set Global Variable    ${product_name}  
    Fill Text    css=input[data-testid='nome']      ${product_name}
    Fill Text   css=input[data-testid='preco']     ${produto_price}
    Fill Text    css=textarea[data-testid='descricao']     ${produto_description}  
    Fill Text    css=input[data-testid='quantity']     ${produto_quantity}
    Upload File By Selector   css=input[data-testid='imagem']    imagem.png
    Click         css=button[data-testid='cadastarProdutos']

Verificar se o produto está na lista
    Set Browser Timeout    5000
    Get Text    h1     ==     Lista dos Produtos
    ${elemento}      Get Table Cell Element    css=table    "Nome"    "${produto_price}"
    ${usuario_nome}  Get Text  ${elemento}  ==   ${product_name}
    Highlight Elements    ${elemento}
    Take Screenshot       fullPage=${true}

Criar usuário via API
    ${EMAIL}        FakerLibrary.Email
    Set Global Variable    ${EMAIL} 
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

Cadastrar Usuário e Logar
    ${EMAIL}        FakerLibrary.Email

    Set Global Variable        ${NOME}
    Set Global Variable        ${EMAIL}
    Set Global Variable        ${PASSWORD} 
    New Browser
    New Page        url=${URL}   
    Criar usuário via API
    Logar com o usuário cadastrado via API
    ${STORAGE_FILE}    Save Storage State
    Set Suite Variable    ${STORAGE_FILE}


Abrir o Site do Server Rest Front Logado
    New Browser    browser=${BROWSER}    
    ...                headless=${HEADLESS} 
    New Context        viewport=${VIEW_PORT}
    ...                storageState=${STORAGE_FILE}
    New Page           url=https://front.serverest.dev/admin/home
    Get Text    h1    ==     Bem Vindo ${NOME} 
    Take Screenshot 

    
    


    