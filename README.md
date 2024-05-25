# Projeto Laravel com DDEV

Este repositório contém um projeto Laravel configurado para ser executado com DDEV. Este README fornece instruções sobre como configurar, executar e gerenciar o projeto utilizando o `Makefile` fornecido.

## Pré-requisitos

Antes de começar, você precisará ter os seguintes softwares instalados em sua máquina:

- [DDEV](https://ddev.readthedocs.io/en/stable/#installation)
- [Docker](https://docs.docker.com/get-docker/)
- [Composer](https://getcomposer.org/)
- [Yarn](https://classic.yarnpkg.com/en/docs/install) (opcional, dependendo do uso de front-end)

## Configuração

1. Clone o repositório:
   ```bash
   git clone <URL_DO_REPOSITORIO>
   cd <NOME_DO_REPOSITORIO>
2. Configure o DDEV:
   ```bash
   ddev config

3. Inicie o ambiente DDEV::
   ```bash
   make start

4. Cria o projeto Laravel::
   ```bash
   make new

5. Instale as dependências do Laravel::
   ```bash
   make install