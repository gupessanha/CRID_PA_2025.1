# Manual de Instruções - Sistema de Notas

## 📋 Pré-requisitos

### Software Necessário

1. **Node.js** (versão 16 ou superior)
   - Download: https://nodejs.org/

2. **npm** ou **yarn** (gerenciador de pacotes)
   - Vem com Node.js

3. **Git** (para controle de versão)
   - Download: https://git-scm.com/

### Ferramentas de Desenvolvimento

#### Opção 1: Remix IDE (Recomendado para iniciantes)
- Acesse: https://remix.ethereum.org/
- Interface web, não requer instalação local

#### Opção 2: Hardhat (Para desenvolvimento avançado)
```bash
npm install --save-dev hardhat
```

#### Opção 3: Truffle (Alternativa ao Hardhat)
```bash
npm install -g truffle
```

## 🚀 Configuração do Ambiente

### 1. Clonando o Repositório

```bash
git clone <URL_DO_REPOSITORIO>
cd CRID_PA_2025.1
```

### 2. Usando Remix IDE (Método Mais Simples)

1. Acesse https://remix.ethereum.org/
2. Crie uma nova pasta chamada `SistemaNotas`
3. Faça upload dos arquivos:
   - `crid.sol`
   - `TesteSistemaNotas.sol`

### 3. Configuração Local com Hardhat

```bash
# Inicializar projeto Node.js
npm init -y

# Instalar Hardhat
npm install --save-dev hardhat

# Inicializar projeto Hardhat
npx hardhat

# Instalar dependências adicionais
npm install --save-dev @nomicfoundation/hardhat-toolbox
```

## 🔧 Compilação dos Contratos

### No Remix IDE

1. Vá para a aba "Solidity Compiler"
2. Selecione a versão do compilador: `0.8.0` ou superior
3. Clique em "Compile crid.sol"
4. Compile também "TesteSistemaNotas.sol"

### Com Hardhat

```bash
# Compilar contratos
npx hardhat compile
```

## 🚀 Deploy dos Contratos

### No Remix IDE

1. Vá para a aba "Deploy & Run Transactions"
2. Selecione o ambiente:
   - **JavaScript VM**: Para testes locais
   - **Injected Provider**: Para usar MetaMask
   - **Hardhat Provider**: Se estiver rodando Hardhat node

3. Selecione o contrato `SistemaNotas`
4. Clique em "Deploy"

### Com Hardhat (Local)

1. Criar arquivo `hardhat.config.js`:

```javascript
require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.19",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545"
    }
  }
};
```

2. Criar script de deploy `scripts/deploy.js`:

```javascript
async function main() {
  const SistemaNotas = await ethers.getContractFactory("SistemaNotas");
  const sistema = await SistemaNotas.deploy();
  await sistema.deployed();
  console.log("SistemaNotas deployed to:", sistema.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
```

3. Executar deploy:

```bash
# Iniciar node local
npx hardhat node

# Em outro terminal, fazer deploy
npx hardhat run scripts/deploy.js --network localhost
```

## 🧪 Executando os Testes

### No Remix IDE

1. Após fazer deploy do `SistemaNotas`, faça deploy do `TesteSistemaNotas`
2. No contrato `TesteSistemaNotas` deployado, execute as funções:
   - `executarTodosTestes()`: Executa todos os testes
   - `testeCompleto()`: Executa um cenário completo
   - `mostrarEstatisticas()`: Mostra estatísticas do sistema

### Com Hardhat

1. Criar arquivo de teste `test/SistemaNotas.test.js`:

```javascript
const { expect } = require("chai");

describe("SistemaNotas", function () {
  let sistemaNotas;
  let owner, professor, addr1, addr2;

  beforeEach(async function () {
    [owner, professor, addr1, addr2] = await ethers.getSigners();
    const SistemaNotas = await ethers.getContractFactory("SistemaNotas");
    sistemaNotas = await SistemaNotas.deploy();
    await sistemaNotas.deployed();
  });

  it("Deve registrar um aluno", async function () {
    await sistemaNotas.registrarAluno(12345, "João Silva");
    const aluno = await sistemaNotas.alunos(12345);
    expect(aluno.existe).to.be.true;
    expect(aluno.matricula).to.equal(12345);
  });

  // Adicionar mais testes...
});
```

2. Executar testes:

```bash
npx hardhat test
```

## 📝 Manual de Uso do Sistema

### 1. Registro de Professor

```solidity
// Chamar a função como professor
sistemaNotas.registrarProfessor()
```

**No Remix:**
1. Conecte sua carteira
2. Vá para o contrato deployado
3. Clique em "registrarProfessor"
4. Confirme a transação

### 2. Registro de Aluno

