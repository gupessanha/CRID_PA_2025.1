const fs = require('fs');
const path = require('path');

// Função para salvar os endereços dos contratos deployados
async function saveDeployedContracts(deployedContracts) {
  const deployData = {
    timestamp: new Date().toISOString(),
    network: process.env.HARDHAT_NETWORK || 'unknown',
    contracts: deployedContracts
  };

  // Criar diretório se não existir
  const deployDir = path.join(__dirname, '../deployments');
  if (!fs.existsSync(deployDir)) {
    fs.mkdirSync(deployDir);
  }

  const networkDir = path.join(deployDir, deployData.network);
  if (!fs.existsSync(networkDir)) {
    fs.mkdirSync(networkDir);
  }

  // Salvar o arquivo de deploy com timestamp
  const fileName = `deploy-${Date.now()}.json`;
  const filePath = path.join(networkDir, fileName);
  
  fs.writeFileSync(
    filePath,
    JSON.stringify(deployData, null, 2)
  );

  // Atualizar o arquivo latest.json
  const latestPath = path.join(networkDir, 'latest.json');
  fs.writeFileSync(
    latestPath,
    JSON.stringify(deployData, null, 2)
  );
  
  console.log(`📝 Deploy info salvo em ${filePath}`);
}

module.exports = {
  saveDeployedContracts
};
