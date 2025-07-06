// SPDX-License-Identifier: MIT
// Script de Deploy Simplificado para Remix IDE

async function main() {
  console.log("🚀 Iniciando deploy do Sistema de Notas no Remix...\n");

  // Deploy do contrato principal
  console.log("📚 Fazendo deploy do contrato SistemaNotas...");
  const SistemaNotas = await ethers.getContractFactory("SistemaNotas");
  const sistemaNotas = await SistemaNotas.deploy();
  await sistemaNotas.deployed();
  console.log("✅ SistemaNotas deployado em:", sistemaNotas.address);

  // Deploy do contrato de testes
  console.log("\n🧪 Fazendo deploy do contrato TesteSistemaNotas...");
  const TesteSistemaNotas = await ethers.getContractFactory("TesteSistemaNotas");
  const testeSistema = await TesteSistemaNotas.deploy();
  await testeSistema.deployed();
  console.log("✅ TesteSistemaNotas deployado em:", testeSistema.address);

  // Deploy do exemplo prático
  console.log("\n📋 Fazendo deploy do contrato ExemploPraticoSistema...");
  const ExemploPraticoSistema = await ethers.getContractFactory("ExemploPraticoSistema");
  const exemploSistema = await ExemploPraticoSistema.deploy();
  await exemploSistema.deployed();
  console.log("✅ ExemploPraticoSistema deployado em:", exemploSistema.address);

  // Informações de deploy
  console.log("\n📄 Resumo do Deploy:");
  console.log("=====================================");
  console.log("SistemaNotas:", sistemaNotas.address);
  console.log("TesteSistemaNotas:", testeSistema.address);
  console.log("ExemploPraticoSistema:", exemploSistema.address);
  console.log("=====================================");

  console.log("\n🎉 Deploy concluído com sucesso!");
  console.log("🔗 Para interagir com os contratos, use os endereços acima");
  console.log("📚 Consulte o README.md e MANUAL.md para instruções de uso");

  return {
    sistemaNotas: sistemaNotas.address,
    testeSistema: testeSistema.address,
    exemploSistema: exemploSistema.address
  };
}

main()
  .then((addresses) => {
    console.log("\n✅ Deploy finalizado com sucesso!");
    console.log("📋 Endereços dos contratos:", addresses);
  })
  .catch((error) => {
    console.error("❌ Erro durante o deploy:", error.message);
    console.error("Stack trace:", error.stack);
  });