```solidity
// Parâmetros: matrícula, nome
sistemaNotas.registrarAluno(12345, "João Silva")
```

**No Remix:**
1. Expanda a função "registrarAluno"
2. Digite a matrícula: `12345`
3. Digite o nome: `"João Silva"`
4. Clique em "transact"

### 3. Criação de Disciplina

```solidity
// Apenas professores podem criar
sistemaNotas.criarDisciplina("Matemática")
```

**No Remix:**
1. Use a conta do professor
2. Expanda "criarDisciplina"
3. Digite o nome: `"Matemática"`
4. Execute a transação

### 4. Matrícula de Aluno

```solidity
// Parâmetros: ID da disciplina, matrícula do aluno
sistemaNotas.matricularAluno(1, 12345)
```

### 5. Lançamento de Nota

```solidity
// Parâmetros: ID disciplina, matrícula, nota (x100)
// Exemplo: nota 8.5 = 850
sistemaNotas.lancarNota(1, 12345, 850)
```

### 6. Consulta de Nota

```solidity
// Para testes (função simplificada)
sistemaNotas.consultarMinhaNotaTeste(1, 12345)
```

### 7. Consulta de Disciplinas do Professor

```solidity
sistemaNotas.consultarMinhasDisciplinas()
```

## 🔍 Monitoramento e Logs

### Eventos no Remix

1. Vá para a aba "Solidity Compiler"
2. Role para baixo até "Logs"
3. Observe os eventos emitidos após cada transação

### Eventos Importantes

- `AlunoRegistrado(matricula, endereco)`
- `ProfessorRegistrado(endereco)`
- `DisciplinaCriada(disciplinaId, nome, professor)`
- `NotaLancada(disciplinaId, matricula, nota)`

## 🐛 Troubleshooting

### Problemas Comuns

1. **"Aluno ja registrado"**
   - Solução: Use uma matrícula diferente

2. **"Apenas professores podem executar esta acao"**
   - Solução: Registre-se como professor primeiro

3. **"Aluno nao esta matriculado nesta disciplina"**
   - Solução: Matricule o aluno na disciplina antes de lançar nota

4. **"Nota deve ser entre 0 e 10 (1000)"**
   - Solução: Use valores entre 0 e 1000 (representando 0.0 a 10.0)

### Verificações de Debug

```solidity
// Verificar se aluno existe
sistemaNotas.alunos(matricula)

// Verificar se professor existe
sistemaNotas.professores(endereco)

// Verificar se disciplina existe
sistemaNotas.disciplinas(disciplinaId)

// Verificar se aluno está matriculado
sistemaNotas.alunoEstaMatriculado(disciplinaId, matricula)
```

## 📊 Exemplo Completo de Uso

### Cenário: Professor de Matemática

```javascript
// 1. Registrar como professor
await sistemaNotas.registrarProfessor();

// 2. Criar disciplina
await sistemaNotas.criarDisciplina("Cálculo I");

// 3. Registrar alunos (cada um chama para si)
await sistemaNotas.registrarAluno(2023001, "Ana Silva");
await sistemaNotas.registrarAluno(2023002, "Bruno Costa");

// 4. Matricular alunos (professor faz)
await sistemaNotas.matricularAluno(1, 2023001);
await sistemaNotas.matricularAluno(1, 2023002);

// 5. Lançar notas (professor faz)
await sistemaNotas.lancarNota(1, 2023001, 850); // 8.5
await sistemaNotas.lancarNota(1, 2023002, 920); // 9.2

// 6. Consultar notas da disciplina
const [matriculas, notas] = await sistemaNotas.consultarNotasDaDisciplina(1);
console.log("Matrículas:", matriculas);
console.log("Notas:", notas);
```

## 💰 Custos de Gas

### Estimativas (podem variar)

- Registro de aluno: ~50,000 gas
- Registro de professor: ~45,000 gas
- Criação de disciplina: ~80,000 gas
- Matrícula de aluno: ~65,000 gas
- Lançamento de nota: ~70,000 gas
- Consultas (view): ~0 gas

## 🔒 Segurança

### Boas Práticas

1. **Sempre validar dados** antes de enviar transações
2. **Usar contas separadas** para professor e alunos
3. **Verificar permissões** antes de executar funções
4. **Monitorar eventos** para auditoria
5. **Testar em rede local** antes de deploy em mainnet

## 📞 Suporte

Para dúvidas sobre o código ou problemas de execução:

1. Verifique os logs de erro no console
2. Consulte a documentação do Solidity
3. Use o debug do Remix para step-by-step
4. Verifique os eventos emitidos para entender o fluxo

---

**Nota:** Este manual assume conhecimento básico de blockchain e Ethereum. Para usuários iniciantes, recomenda-se começar com tutoriais básicos de Solidity e MetaMask.
