// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./crid.sol";

/**
 * @title Exemplo Prático Simplificado do Sistema de Notas
 * @dev Demonstra um cenário completo de uso - versão compatível com Remix
 */
contract ExemploSimplificado {
    SistemaNotas public sistema;
    
    // Eventos para demonstração
    event ExemploExecutado(string etapa, string descricao);
    event TesteCompleto(string resultado);
    
    constructor() {
        sistema = new SistemaNotas();
    }
    
    /**
     * @dev Executa um exemplo completo e simplificado do sistema
     */
    function exemploCompleto() external {
        emit ExemploExecutado("INICIO", "Iniciando exemplo completo do sistema");
        
        try {
            // 1. Registrar professor
            sistema.registrarProfessor();
            emit ExemploExecutado("ETAPA_1", "Professor registrado com sucesso");
            
            // 2. Criar disciplinas
            sistema.criarDisciplina("Matematica");
            sistema.criarDisciplina("Fisica");
            emit ExemploExecutado("ETAPA_2", "Disciplinas criadas com sucesso");
            
            // 3. Registrar alunos
            sistema.registrarAluno(2024001, "Maria Silva");
            sistema.registrarAluno(2024002, "Joao Santos");
            sistema.registrarAluno(2024003, "Ana Costa");
            emit ExemploExecutado("ETAPA_3", "Alunos registrados com sucesso");
            
            // 4. Matricular alunos
            sistema.matricularAluno(1, 2024001); // Maria em Matematica
            sistema.matricularAluno(1, 2024002); // Joao em Matematica
            sistema.matricularAluno(1, 2024003); // Ana em Matematica
            emit ExemploExecutado("ETAPA_4", "Alunos matriculados com sucesso");
            
            // 5. Lançar notas
            sistema.lancarNota(1, 2024001, 950); // Maria: 9.5
            sistema.lancarNota(1, 2024002, 820); // Joao: 8.2
            sistema.lancarNota(1, 2024003, 760); // Ana: 7.6
            emit ExemploExecutado("ETAPA_5", "Notas lancadas com sucesso");
            
            // 6. Alterar uma nota
            sistema.alterarNota(1, 2024002, 870); // Joao: 8.2 -> 8.7
            emit ExemploExecutado("ETAPA_6", "Nota alterada com sucesso");
            
            emit TesteCompleto("SUCESSO: Todas as etapas concluidas sem erro");
            
        } catch Error(string memory reason) {
            emit TesteCompleto(string(abi.encodePacked("ERRO: ", reason)));
        } catch {
            emit TesteCompleto("ERRO: Falha desconhecida no sistema");
        }
    }
    
    /**
     * @dev Testa apenas o registro de usuários
     */
    function testeRegistroUsuarios() external {
        emit ExemploExecutado("TESTE_REGISTRO", "Testando registro de usuarios");
        
        try {
            // Registrar professor
            sistema.registrarProfessor();
            
            // Registrar alunos
            sistema.registrarAluno(1001, "Teste Aluno 1");
            sistema.registrarAluno(1002, "Teste Aluno 2");
            
            emit ExemploExecutado("REGISTRO_OK", "Usuarios registrados com sucesso");
        } catch Error(string memory reason) {
            emit ExemploExecutado("REGISTRO_ERRO", reason);
        }
    }
    
    /**
     * @dev Testa criação de disciplinas
     */
    function testeCriacaoDisciplinas() external {
        emit ExemploExecutado("TESTE_DISCIPLINAS", "Testando criacao de disciplinas");
        
        try {
            // Garantir que há um professor registrado
            sistema.registrarProfessor();
            
            // Criar disciplinas
            sistema.criarDisciplina("Calculo I");
            sistema.criarDisciplina("Algebra Linear");
            
            emit ExemploExecutado("DISCIPLINAS_OK", "Disciplinas criadas com sucesso");
        } catch Error(string memory reason) {
            emit ExemploExecutado("DISCIPLINAS_ERRO", reason);
        }
    }
    
    /**
     * @dev Testa lançamento de notas
     */
    function testeLancamentoNotas() external {
        emit ExemploExecutado("TESTE_NOTAS", "Testando lancamento de notas");
        
        try {
            // Setup completo
            sistema.registrarProfessor();
            sistema.criarDisciplina("Teste Disciplina");
            sistema.registrarAluno(3001, "Aluno Teste");
            sistema.matricularAluno(1, 3001);
            
            // Lançar nota
            sistema.lancarNota(1, 3001, 850); // 8.5
            
            emit ExemploExecutado("NOTAS_OK", "Nota lancada com sucesso");
        } catch Error(string memory reason) {
            emit ExemploExecutado("NOTAS_ERRO", reason);
        }
    }
    
    /**
     * @dev Consulta uma nota específica
     */
    function consultarNota(uint256 disciplinaId, uint256 matricula) 
        external 
        view 
        returns (uint256 nota, bool existe, string memory status) 
    {
        try sistema.consultarMinhaNotaTeste(disciplinaId, matricula) returns (uint256 n, bool e) {
            return (n, e, e ? "Nota encontrada" : "Nota nao encontrada");
        } catch {
            return (0, false, "Erro ao consultar nota");
        }
    }
    
    /**
     * @dev Consulta informações básicas do sistema
     */
    function consultarEstatisticas() 
        external 
        view 
        returns (uint256 proximaDisciplina, string memory status) 
    {
        try sistema.proximoDisciplinaId() returns (uint256 id) {
            return (id, "Sistema funcionando");
        } catch {
            return (0, "Erro no sistema");
        }
    }
    
    /**
     * @dev Verifica se um aluno está matriculado
     */
    function verificarMatricula(uint256 disciplinaId, uint256 matricula) 
        external 
        view 
        returns (bool matriculado, string memory status) 
    {
        try sistema.alunoEstaMatriculado(disciplinaId, matricula) returns (bool m) {
            return (m, m ? "Aluno matriculado" : "Aluno nao matriculado");
        } catch {
            return (false, "Erro ao verificar matricula");
        }
    }
    
    /**
     * @dev Função de ajuda com instruções
     */
    function ajuda() external pure returns (string memory) {
        return "Funcoes disponiveis: exemploCompleto(), testeRegistroUsuarios(), testeCriacaoDisciplinas(), testeLancamentoNotas(), consultarNota(), consultarEstatisticas(), verificarMatricula()";
    }
}
