*** Settings ***
Library         Browser
Library        FakerLibrary

*** Variables ***
${BROWSER}        chromium
${HEADLESS}        ${true}
${URL}             https://front.serverest.dev/
${VIEW_PORT}        {'width': 1200, 'height': 800}

*** Keywords ***
Abrir o navegador    
    New Browser    browser=${BROWSER}    headless=${HEADLESS} 
    New Context    viewport=${VIEW_PORT} 

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
    Fill Text      css=input[data-testid='nome']     ${NOME}
    Set Global Variable    ${NOME}
    Set Global Variable    ${EMAIL}
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

    
    


    