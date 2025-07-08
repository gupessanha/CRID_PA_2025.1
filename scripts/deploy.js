const hre = require("hardhat");

async function main() {
  console.log("🚀 Iniciando deploy do Sistema de Notas...\n");

  // Obter signers
  const [deployer] = await hre.ethers.getSigners();
  console.log("📝 Deploy sendo feito com a conta:", deployer.address);
  console.log("💰 Saldo da conta:", (await deployer.getBalance()).toString(), "wei\n");

  // Deploy do contrato principal
  console.log("📚 Fazendo deploy do contrato SistemaNotas...");
  const SistemaNotas = await hre.ethers.getContractFactory("SistemaNotas");
  const sistemaNotas = await SistemaNotas.deploy();
  await sistemaNotas.deployed();
  console.log("✅ SistemaNotas deployado em:", sistemaNotas.address);

  // Deploy do contrato de testes
  console.log("\n🧪 Fazendo deploy do contrato TesteSistemaNotas...");
  const TesteSistemaNotas = await hre.ethers.getContractFactory("TesteSistemaNotas");
  const testeSistema = await TesteSistemaNotas.deploy();
  await testeSistema.deployed();
  console.log("✅ TesteSistemaNotas deployado em:", testeSistema.address);

  // Deploy do exemplo prático
  console.log("\n📋 Fazendo deploy do contrato ExemploPraticoSistema...");
  const ExemploPraticoSistema = await hre.ethers.getContractFactory("ExemploPraticoSistema");
  const exemploSistema = await ExemploPraticoSistema.deploy();
  await exemploSistema.deployed();
  console.log("✅ ExemploPraticoSistema deployado em:", exemploSistema.address);

  // Salvar endereços em um arquivo JSON
  const deployInfo = {
    network: hre.network.name,
    deployer: deployer.address,
    contracts: {
      SistemaNotas: sistemaNotas.address,
      TesteSistemaNotas: testeSistema.address,
      ExemploPraticoSistema: exemploSistema.address
    },
    deployedAt: new Date().toISOString(),
    blockNumber: await hre.ethers.provider.getBlockNumber()
  };

  // Salvar em deployed-contracts.json para retrocompatibilidade
  const fs = require('fs');
  fs.writeFileSync(
    'deployed-contracts.json', 
    JSON.stringify(deployInfo, null, 2)
  );
  
  // Usar a nova função para salvar os contratos no formato estruturado
  const { saveDeployedContracts } = require('./utils');
  await saveDeployedContracts(deployInfo.contracts);

  console.log("\n📄 Informações de deploy salvas em deployed-contracts.json e na pasta deployments");

  // Verificar contratos se estivermos em uma testnet
  if (hre.network.name !== "localhost" && hre.network.name !== "hardhat") {
    console.log("\n🔍 Aguardando confirmações para verificação...");
    await sistemaNotas.deployTransaction.wait(5);
    
    try {
      await hre.run("verify:verify", {
        address: sistemaNotas.address,
        constructorArguments: [],
      });
      console.log("✅ SistemaNotas verificado no Etherscan");
    } catch (error) {
      console.log("❌ Erro na verificação:", error.message);
    }
  }

  console.log("\n🎉 Deploy concluído com sucesso!");
  console.log("🔗 Para interagir com os contratos, use os endereços acima");
  console.log("📚 Consulte o README.md e MANUAL.md para instruções de uso");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Erro durante o deploy:", error);
    process.exit(1);
  });
