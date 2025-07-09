const hre = require("hardhat");

async function main() {
  console.log("🚀 Iniciando deploy do Sistema de Notas...\n");

  // Obter signers
  const [deployer] = await hre.ethers.getSigners();
  console.log("📝 Deploy sendo feito com a conta:", deployer.address);
  console.log("💰 Saldo da conta:", (await hre.ethers.provider.getBalance(deployer.address)).toString(), "wei\n");

  // Deploy do contrato principal
  console.log("📚 Fazendo deploy do contrato SistemaNotas...");
  const SistemaNotas = await hre.ethers.getContractFactory("SistemaNotas");
  const sistemaNotas = await SistemaNotas.deploy();
  // Na versão 6 do ethers, não usamos mais .deployed()
  const sistemaNotasDeployment = await sistemaNotas.waitForDeployment();
  const sistemaNotasAddress = await sistemaNotas.getAddress();
  console.log("✅ SistemaNotas deployado em:", sistemaNotasAddress);

  // Deploy do contrato de testes
  console.log("\n🧪 Fazendo deploy do contrato TesteSistemaNotas...");
  const TesteSistemaNotas = await hre.ethers.getContractFactory("TesteSistemaNotas");
  const testeSistema = await TesteSistemaNotas.deploy();
  // Na versão 6 do ethers, não usamos mais .deployed()
  await testeSistema.waitForDeployment();
  const testeSistemaAddress = await testeSistema.getAddress();
  console.log("✅ TesteSistemaNotas deployado em:", testeSistemaAddress);

  // Deploy do exemplo ultra simplificado
  console.log("\n📋 Fazendo deploy do contrato ExemploUltraSimples...");
  const ExemploUltraSimples = await hre.ethers.getContractFactory("ExemploUltraSimples");
  const exemploUltraSimples = await ExemploUltraSimples.deploy();
  // Na versão 6 do ethers, não usamos mais .deployed()
  await exemploUltraSimples.waitForDeployment();
  const exemploUltraSimpleAddress = await exemploUltraSimples.getAddress();
  console.log("✅ ExemploUltraSimples deployado em:", exemploUltraSimpleAddress);

  // Salvar endereços em um arquivo JSON
  const deployInfo = {
    network: hre.network.name,
    deployer: deployer.address,
    contracts: {
      SistemaNotas: sistemaNotasAddress,
      TesteSistemaNotas: testeSistemaAddress,
      ExemploUltraSimples: exemploUltraSimpleAddress
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
  
  try {
    // Usar a nova função para salvar os contratos no formato estruturado
    const { saveDeployedContracts } = require('./utils');
    await saveDeployedContracts(deployInfo.contracts);
    console.log("\n📄 Informações de deploy salvas em deployed-contracts.json e na pasta deployments");
  } catch (error) {
    console.log("\n📄 Informações de deploy salvas em deployed-contracts.json");
    console.log("⚠️ Aviso: Não foi possível salvar na pasta deployments:", error.message);
  }

  // Verificar contratos se estivermos em uma testnet
  if (hre.network.name !== "localhost" && hre.network.name !== "hardhat") {
    console.log("\n🔍 Aguardando confirmações para verificação...");
    // Aguardar para garantir que o contrato está no blockchain
    await new Promise(resolve => setTimeout(resolve, 30000)); // Aguarda 30 segundos
    
    try {
      await hre.run("verify:verify", {
        address: sistemaNotasAddress,
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
  .then(() => {
    // Execute os testes após o deploy bem-sucedido
    console.log("\n🧪 Executando testes automaticamente...");
    require('./run-test');
  })
  .catch((error) => {
    console.error("❌ Erro durante o deploy:", error);
    process.exit(1);
  });
