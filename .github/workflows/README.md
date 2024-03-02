## Github Actions Started Guide

[Github Actions Documentation](https://docs.github.com/pt/actions/quickstart).


## Nome do workflow
```bash
name: GitHub Actions Demo
```
## Nome da execução 
- github.actor: Quem dispara o worklow

```bash
run-name: ${{ github.actor }} is testing out GitHub Actions 🚀
```

## Gatilho que aciona o workflow 

- "[push]", a cada push ele será acionado. 

```bash
on: [push]
```

- Em push e Fork

```bash
on: [push, fork]
```
- Push em uma branch específica 

```bash
on:
  push:
    branches:
      - main
      - 'releases/**'
```

- Workflow dispatch - Inserir dados para execução manual

```bash
on:
 workflow_dispatch
```

## Jobs

- Conjunto de steps
- Nome do Job: Explore-GitHub-Actions-1
- É possível nomear os steps: - name: Check out repository code
- Servidor onde ele vai executar: runs-on: ubuntu-latest
- Passos da execução: steps: - run: echo "🎉 The job was automatically triggered by a ${{ github.event_name }} event."
- É possível fazer um checkout da pasta do projeto para acessar documentos da pasta do projeto: uses: actions/checkout@v3

```bash
jobs:
  Explore-GitHub-Actions-1:
    runs-on: ubuntu-latest
    steps:
      - run: echo "🎉 The job was automatically triggered by a ${{ github.event_name }} event."
      - run: echo "🐧 This job is now running on a ${{ runner.os }} server hosted by GitHub!"
      - run: echo "🔎 The name of your branch is ${{ github.ref }} and your repository is ${{ github.repository }}."
      - name: Check out repository code
        uses: actions/checkout@v3
      - run: echo "💡 The ${{ github.repository }} repository has been cloned to the runner."
      - run: echo "🖥️ The workflow is now ready to test your code on the runner."
      - name: List files in the repository
        run: |
          ls ${{ github.workspace }}
      - run: echo "🍏 This job's status is ${{ job.status }}."

  Explore-GitHub-Actions-2:
    runs-on: ubuntu-latest
    steps:
      - run: echo "🎉 The job was automatically triggered by a ${{ github.event_name }} event."
      - run: echo "🐧 This job is now running on a ${{ runner.os }} server hosted by GitHub!"
      - run: echo "🔎 The name of your branch is ${{ github.ref }} and your repository is ${{ github.repository }}."
      - name: Check out repository code
        uses: actions/checkout@v3
      - run: echo "💡 The ${{ github.repository }} repository has been cloned to the runner."
      - run: echo "🖥️ The workflow is now ready to test your code on the runner."
      - name: List files in the repository
        run: |
          echo "Listando os arquivos do meu diretorio"
          ls ${{ github.workspace }}
      - run: echo "🍏 This job's status is ${{ job.status }}."

```