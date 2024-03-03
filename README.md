# Configuração do Ambiente para Robot Framework

Este README fornece instruções sobre como preparar o ambiente para trabalhar com o Robot Framework, utilizando as bibliotecas Faker Library, DateTime e Browser Library.

## Pré-requisitos

Certifique-se de que os seguintes itens estão instalados em seu ambiente de desenvolvimento:

- **Python**: O Robot Framework é executado em Python, portanto, certifique-se de ter o Python instalado. Você pode baixar a versão mais recente em [python.org](https://www.python.org/downloads/).
- Versão utilizada: 3.11.3

- **NodeJs**: Acesse o site oficial do Node.js em [nodejs.org](https://nodejs.org/) e Instale a versão LTS.
- Versão utilizada: v20.11.1


## Instalação do Robot Framework

- Abra um terminal ou prompt de comando e execute o seguinte comando para instalar o Robot Framework:
```bash
pip install robotframework
```

## FakerLibrary
- A FakerLibrary é uma biblioteca para gerar dados falsos, como nomes, endereços e números de telefone. Instale-a com o seguinte comando:

```bash
pip install robotframework-faker
```

## DateTime Library
- A DateTime Library é uma biblioteca para manipulação de datas e horas da BuiltIn. Importando:

```bash
Library           DateTime Library
```

## Browser Library

- A [Browser Library](https://robotframework-browser.org/) é uma biblioteca para interação com navegadores web. Instale-a com o seguinte comando:

```bash
pip install robotframework-browser
```

## Configuração Adicional para Browser Library

- Para utilizar a Browser Library, é necessário baixar o navegador browser que você deseja automatizar. Execute o seguinte comando para realizar essa configuração através do NodeJs:


```bash
robotframework-browser init
```

## Executando Testes

- Agora que o ambiente está configurado, você pode executar seus testes utilizando o Robot Framework. Certifique-se de ter seus casos de teste no formato adequado (.robot) e execute-os da seguinte maneira:

```bash
robot nome_do_seu_teste.robot
```

- Isso executará os testes usando as bibliotecas configuradas.

- Lembre-se de ajustar as importações nos seus casos de teste para incluir as bibliotecas que você configurou neste README. Por exemplo:


```bash
*** Settings ***
Library        Browser
...            timeout=00:00:05
...            enable_presenter_mode=${true} 
Library        FakerLibrary
Library        DateTime
```

- enable_presenter_mode para habilitar o modo presenter, que executa lentamente mostrando os elementos encontrados através do Highlight;
- timeout para o tempo que ele falhará caso não encontre um elemento;
- timeout default é 30 segundos;

## Tipo de interações com elementos utlizando a Browser

- Record selector consegue auxiliar na inspeção dos elementos da página.

- Por texto
```bash
Click    text="Cadastre-se"
```

- Por CSS
```bash
Click     css=.btn-link
```

- Por Cascata usando o xpath e o texto
```bash
Click     xpath=//*[@id="root"]//button >> text="Cadastrar" 
```

## Casos de teste criados nesse repositório

- Login com sucesso Server Rest front
- Teste com Requisições https
- Interagindo com Dropdown
- Interagindo com iFrames
- Interagindo com Tabelas
- Interagindo com novas abas (pages)
- 01 - Desafio: Conferir se o novo usuário é mostrado na listagem de usuários
- 02 - Desafio: Desenvolva um teste para cadastrar e consultar produto
- Utilizando o Storage Armazenado no Contexto

## Executando testes no CI do Github Actions

 - [Github Actions Started Guide](https://github.com/elzasimoes/2024-robot-framework-with-playwright-building-pipeline/tree/main/.github/workflows)
 - [Teste Manual](https://github.com/elzasimoes/2024-robot-framework-with-playwright-building-pipeline/blob/main/.github/workflows/ci-tests-manual-desafio.yml)
 - [Teste automatizado a cada push](https://github.com/elzasimoes/2024-robot-framework-with-playwright-building-pipeline/blob/main/.github/workflows/ci-tests.yml)

### Robot Results
| :white_check_mark: Passed | :x: Failed | :next_track_button: Skipped | Total | Pass % |
| --- | --- | --- | :---: | :---: |
| 11 | 0 | 0 | 11 | 100

## Documentações

 - [Início rápido para GitHub Actions](https://docs.github.com/pt/actions/quickstart)
 - [Browser Library Keywords](https://marketsquare.github.io/robotframework-browser/Browser.html)
 - [Library Faker](https://pypi.org/project/robotframework-faker/)




