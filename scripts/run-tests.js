const hre = require("hardhat");

// Adicione esta linha no início do arquivo
const fs = require('fs');

async function main() {
  console.log("Implantando contrato de testes TesteSistemaNotas...");
  
  // Deploy do contrato de testes (sintaxe atualizada para versões mais recentes do ethers)
  const TesteSistemaNotas = await hre.ethers.getContractFactory("TesteSistemaNotas");
  const testeSistema = await TesteSistemaNotas.deploy();
  
  // Esperar que o contrato seja minerado (nova forma de aguardar deploy)
  await testeSistema.waitForDeployment();
  
  // Obter o endereço do contrato
  const testeSistemaAddress = await testeSistema.getAddress();
  console.log(`TesteSistemaNotas implantado no endereço: ${testeSistemaAddress}`);
  
  // Executar todos os testes
  console.log("\nExecutando todos os testes...");
  console.log("Isso pode levar algum tempo, pois são vários testes completos...");
  const tx = await testeSistema.executarTodosTestes();
  const receipt = await tx.wait();
  
  // Analisar e exibir resultados
  console.log("\n=== RESULTADOS DOS TESTES ===");
  
  let passou = 0;
  let falhou = 0;
  let logs = [];
  
  for (const event of receipt.logs) {
    // Tentativa de decodificar o evento
    try {
      const parsedLog = TesteSistemaNotas.interface.parseLog(event);
      
      if (parsedLog && parsedLog.name === "TesteExecutado") {
        const nome = parsedLog.args[0];
        const resultado = parsedLog.args[1];
        
        console.log(`${resultado ? "✅ PASSOU" : "❌ FALHOU"}: ${nome}`);
        resultado ? passou++ : falhou++;
      }
      else if (parsedLog && parsedLog.name === "LogTeste") {
        logs.push(parsedLog.args[0]);
      }
    } catch (error) {
      // Ignora logs que não consegue decodificar
      continue;
    }
  }
  
  // Exibir logs detalhados
  console.log("\n=== LOGS DETALHADOS ===");
  logs.forEach((log, index) => {
    console.log(`${index + 1}. ${log}`);
  });
  
  // Resultado final
  console.log("\n=== RESUMO FINAL ===");
  console.log(`Total de testes: ${passou + falhou}`);
  console.log(`Testes que passaram: ${passou}`);
  console.log(`Testes que falharam: ${falhou}`);
  
  if (falhou === 0) {
    console.log("\n✅ TODOS OS TESTES PASSARAM! O sistema está funcionando conforme esperado.");
  } else {
    console.log(`\n❌ ATENÇÃO: ${falhou} teste(s) falhou(ram). Verifique os logs acima para mais detalhes.`);
  }
  
  // Exibir estatísticas do sistema (se disponível)
  try {
    const estatisticas = await testeSistema.mostrarEstatisticas();
    console.log("\n=== ESTATÍSTICAS DO SISTEMA ===");
    console.log(`Próximo ID de disciplina: ${estatisticas[0].toString()}`);
    console.log(`Informações adicionais: ${estatisticas[1]}`);
  } catch (error) {
    console.log("\nNão foi possível obter estatísticas adicionais do sistema.");
    console.log("Erro:", error.message);
  }

  // Criar diretório para resultados se não existir
  if (!fs.existsSync('./test-results')) {
    fs.mkdirSync('./test-results', { recursive: true });
  }

  // Criar objeto com resultados dos testes
  const testResults = {
    timestamp: new Date().toISOString(),
    contractAddress: testeSistemaAddress,
    summary: {
      total: passou + falhou,
      passed: passou,
      failed: falhou
    },
    tests: logs.map((log, index) => ({ id: index + 1, message: log }))
  };

  // Salvar resultados em JSON para o relatório do CI
  fs.writeFileSync(
    './test-results/solidity-test-results.json',
    JSON.stringify(testResults, null, 2)
  );

  console.log("\nResultados salvos em ./test-results/solidity-test-results.json");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Erro durante a execução dos testes:");
    console.error(error);
    process.exit(1);
  });