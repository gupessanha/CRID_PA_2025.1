# Sistema de Notas - Smart Contract

Repositório para o trabalho final de Programação Avançada - Sistema de gerenciamento de notas usando Smart Contracts em Solidity.

## 📋 Descrição do Projeto

Este projeto implementa um sistema de notas acadêmicas utilizando smart contracts na blockchain Ethereum. O sistema permite o gerenciamento de disciplinas, alunos, professores e notas de forma descentralizada e segura.

## 🏗️ Arquitetura do Sistema

### Entidades Principais

#### 👨‍🎓 Aluno
- **Nome**: Privado (apenas o próprio aluno pode visualizar)
- **Matrícula**: Público (identificador único)
- **Notas**: Públicas (mas apenas suas próprias notas)

#### 👨‍🏫 Professor
- **Endereço**: Endereço da carteira Ethereum
- **Disciplinas**: Lista de disciplinas que leciona

#### 📚 Disciplina
- **Nome**: Nome da disciplina
- **Professor**: Endereço do professor responsável
- **Alunos**: Lista de alunos matriculados

#### 📊 Nota
- **Disciplina**: ID da disciplina
- **Aluno**: Matrícula do aluno
- **Valor**: Nota (multiplicada por 100 para evitar decimais)

## 🔒 Regras de Negócio

1. **Um professor por disciplina**: Cada disciplina tem apenas um professor responsável
2. **Múltiplos alunos por disciplina**: Uma disciplina pode ter vários alunos matriculados
3. **Acesso às notas**: Alunos só podem ver suas próprias notas
4. **Lançamento de notas**: Apenas professores podem lançar e alterar notas
5. **Segurança**: Validações de permissão em todas as operações críticas

## 📁 Estrutura de Arquivos

```
CRID_PA_2025.1/
├── contracts/
│   ├── crid.sol                      # Contrato principal do sistema
│   ├── TesteSistemaNotas.sol         # Contrato de testes
│   └── ExemploUltraSimplificado.sol  # Exemplo para Remix
├── scripts/
│   ├── deploy.js                     # Script de deploy local
│   ├── deploy-testnet.js             # Script de deploy em testnet
│   ├── deploy-remix.js               # Script de deploy no Remix
│   └── check-contract-size.js        # Verificação de tamanho
├── README.md                         # Documentação do projeto
├── MANUAL.md                         # Manual de instruções
├── GUIA-REMIX.md                     # Guia para uso no Remix
├── RESUMO.md                         # Resumo do sistema
├── COMANDOS.md                       # Lista de comandos úteis
└── CI-CD.md                          # Documentação do CI/CD
```

## 🚀 Funcionalidades

### Para Professores
- Registrar-se no sistema
- Criar disciplinas
- Matricular alunos em disciplinas
- Lançar notas para alunos
- Alterar notas existentes
- Consultar todas as notas de suas disciplinas
- Visualizar alunos matriculados

### Para Alunos
- Registrar-se no sistema com matrícula e nome
- Consultar suas próprias notas
- Verificar matrícula em disciplinas

### Para Administração
- Consultar informações de disciplinas
- Verificar estatísticas do sistema

## 🛠️ Tecnologias Utilizadas

- **Solidity ^0.8.0**: Linguagem para smart contracts
- **Ethereum**: Blockchain para deploy
- **OpenZeppelin**: Bibliotecas de segurança (se necessário)

## 📊 Eventos do Sistema

O contrato emite os seguintes eventos para rastreabilidade:

- `AlunoRegistrado`: Quando um aluno se registra
- `ProfessorRegistrado`: Quando um professor se registra
- `DisciplinaCriada`: Quando uma disciplina é criada
- `AlunoMatriculado`: Quando um aluno é matriculado
- `NotaLancada`: Quando uma nota é lançada
- `NotaAlterada`: Quando uma nota é alterada

## 🔐 Segurança

### Modificadores Implementados

- `apenasAluno`: Verifica se é um aluno válido
- `apenasProfessor`: Verifica se é um professor registrado
- `apenasProfessorDaDisciplina`: Verifica se é o professor da disciplina específica
- `disciplinaExiste`: Verifica se a disciplina existe

### Validações

- Verificação de existência de entidades
- Validação de permissões
- Prevenção de duplicatas
- Validação de valores de notas (0-10)

## 🧪 Testes

O arquivo `TesteSistemaNotas.sol` inclui testes abrangentes para:

- Registro de alunos e professores
- Criação de disciplinas
- Matrícula de alunos
- Lançamento e alteração de notas
- Consultas diversas
- Validação de permissões
- Cenários completos de uso

## 💡 Como Usar

1. **Deploy**: Faça o deploy do contrato `SistemaNotas`
2. **Registro**: Professores e alunos devem se registrar
3. **Criação**: Professores criam disciplinas
4. **Matrícula**: Professores matriculam alunos
5. **Notas**: Professores lançam e gerenciam notas
6. **Consulta**: Usuários consultam informações permitidas

## 📈 Melhorias Futuras

- Interface web para interação
- Sistema de múltiplas notas por disciplina
- Histórico de alterações
- Sistema de aprovação/reprovação automático
- Integração com tokens para incentivos
- Dashboard para análise de desempenho

## 🤝 Contribuições

Este é um projeto acadêmico desenvolvido para demonstrar conceitos de blockchain e smart contracts aplicados a sistemas educacionais.

## 📄 Licença

MIT License - Veja o arquivo de licença para detalhes.

---

**Desenvolvido para:** Programação Avançada - 2025.1  
**Tecnologia:** Solidity, Ethereum, Smart Contracts
