// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./crid.sol";

/**
 * @title Exemplo Ultra Simples do Sistema de Notas
 * @dev Versão minimalista para máxima compatibilidade com Remix
 */
contract ExemploUltraSimples {
    SistemaNotas public sistema;
    
    // Eventos
    event Resultado(string mensagem);
    
    constructor() {
        sistema = new SistemaNotas();
    }
    
    /**
     * @dev Executa um teste básico completo
     */
    function testeBasico() external {
        // 1. Registrar professor
        sistema.registrarProfessor();
        emit Resultado("1. Professor registrado");
        
        // 2. Criar disciplina
        sistema.criarDisciplina("Matematica");
        emit Resultado("2. Disciplina criada");
        
        // 3. Registrar aluno
        sistema.registrarAluno(12345, "Joao Silva");
        emit Resultado("3. Aluno registrado");
        
        // 4. Matricular aluno
        sistema.matricularAluno(1, 12345);
        emit Resultado("4. Aluno matriculado");
        
        // 5. Lançar nota
        sistema.lancarNota(1, 12345, 850); // 8.5
        emit Resultado("5. Nota lancada");
        
        emit Resultado("SUCESSO: Teste basico completo!");
    }
    
    /**
     * @dev Registra apenas um professor
     */
    function registrarProfessor() external {
        sistema.registrarProfessor();
        emit Resultado("Professor registrado com sucesso");
    }
    
    /**
     * @dev Registra apenas um aluno
     */
    function registrarAluno() external {
        sistema.registrarAluno(99999, "Aluno Teste");
        emit Resultado("Aluno registrado com sucesso");
    }
    
    /**
     * @dev Cria apenas uma disciplina
     */
    function criarDisciplina() external {
        sistema.criarDisciplina("Teste Disciplina");
        emit Resultado("Disciplina criada com sucesso");
    }
    
    /**
     * @dev Consulta uma nota
     */
    function consultarNota() external view returns (uint256, bool) {
        return sistema.consultarMinhaNotaTeste(1, 12345);
    }
    
    /**
     * @dev Consulta próximo ID de disciplina
     */
    function consultarProximoId() external view returns (uint256) {
        return sistema.proximoDisciplinaId();
    }
    
    /**
     * @dev Verifica se aluno está matriculado
     */
    function verificarMatricula() external view returns (bool) {
        return sistema.alunoEstaMatriculado(1, 12345);
    }
    
    /**
     * @dev Instruções de uso
     */
    function instrucoes() external pure returns (string memory) {
        return "Execute: testeBasico() para teste completo ou funcoes individuais";
    }
    
    /**
     * @dev Executa teste com logs detalhados para análise
     */
    function testeComDetalhes() external {
        emit Resultado("=== INICIANDO TESTE DETALHADO ===");
        
        // 1. Registrar professor
        emit Resultado("ETAPA 1: Registrando professor...");
        sistema.registrarProfessor();
        emit Resultado("-> Professor registrado com endereco: msg.sender");
        emit Resultado("-> Professor agora pode criar disciplinas");
        
        // 2. Criar disciplina
        emit Resultado("ETAPA 2: Criando disciplina...");
        sistema.criarDisciplina("Matematica Avancada");
        emit Resultado("-> Disciplina 'Matematica Avancada' criada com ID: 1");
        emit Resultado("-> Professor vinculado a disciplina ID: 1");
        
        // 3. Registrar aluno
        emit Resultado("ETAPA 3: Registrando aluno...");
        sistema.registrarAluno(12345, "Joao Silva Santos");
        emit Resultado("-> Aluno registrado: Matricula 12345");
        emit Resultado("-> Nome privado: 'Joao Silva Santos'");
        emit Resultado("-> Aluno pode ser matriculado em disciplinas");
        
        // 4. Matricular aluno
        emit Resultado("ETAPA 4: Matriculando aluno na disciplina...");
        sistema.matricularAluno(1, 12345);
        emit Resultado("-> Aluno 12345 matriculado na disciplina ID: 1");
        emit Resultado("-> Professor pode lancar notas para este aluno");
        
        // 5. Verificar matrícula
        emit Resultado("ETAPA 5: Verificando matricula...");
        bool matriculado = sistema.alunoEstaMatriculado(1, 12345);
        if (matriculado) {
            emit Resultado("-> CONFIRMADO: Aluno esta matriculado");
        } else {
            emit Resultado("-> ERRO: Aluno NAO esta matriculado");
        }
        
        // 6. Lançar nota
        emit Resultado("ETAPA 6: Lancando nota...");
        sistema.lancarNota(1, 12345, 875); // 8.75
        emit Resultado("-> Nota 8.75 (875/100) lancada para aluno 12345");
        emit Resultado("-> Nota armazenada na disciplina ID: 1");
        
        // 7. Consultar nota
        emit Resultado("ETAPA 7: Consultando nota lancada...");
        (uint256 nota, bool existe) = sistema.consultarMinhaNotaTeste(1, 12345);
        if (existe) {
            emit Resultado("-> Nota encontrada: 875 (equivale a 8.75)");
        } else {
            emit Resultado("-> ERRO: Nota nao encontrada");
        }
        
        emit Resultado("=== TESTE DETALHADO CONCLUIDO COM SUCESSO ===");
    }
    
    /**
     * @dev Mostra o estado atual do sistema
     */
    function verificarEstadoSistema() external {
        emit Resultado("=== ESTADO ATUAL DO SISTEMA ===");
        
        // Verificar próximo ID de disciplina
        uint256 proximoId = sistema.proximoDisciplinaId();
        emit Resultado(string(abi.encodePacked("Proxima disciplina tera ID: ", uint2str(proximoId))));
        
        // Verificar se aluno está matriculado
        bool matriculado = sistema.alunoEstaMatriculado(1, 12345);
        if (matriculado) {
            emit Resultado("Aluno 12345 ESTA matriculado na disciplina 1");
        } else {
            emit Resultado("Aluno 12345 NAO esta matriculado na disciplina 1");
        }
        
        // Verificar nota do aluno
        (uint256 nota, bool existe) = sistema.consultarMinhaNotaTeste(1, 12345);
        if (existe) {
            emit Resultado(string(abi.encodePacked("Nota do aluno 12345: ", uint2str(nota), " (", uint2str(nota/100), ".", uint2str(nota%100), ")")));
        } else {
            emit Resultado("Aluno 12345 ainda nao tem nota na disciplina 1");
        }
        
        emit Resultado("=== FIM DO ESTADO DO SISTEMA ===");
    }
    
    /**
     * @dev Converte uint para string (função auxiliar)
     */
    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
    
    /**
     * @dev Demonstra diferentes cenários e validações
     */
    function demonstrarCenarios() external {
        emit Resultado("=== DEMONSTRANDO CENARIOS ===");
        
        // Cenário 1: Registrar mais alunos
        emit Resultado("CENARIO 1: Registrando multiplos alunos");
        sistema.registrarAluno(11111, "Maria Costa");
        sistema.registrarAluno(22222, "Pedro Santos");
        emit Resultado("-> Alunos Maria (11111) e Pedro (22222) registrados");
        
        // Cenário 2: Criar mais disciplinas
        emit Resultado("CENARIO 2: Criando multiplas disciplinas");
        sistema.criarDisciplina("Fisica Quantica");
        sistema.criarDisciplina("Quimica Organica");
        emit Resultado("-> Disciplinas Fisica (ID:2) e Quimica (ID:3) criadas");
        
        // Cenário 3: Matricular alunos em diferentes disciplinas
        emit Resultado("CENARIO 3: Matriculas diversas");
        sistema.matricularAluno(2, 11111); // Maria em Fisica
        sistema.matricularAluno(2, 22222); // Pedro em Fisica
        sistema.matricularAluno(3, 11111); // Maria em Quimica
        emit Resultado("-> Maria: Fisica e Quimica | Pedro: Fisica");
        
        // Cenário 4: Lançar notas diferentes
        emit Resultado("CENARIO 4: Lancando notas variadas");
        sistema.lancarNota(2, 11111, 950); // Maria em Fisica: 9.5
        sistema.lancarNota(2, 22222, 730); // Pedro em Fisica: 7.3
        sistema.lancarNota(3, 11111, 820); // Maria em Quimica: 8.2
        emit Resultado("-> Notas lancadas: Maria(9.5 e 8.2), Pedro(7.3)");
        
        // Cenário 5: Alterar uma nota
        emit Resultado("CENARIO 5: Alterando nota de Pedro");
        sistema.alterarNota(2, 22222, 780); // Pedro: 7.3 -> 7.8
        emit Resultado("-> Nota de Pedro alterada de 7.3 para 7.8");
        
        emit Resultado("=== CENARIOS CONCLUIDOS ===");
    }
    
    /**
     * @dev Explica a arquitetura e relações do sistema
     */
    function explicarArquitetura() external {
        emit Resultado("=== ARQUITETURA DO SISTEMA DE NOTAS ===");
        
        emit Resultado("ESTRUTURA PRINCIPAL:");
        emit Resultado("1. UM CONTRATO UNICO - SistemaNotas");
        emit Resultado("2. Professor registrado NO CONTRATO");
        emit Resultado("3. Alunos registrados NO CONTRATO");
        emit Resultado("4. Disciplinas criadas PELO PROFESSOR");
        emit Resultado("5. Relacoes gerenciadas PELO CONTRATO");
        
        emit Resultado("");
        emit Resultado("RELACOES:");
        emit Resultado("Professor <-> Disciplina: 1 para N (um prof, varias disciplinas)");
        emit Resultado("Disciplina <-> Alunos: 1 para N (uma disciplina, varios alunos)");
        emit Resultado("Aluno <-> Notas: 1 para N (um aluno, notas em varias disciplinas)");
        
        emit Resultado("");
        emit Resultado("NAO HA CONTRATO DIRETO PROFESSOR-ALUNO!");
        emit Resultado("A relacao acontece ATRAVES DA DISCIPLINA");
        emit Resultado("=== FIM DA EXPLICACAO ===");
    }
    
    /**
     * @dev Demonstra as relações através de um exemplo prático
     */
    function demonstrarRelacoes() external {
        emit Resultado("=== DEMONSTRACAO DE RELACOES ===");
        
        // Setup inicial
        emit Resultado("SETUP: Criando cenario com 1 professor, 2 disciplinas, 3 alunos");
        
        // 1. Professor se registra
        sistema.registrarProfessor();
        emit Resultado("1. Professor registrado no sistema central");
        
        // 2. Professor cria disciplinas
        sistema.criarDisciplina("Matematica");
        sistema.criarDisciplina("Fisica");
        emit Resultado("2. Professor cria 2 disciplinas (IDs: 1 e 2)");
        
        // 3. Alunos se registram
        sistema.registrarAluno(1001, "Ana Silva");
        sistema.registrarAluno(1002, "Bruno Costa");
        sistema.registrarAluno(1003, "Carlos Lima");
        emit Resultado("3. Tres alunos registrados no sistema");
        
        emit Resultado("");
        emit Resultado("RELACOES ATRAVES DAS DISCIPLINAS:");
        
        // 4. Matriculas em Matemática
        sistema.matricularAluno(1, 1001); // Ana em Mat
        sistema.matricularAluno(1, 1002); // Bruno em Mat
        emit Resultado("4. Ana e Bruno matriculados em Matematica (ID:1)");
        
        // 5. Matriculas em Física
        sistema.matricularAluno(2, 1001); // Ana em Fis
        sistema.matricularAluno(2, 1003); // Carlos em Fis
        emit Resultado("5. Ana e Carlos matriculados em Fisica (ID:2)");
        
        emit Resultado("");
        emit Resultado("RESULTADO:");
        emit Resultado("- Ana: Matematica E Fisica");
        emit Resultado("- Bruno: APENAS Matematica");
        emit Resultado("- Carlos: APENAS Fisica");
        emit Resultado("- Professor: Responsavel por AMBAS as disciplinas");
        
        emit Resultado("");
        emit Resultado("LANCANDO NOTAS (Professor -> Aluno via Disciplina):");
        sistema.lancarNota(1, 1001, 900); // Ana em Mat: 9.0
        sistema.lancarNota(1, 1002, 750); // Bruno em Mat: 7.5
        sistema.lancarNota(2, 1001, 850); // Ana em Fis: 8.5
        sistema.lancarNota(2, 1003, 800); // Carlos em Fis: 8.0
        emit Resultado("Notas lancadas para todos os alunos matriculados");
        
        emit Resultado("=== RELACOES DEMONSTRADAS ===");
    }
    
    /**
     * @dev Mostra como o sistema centralizado funciona
     */
    function explicarSistemaCentralizado() external {
        emit Resultado("=== SISTEMA CENTRALIZADO ===");
        
        emit Resultado("COMO FUNCIONA:");
        emit Resultado("1. SMART CONTRACT UNICO = Autoridade Central");
        emit Resultado("2. Professor = Usuario com permissoes especiais");
        emit Resultado("3. Aluno = Usuario com permissoes limitadas");
        emit Resultado("4. Disciplina = Entidade que conecta professor e alunos");
        
        emit Resultado("");
        emit Resultado("VANTAGENS:");
        emit Resultado("- Gestao centralizada de todos os dados");
        emit Resultado("- Seguranca: apenas professor pode alterar notas");
        emit Resultado("- Transparencia: todas as operacoes sao registradas");
        emit Resultado("- Eficiencia: um contrato gerencia tudo");
        
        emit Resultado("");
        emit Resultado("PERMISSOES:");
        emit Resultado("Professor PODE: criar disciplinas, matricular, lancar notas");
        emit Resultado("Aluno PODE: ver suas proprias notas");
        emit Resultado("Sistema VALIDA: todas as operacoes e permissoes");
        
        emit Resultado("");
        emit Resultado("DIFERENTE DE:");
        emit Resultado("- Contratos individuais professor-aluno");
        emit Resultado("- Tokens para cada disciplina");
        emit Resultado("- Sistemas descentralizados por materia");
        
        emit Resultado("=== EXPLICACAO CONCLUIDA ===");
    }
}
