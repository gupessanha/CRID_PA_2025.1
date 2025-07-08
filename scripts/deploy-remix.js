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

  // Deploy do exemplo ultra simplificado
  console.log("\n📋 Fazendo deploy do contrato ExemploUltraSimplificado...");
  const ExemploUltraSimplificadoFactory = await ethers.getContractFactory("ExemploUltraSimplificado");
  const ExemploUltraSimplificado = await ExemploUltraSimplificadoFactory.deploy();
  await ExemploUltraSimplificado.deployed();
  console.log("✅ ExemploUltraSimplificado deployado em:", ExemploUltraSimplificado.address);

  // Informações de deploy
  console.log("\n📄 Resumo do Deploy:");
  console.log("=====================================");
  console.log("SistemaNotas:", sistemaNotas.address);
  console.log("TesteSistemaNotas:", testeSistema.address);
  console.log("ExemploUltraSimplificado:", ExemploUltraSimplificado.address);
  console.log("=====================================");

  console.log("\n🎉 Deploy concluído com sucesso!");
  console.log("🔗 Para interagir com os contratos, use os endereços acima");
  console.log("📚 Consulte o README.md e MANUAL.md para instruções de uso");

  return {
    sistemaNotas: sistemaNotas.address,
    testeSistema: testeSistema.address,
    ExemploUltraSimplificado: ExemploUltraSimplificado.address
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
