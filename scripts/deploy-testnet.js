const hre = require("hardhat");
const fs = require('fs');

async function main() {
  console.log("Iniciando deploy na rede Sepolia...");

  // Deploy do contrato principal SistemaNotas
  const SistemaNotas = await hre.ethers.getContractFactory("SistemaNotas");
  const sistema = await SistemaNotas.deploy();
  await sistema.waitForDeployment();
  
  const sistemaAddress = await sistema.getAddress();
  console.log(`SistemaNotas implantado em: ${sistemaAddress}`);
  
  // Guardar endereço para verificação posterior
  const deployInfo = {
    network: hre.network.name,
    timestamp: new Date().toISOString(),
    SistemaNotas: sistemaAddress
  };
  
  // Criar diretório para resultados se não existir
  if (!fs.existsSync('./test-results')) {
    fs.mkdirSync('./test-results', { recursive: true });
  }
  
  // Salvar informações de deploy
  fs.writeFileSync(
    './test-results/deploy-addresses.json',
    JSON.stringify(deployInfo, null, 2)
  );
  
  console.log("Informações de deploy salvas em ./test-results/deploy-addresses.json");
  
  // Verificação de contrato no Etherscan (se estiver em uma rede pública)
  if (hre.network.name !== "hardhat" && hre.network.name !== "localhost") {
    console.log("Aguardando 30 segundos antes de verificar o contrato...");
    await new Promise(resolve => setTimeout(resolve, 30000)); // Espera 30 segundos
    
    console.log("Verificando contrato no Etherscan...");
    try {
      await hre.run("verify:verify", {
        address: sistemaAddress,
        constructorArguments: []
      });
      console.log("Verificação concluída com sucesso!");
    } catch (error) {
      console.log("Erro na verificação:", error.message);
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Erro no deploy:", error);
    process.exit(1);
  });