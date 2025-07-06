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
}
