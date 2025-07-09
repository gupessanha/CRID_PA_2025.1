const fs = require('fs');
const path = require('path');

async function main() {
  console.log("Verificando tamanho dos contratos compilados...");
  
  // Diretório onde os artefatos compilados estão armazenados
  const artifactsDir = path.join(__dirname, '../artifacts/contracts');
  
  if (!fs.existsSync(artifactsDir)) {
    console.log("Diretório de artefatos não encontrado. Compile os contratos primeiro.");
    return;
  }
  
  const contracts = [];
  
  // Função para buscar arquivos .json recursivamente
  function findJsonFiles(dir) {
    const files = fs.readdirSync(dir, { withFileTypes: true });
    
    for (const file of files) {
      const filePath = path.join(dir, file.name);
      
      if (file.isDirectory()) {
        findJsonFiles(filePath);
      } else if (file.name.endsWith('.json') && !file.name.endsWith('.dbg.json')) {
        try {
          const content = JSON.parse(fs.readFileSync(filePath, 'utf8'));
          
          // Verificar se é um artefato de contrato com bytecode
          if (content.bytecode && content.contractName) {
            // Remover prefixo '0x' e calcular em bytes (2 caracteres hex = 1 byte)
            const bytecodeSize = (content.bytecode.startsWith('0x') ? 
              content.bytecode.slice(2).length : 
              content.bytecode.length) / 2;
            
            contracts.push({
              name: content.contractName,
              size: bytecodeSize,
              path: filePath.replace(artifactsDir, '').replace(/\\/g, '/').replace('.json', '.sol')
            });
          }
        } catch (e) {
          console.error(`Erro ao processar ${filePath}:`, e.message);
        }
      }
    }
  }
  
  findJsonFiles(artifactsDir);
  
  // Ordenar por tamanho (do maior para o menor)
  contracts.sort((a, b) => b.size - a.size);
  
  console.log("\n=== TAMANHO DOS CONTRATOS ===");
  console.log("Limite de deploy no Ethereum: 24.576 bytes\n");
  
  // Exibir resultados
  const maxNameLength = Math.max(...contracts.map(c => c.name.length));
  
  for (const contract of contracts) {
    const sizePercentage = (contract.size / 24576) * 100;
    const sizeStr = contract.size.toLocaleString() + " bytes";
    const percentStr = sizePercentage.toFixed(2) + "%";
    
    let status = "✅ OK";
    if (sizePercentage > 100) {
      status = "❌ EXCEDE LIMITE";
    } else if (sizePercentage > 90) {
      status = "⚠️ PRÓXIMO AO LIMITE";
    }
    
    console.log(`${contract.name.padEnd(maxNameLength + 2)}${sizeStr.padEnd(15)}${percentStr.padEnd(10)}${status}`);
  }
  
  // Salvar relatório para o CI
  if (!fs.existsSync('./test-results')) {
    fs.mkdirSync('./test-results', { recursive: true });
  }
  
  fs.writeFileSync(
    './test-results/contract-sizes.json',
    JSON.stringify({
      timestamp: new Date().toISOString(),
      contractSizes: contracts,
      maxSize: 24576
    }, null, 2)
  );
  
  console.log("\nRelatório de tamanhos salvo em ./test-results/contract-sizes.json");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Erro ao verificar tamanho dos contratos:", error);
    process.exit(1);
  });