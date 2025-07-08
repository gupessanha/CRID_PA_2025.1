# Pipeline CI/CD - Sistema de Notas Smart Contract

Este documento descreve o pipeline de Integração Contínua (CI) e Entrega Contínua (CD) implementado para o projeto Sistema de Notas Smart Contract.

## Visão Geral

O pipeline automatiza as seguintes tarefas:
1. **Verificação de Código**: Formatação, linting e análise estática
2. **Compilação**: Compilação de contratos Solidity
3. **Testes**: Execução de testes automatizados
4. **Cobertura de Código**: Análise de cobertura de testes
5. **Análise de Segurança**: Verificação de vulnerabilidades
6. **Deploy**: Deploy automatizado em ambientes de teste

## Workflows

### 1. CI - Integração Contínua

**Arquivo**: `.github/workflows/ci.yml`

**Quando é executado**:
- Push para branches: `main`, `master`, `develop`
- Pull requests para branches: `main`, `master`, `develop`

**O que faz**:
- Verifica a formatação do código Solidity
- Compila os contratos
- Executa os testes
- Verifica a cobertura de código
- Analisa o tamanho dos contratos

### 2. CD - Entrega Contínua

**Arquivo**: `.github/workflows/cd.yml`

**Quando é executado**:
- Push para branches: `main`, `master`
- Push de tags no formato `v*` (ex: v1.0.0)

**O que faz**:
- Compila os contratos
- Faz o deploy na testnet (Sepolia)
- Cria um relatório de deploy
- Gera artefatos com informações do deploy

### 3. Análise de Segurança

**Arquivo**: `.github/workflows/security.yml`

**Quando é executado**:
- Push de arquivos `.sol` para branches: `main`, `master`, `develop`
- Pull requests contendo arquivos `.sol` para: `main`, `master`
- Manualmente através da interface do GitHub

**O que faz**:
- Executa o Slither para análise de vulnerabilidades
- Verifica o código com Solhint

## Configuração

### Secrets Necessários

Para que o pipeline funcione corretamente, é necessário configurar os seguintes secrets no GitHub:

- `SEPOLIA_URL`: URL do endpoint RPC da testnet Sepolia
- `PRIVATE_KEY`: Chave privada da wallet para deploy
- `ETHERSCAN_API_KEY`: API Key do Etherscan para verificação de contratos

### Como configurar os secrets:

1. No GitHub, acesse **Settings > Secrets and variables > Actions**
2. Clique em **New repository secret**
3. Adicione cada secret com seu respectivo valor

## Comandos Locais

Para executar as verificações localmente antes de fazer push:

```bash
# Instalar dependências
npm install

# Verificar formatação
npm run format:check

# Formatar o código
npm run format

# Verificar linting
npm run lint

# Corrigir issues de linting
npm run lint:fix

# Verificar segurança
npm run security

# Executar testes com cobertura
npm run coverage

# Verificar tamanho dos contratos
npm run size
```

## Estrutura de Diretórios

- `.github/workflows/`: Contém os arquivos de configuração dos workflows
- `deployments/`: Armazena informações de cada deploy organizado por rede
- `artifacts/`: Contém os ABIs e bytecodes dos contratos compilados
- `coverage/`: Relatórios de cobertura de código

## Padrão de Versionamento

Este projeto usa [Semantic Versioning](https://semver.org/):

- **Patch (v1.0.X)**: Correções de bugs
- **Minor (v1.X.0)**: Novas funcionalidades retrocompatíveis
- **Major (vX.0.0)**: Mudanças incompatíveis com versões anteriores

Para fazer um novo deploy em testnet, crie uma tag seguindo este padrão:
