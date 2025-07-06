// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./crid.sol";

/**
 * @title Testes do Sistema de Notas
 * @dev Contrato para testar todas as funcionalidades do sistema
 */
contract TesteSistemaNotas {
    SistemaNotas public sistema;
    
    // Eventos para logs de teste
    event TesteExecutado(string nome, bool passou);
    event LogTeste(string mensagem);
    
    constructor() {
        sistema = new SistemaNotas();
    }
    
    /**
     * @dev Executa todos os testes
     */
    function executarTodosTestes() external {
        emit LogTeste("=== INICIANDO TODOS OS TESTES ===");
        
        testeRegistroAluno();
        testeRegistroProfessor();
        testeCriacaoDisciplina();
        testeMatriculaAluno();
        testeLancamentoNota();
        testeAlteracaoNota();
        testeConsultaNota();
        testeConsultaDisciplinas();
        testePermissoes();
        
        emit LogTeste("=== TODOS OS TESTES CONCLUIDOS ===");
    }
    
    /**
     * @dev Teste de registro de aluno
     */
    function testeRegistroAluno() public {
        emit LogTeste("--- Teste: Registro de Aluno ---");
        
        try sistema.registrarAluno(12345, "João Silva") {
            emit TesteExecutado("Registro de aluno valido", true);
        } catch {
            emit TesteExecutado("Registro de aluno valido", false);
        }
        
        // Teste de aluno duplicado
        try sistema.registrarAluno(12345, "João Silva Duplicado") {
            emit TesteExecutado("Rejeicao de aluno duplicado", false);
        } catch {
            emit TesteExecutado("Rejeicao de aluno duplicado", true);
        }
        
        // Verificar se aluno foi registrado
        (,uint256 matricula, bool existe) = sistema.alunos(12345);
        if (existe && matricula == 12345) {
            emit TesteExecutado("Verificacao de dados do aluno", true);
        } else {
            emit TesteExecutado("Verificacao de dados do aluno", false);
        }
    }
    
    /**
     * @dev Teste de registro de professor
     */
    function testeRegistroProfessor() public {
        emit LogTeste("--- Teste: Registro de Professor ---");
        
        try sistema.registrarProfessor() {
            emit TesteExecutado("Registro de professor", true);
        } catch {
            emit TesteExecutado("Registro de professor", false);
        }
        
        // Verificar se professor foi registrado
        (address endereco,, bool existe) = sistema.professores(address(this));
        if (existe && endereco == address(this)) {
            emit TesteExecutado("Verificacao de dados do professor", true);
        } else {
            emit TesteExecutado("Verificacao de dados do professor", false);
        }
    }
    
    /**
     * @dev Teste de criação de disciplina
     */
    function testeCriacaoDisciplina() public {
        emit LogTeste("--- Teste: Criacao de Disciplina ---");
        
        try sistema.criarDisciplina("Matematica") {
            emit TesteExecutado("Criacao de disciplina", true);
        } catch {
            emit TesteExecutado("Criacao de disciplina", false);
        }
        
        // Verificar se disciplina foi criada
        (string memory nome, address professor, bool existe) = sistema.disciplinas(1);
        if (existe && keccak256(bytes(nome)) == keccak256(bytes("Matematica")) && professor == address(this)) {
            emit TesteExecutado("Verificacao de dados da disciplina", true);
        } else {
            emit TesteExecutado("Verificacao de dados da disciplina", false);
        }
    }
    
    /**
     * @dev Teste de matrícula de aluno
     */
    function testeMatriculaAluno() public {
        emit LogTeste("--- Teste: Matricula de Aluno ---");
        
        // Registrar mais alunos para teste
        sistema.registrarAluno(54321, "Maria Santos");
        sistema.registrarAluno(67890, "Pedro Oliveira");
        
        try sistema.matricularAluno(1, 12345) {
            emit TesteExecutado("Matricula de aluno na disciplina", true);
        } catch {
            emit TesteExecutado("Matricula de aluno na disciplina", false);
        }
        
        try sistema.matricularAluno(1, 54321) {
            emit TesteExecutado("Matricula de segundo aluno", true);
        } catch {
            emit TesteExecutado("Matricula de segundo aluno", false);
        }
        
        // Verificar se aluno está matriculado
        bool matriculado = sistema.alunoEstaMatriculado(1, 12345);
        emit TesteExecutado("Verificacao de matricula do aluno", matriculado);
        
        // Teste de matrícula duplicada
        try sistema.matricularAluno(1, 12345) {
            emit TesteExecutado("Rejeicao de matricula duplicada", false);
        } catch {
            emit TesteExecutado("Rejeicao de matricula duplicada", true);
        }
    }
    
    /**
     * @dev Teste de lançamento de nota
     */
    function testeLancamentoNota() public {
        emit LogTeste("--- Teste: Lancamento de Nota ---");
        
        try sistema.lancarNota(1, 12345, 850) { // Nota 8.5
            emit TesteExecutado("Lancamento de nota valida", true);
        } catch {
            emit TesteExecutado("Lancamento de nota valida", false);
        }
        
        try sistema.lancarNota(1, 54321, 920) { // Nota 9.2
            emit TesteExecutado("Lancamento de segunda nota", true);
        } catch {
            emit TesteExecutado("Lancamento de segunda nota", false);
        }
        
        // Teste de nota inválida (maior que 10)
        try sistema.lancarNota(1, 67890, 1100) {
            emit TesteExecutado("Rejeicao de nota invalida", false);
        } catch {
            emit TesteExecutado("Rejeicao de nota invalida", true);
        }
        
        // Teste de nota duplicada
        try sistema.lancarNota(1, 12345, 750) {
            emit TesteExecutado("Rejeicao de nota duplicada", false);
        } catch {
            emit TesteExecutado("Rejeicao de nota duplicada", true);
        }
    }
    
    /**
     * @dev Teste de alteração de nota
     */
    function testeAlteracaoNota() public {
        emit LogTeste("--- Teste: Alteracao de Nota ---");
        
        try sistema.alterarNota(1, 12345, 900) { // Alterar para 9.0
            emit TesteExecutado("Alteracao de nota existente", true);
        } catch {
            emit TesteExecutado("Alteracao de nota existente", false);
        }
        
        // Verificar se nota foi alterada
        (uint256 nota, bool existe) = sistema.consultarMinhaNotaTeste(1, 12345);
        if (existe && nota == 900) {
            emit TesteExecutado("Verificacao de nota alterada", true);
        } else {
            emit TesteExecutado("Verificacao de nota alterada", false);
        }
    }
    
    /**
     * @dev Teste de consulta de nota
     */
    function testeConsultaNota() public {
        emit LogTeste("--- Teste: Consulta de Nota ---");
        
        // Consultar nota existente
        (uint256 nota, bool existe) = sistema.consultarMinhaNotaTeste(1, 12345);
        if (existe && nota == 900) {
            emit TesteExecutado("Consulta de nota existente", true);
        } else {
            emit TesteExecutado("Consulta de nota existente", false);
        }
        
        // Consultar nota inexistente
        (uint256 nota2, bool existe2) = sistema.consultarMinhaNotaTeste(1, 99999);
        if (!existe2) {
            emit TesteExecutado("Consulta de nota inexistente", true);
        } else {
            emit TesteExecutado("Consulta de nota inexistente", false);
        }
        
        // Testar consulta de todas as notas da disciplina
        try sistema.consultarNotasDaDisciplina(1) {
            emit TesteExecutado("Consulta de todas as notas da disciplina", true);
        } catch {
            emit TesteExecutado("Consulta de todas as notas da disciplina", false);
        }
    }
    
    /**
     * @dev Teste de consulta de disciplinas
     */
    function testeConsultaDisciplinas() public {
        emit LogTeste("--- Teste: Consulta de Disciplinas ---");
        
        // Criar outra disciplina
        sistema.criarDisciplina("Fisica");
        
        try sistema.consultarMinhasDisciplinas() {
            emit TesteExecutado("Consulta de disciplinas do professor", true);
        } catch {
            emit TesteExecutado("Consulta de disciplinas do professor", false);
        }
        
        try sistema.consultarDisciplina(1) {
            emit TesteExecutado("Consulta de informacoes da disciplina", true);
        } catch {
            emit TesteExecutado("Consulta de informacoes da disciplina", false);
        }
        
        try sistema.consultarAlunosDaDisciplina(1) {
            emit TesteExecutado("Consulta de alunos da disciplina", true);
        } catch {
            emit TesteExecutado("Consulta de alunos da disciplina", false);
        }
    }
    
    /**
     * @dev Teste de permissões e segurança
     */
    function testePermissoes() public {
        emit LogTeste("--- Teste: Permissoes e Seguranca ---");
        
        // Simular tentativa de acesso não autorizado seria complexo aqui
        // pois precisaríamos de outro contrato ou endereço
        // Mas podemos testar algumas validações básicas
        
        // Teste de disciplina inexistente
        try sistema.alunoEstaMatriculado(999, 12345) {
            emit TesteExecutado("Rejeicao de disciplina inexistente", false);
        } catch {
            emit TesteExecutado("Rejeicao de disciplina inexistente", true);
        }
        
        // Teste de consulta de nome privado
        try sistema.consultarNomePrivadoTeste(12345) returns (string memory nome) {
            if (keccak256(bytes(nome)) == keccak256(bytes("João Silva"))) {
                emit TesteExecutado("Consulta de nome privado", true);
            } else {
                emit TesteExecutado("Consulta de nome privado", false);
            }
        } catch {
            emit TesteExecutado("Consulta de nome privado", false);
        }
    }
    
    /**
     * @dev Função para mostrar estatísticas do sistema
     */
    function mostrarEstatisticas() external view returns (
        uint256 proximoDisciplinaId,
        string memory info
    ) {
        proximoDisciplinaId = sistema.proximoDisciplinaId();
        info = "Sistema de Notas - Testes concluidos";
        return (proximoDisciplinaId, info);
    }
    
    /**
     * @dev Função para testar cenário completo
     */
    function testeCompleto() external {
        emit LogTeste("=== TESTE COMPLETO - CENARIO REAL ===");
        
        // 1. Registrar professor
        sistema.registrarProfessor();
        emit LogTeste("Professor registrado");
        
        // 2. Criar disciplina
        sistema.criarDisciplina("Programacao Avancada");
        emit LogTeste("Disciplina criada");
        
        // 3. Registrar alunos
        sistema.registrarAluno(2023001, "Ana Costa");
        sistema.registrarAluno(2023002, "Bruno Lima");
        sistema.registrarAluno(2023003, "Carlos Mendes");
        emit LogTeste("Alunos registrados");
        
        // 4. Matricular alunos
        sistema.matricularAluno(1, 2023001);
        sistema.matricularAluno(1, 2023002);
        sistema.matricularAluno(1, 2023003);
        emit LogTeste("Alunos matriculados");
        
        // 5. Lançar notas
        sistema.lancarNota(1, 2023001, 950); // 9.5
        sistema.lancarNota(1, 2023002, 820); // 8.2
        sistema.lancarNota(1, 2023003, 760); // 7.6
        emit LogTeste("Notas lancadas");
        
        // 6. Alterar uma nota
        sistema.alterarNota(1, 2023002, 870); // 8.7
        emit LogTeste("Nota alterada");
        
        // 7. Consultar resultados
        (uint256[] memory matriculas, uint256[] memory notas) = sistema.consultarNotasDaDisciplina(1);
        emit LogTeste("Resultados consultados");
        
        emit LogTeste("=== TESTE COMPLETO FINALIZADO ===");
    }
}
