# Guia Rápido de Comandos

## 🚀 Configuração Inicial

```bash
# Instalar dependências
npm install

# Copiar arquivo de ambiente
copy .env.example .env
# Editar .env com suas configurações
```

## 🔧 Comandos de Desenvolvimento

```bash
# Compilar contratos
npm run compile

# Executar testes
npm run test

# Iniciar node local
npm run node

# Deploy em rede local (em outro terminal)
npm run deploy:local

# Limpar cache e artifacts
npm run clean
```

## 📊 Comandos de Análise

```bash
# Relatório de uso de gas
REPORT_GAS=true npm run test

# Tamanho dos contratos
npm run size
```

## 🌐 Deploy em Redes de Teste

```bash
# Deploy na Sepolia testnet
npm run deploy:testnet

# Console interativo
npm run console --network localhost
```

## 🧪 Testando os Contratos

### No Remix IDE
1. Vá para https://remix.ethereum.org/
2. Faça upload dos arquivos .sol
3. Compile os contratos
4. Deploy e teste as funções

### Com Hardhat
```bash
# Executar todos os testes
npx hardhat test

# Executar teste específico
npx hardhat test --grep "registrar aluno"

# Executar com relatório de gas
REPORT_GAS=true npx hardhat test
```

## 📝 Interagindo com Contratos Deployados

### Via Console do Hardhat
```javascript
// Conectar ao contrato
const sistemaNotas = await ethers.getContractAt("SistemaNotas", "CONTRACT_ADDRESS");

// Registrar professor
await sistemaNotas.registrarProfessor();

// Registrar aluno
await sistemaNotas.registrarAluno(12345, "João Silva");

// Criar disciplina
await sistemaNotas.criarDisciplina("Matemática");

// Matricular aluno
await sistemaNotas.matricularAluno(1, 12345);

// Lançar nota
await sistemaNotas.lancarNota(1, 12345, 850); // Nota 8.5
```

## 🔍 Comandos de Debug

```bash
# Verificar compilação
npx hardhat check

# Ver contas disponíveis
npx hardhat accounts

# Ver informações da rede
npx hardhat run scripts/network-info.js
```

## 📦 Comandos do NPM

```bash
# Instalar nova dependência
npm install --save-dev package-name

# Atualizar dependências
npm update

# Auditoria de segurança
npm audit

# Corrigir vulnerabilidades
npm audit fix
```

## 🚨 Troubleshooting

### Problema: "Error: cannot estimate gas"
```bash
# Verificar se o node está rodando
npm run node

# Verificar se os contratos foram compilados
npm run compile
```

### Problema: "Module not found"
```bash
# Reinstalar dependências
rm -rf node_modules package-lock.json
npm install
```

### Problema: "Invalid nonce"
```bash
# Resetar conta do MetaMask
# Settings > Advanced > Reset Account
```

## 📚 Comandos de Documentação

```bash
# Gerar documentação dos contratos
npx hardhat docgen

# Gerar relatório de cobertura
npm run coverage
open coverage/index.html
```

## 🎯 Comandos Essenciais para Demo

```bash
# Setup completo
npm install && npm run compile

# Demo local
npm run node
# Em outro terminal:
npm run deploy:local

# Testar tudo
npm run test
```

## 📋 Checklist de Deploy

- [ ] Contratos compilados sem erro
- [ ] Testes passando 100%
- [ ] Arquivo .env configurado
- [ ] Gas limit adequado
- [ ] Rede correta selecionada
- [ ] Saldo suficiente para deploy
- [ ] Backup da chave privada

## 🔗 Links Úteis

- [Documentação Hardhat](https://hardhat.org/docs)
- [Solidity Docs](https://docs.soliditylang.org/)
- [OpenZeppelin](https://docs.openzeppelin.com/)
- [Remix IDE](https://remix.ethereum.org/)
- [Etherscan](https://etherscan.io/)
- [MetaMask](https://metamask.io/)

## 💡 Dicas Importantes

1. **Sempre teste localmente** antes de deploy em testnet
2. **Use contas de teste** para desenvolvimento
3. **Mantenha suas chaves privadas seguras**
4. **Faça backup dos endereços dos contratos**
5. **Documente alterações importantes**
6. **Use controle de versão** (git)

---

Para mais detalhes, consulte o `README.md` e `MANUAL.md`.
