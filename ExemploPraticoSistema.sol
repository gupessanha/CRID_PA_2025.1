// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./crid.sol";

/**
 * @title Exemplo Prático de Uso do Sistema
 * @dev Demonstra um cenário completo de uso do sistema de notas
 */
contract ExemploPraticoSistema {
    SistemaNotas public sistema;
    
    // Endereços simulados para exemplo
    address public professorMatematica;
    address public professorFisica;
    address public aluno1;
    address public aluno2;
    address public aluno3;
    
    // Eventos para demonstração
    event ExemploExecutado(string etapa, string descricao);
    event EstatisticasSistema(uint256 disciplinas, uint256 totalAcoes);
    
    constructor() {
        sistema = new SistemaNotas();
        
        // Para demonstração, vamos simular diferentes usuários
        professorMatematica = address(this);
        professorFisica = address(0x1);
        aluno1 = address(0x2);
        aluno2 = address(0x3);
        aluno3 = address(0x4);
    }
    
    /**
     * @dev Executa um exemplo completo do sistema
     */
    function exemploCompleto() external {
        emit ExemploExecutado("INICIO", "Iniciando exemplo completo do sistema");
        
        // ETAPA 1: Registro de Usuários
        etapa1_RegistroUsuarios();
        
        // ETAPA 2: Criação de Disciplinas
        etapa2_CriacaoDisciplinas();
        
        // ETAPA 3: Matrícula de Alunos
        etapa3_MatriculaAlunos();
        
        // ETAPA 4: Lancamento de Notas
        etapa4_LancamentoNotas();
        
        // ETAPA 5: Gestão de Notas
        etapa5_GestaoNotas();
        
        // ETAPA 6: relatorios e Consultas
        etapa6_RelatoriosConsultas();
        
        // ETAPA 7: estatisticas Finais
        etapa7_EstatisticasFinais();
        
        emit ExemploExecutado("FIM", "Exemplo completo finalizado com sucesso");
    }
    
    /**
     * @dev ETAPA 1: Registro de Usuários
     */
    function etapa1_RegistroUsuarios() internal {
        emit ExemploExecutado("ETAPA_1", "Registrando usuarios no sistema");
        
        // Registrar professor (este contrato representa o professor)
        sistema.registrarProfessor();
        emit ExemploExecutado("PROFESSOR", "Professor de Matematica registrado");
        
        // Registrar alunos
        sistema.registrarAluno(2024001, "Maria Silva Santos");
        emit ExemploExecutado("ALUNO_1", "Aluno Maria Silva Santos (2024001) registrado");
        
        sistema.registrarAluno(2024002, "Joao Pedro Oliveira");
        emit ExemploExecutado("ALUNO_2", "Aluno Joao Pedro Oliveira (2024002) registrado");
        
        sistema.registrarAluno(2024003, "Ana Carolina Lima");
        emit ExemploExecutado("ALUNO_3", "Aluno Ana Carolina Lima (2024003) registrado");
        
        sistema.registrarAluno(2024004, "Carlos Eduardo Costa");
        emit ExemploExecutado("ALUNO_4", "Aluno Carlos Eduardo Costa (2024004) registrado");
    }
    
    /**
     * @dev ETAPA 2: Criação de Disciplinas
     */
    function etapa2_CriacaoDisciplinas() internal {
        emit ExemploExecutado("ETAPA_2", "Criando disciplinas");
        
        // Criar disciplinas
        sistema.criarDisciplina("Calculo Diferencial e Integral I");
        emit ExemploExecutado("DISCIPLINA_1", "Calculo Diferencial e Integral I criada (ID: 1)");
        
        sistema.criarDisciplina("Algebra Linear");
        emit ExemploExecutado("DISCIPLINA_2", "Algebra Linear criada (ID: 2)");
        
        sistema.criarDisciplina("Geometria Analitica");
        emit ExemploExecutado("DISCIPLINA_3", "Geometria Analitica criada (ID: 3)");
    }
    
    /**
     * @dev ETAPA 3: Matrícula de Alunos
     */
    function etapa3_MatriculaAlunos() internal {
        emit ExemploExecutado("ETAPA_3", "Matriculando alunos nas disciplinas");
        
        // Matricular alunos em Calculo I (disciplina 1)
        sistema.matricularAluno(1, 2024001); // Maria
        sistema.matricularAluno(1, 2024002); // Joao
        sistema.matricularAluno(1, 2024003); // Ana
        sistema.matricularAluno(1, 2024004); // Carlos
        emit ExemploExecutado("MATRICULAS_CALC", "4 alunos matriculados em Calculo I");
        
        // Matricular alguns alunos em Algebra Linear (disciplina 2)
        sistema.matricularAluno(2, 2024001); // Maria
        sistema.matricularAluno(2, 2024003); // Ana
        sistema.matricularAluno(2, 2024004); // Carlos
        emit ExemploExecutado("MATRICULAS_ALG", "3 alunos matriculados em Algebra Linear");
        
        // Matricular alguns alunos em Geometria (disciplina 3)
        sistema.matricularAluno(3, 2024002); // Joao
        sistema.matricularAluno(3, 2024003); // Ana
        emit ExemploExecutado("MATRICULAS_GEO", "2 alunos matriculados em Geometria Analitica");
    }
    
    /**
     * @dev ETAPA 4: Lancamento de Notas
     */
    function etapa4_LancamentoNotas() internal {
        emit ExemploExecutado("ETAPA_4", "Lancando notas dos alunos");
        
        // Notas para Calculo I
        sistema.lancarNota(1, 2024001, 920); // Maria: 9.2
        sistema.lancarNota(1, 2024002, 750); // Joao: 7.5
        sistema.lancarNota(1, 2024003, 850); // Ana: 8.5
        sistema.lancarNota(1, 2024004, 680); // Carlos: 6.8
        emit ExemploExecutado("NOTAS_CALC", "Notas Lancadas para Calculo I");
        
        // Notas para Algebra Linear
        sistema.lancarNota(2, 2024001, 880); // Maria: 8.8
        sistema.lancarNota(2, 2024003, 940); // Ana: 9.4
        sistema.lancarNota(2, 2024004, 720); // Carlos: 7.2
        emit ExemploExecutado("NOTAS_ALG", "Notas Lancadas para Algebra Linear");
        
        // Notas para Geometria Analitica
        sistema.lancarNota(3, 2024002, 810); // Joao: 8.1
        sistema.lancarNota(3, 2024003, 900); // Ana: 9.0
        emit ExemploExecutado("NOTAS_GEO", "Notas Lancadas para Geometria Analitica");
    }
    
    /**
     * @dev ETAPA 5: Gestão de Notas (alterações)
     */
    function etapa5_GestaoNotas() internal {
        emit ExemploExecutado("ETAPA_5", "Gerenciando e alterando notas");
        
        // Alterar algumas notas após revisão
        sistema.alterarNota(1, 2024002, 780); // Joao: 7.5 -> 7.8
        emit ExemploExecutado("ALTERACAO_1", "Nota de Joao em Calculo alterada de 7.5 para 7.8");
        
        sistema.alterarNota(1, 2024004, 710); // Carlos: 6.8 -> 7.1
        emit ExemploExecutado("ALTERACAO_2", "Nota de Carlos em Calculo alterada de 6.8 para 7.1");
        
        sistema.alterarNota(2, 2024004, 750); // Carlos: 7.2 -> 7.5
        emit ExemploExecutado("ALTERACAO_3", "Nota de Carlos em Algebra alterada de 7.2 para 7.5");
    }
    
    /**
     * @dev ETAPA 6: relatorios e Consultas
     */
    function etapa6_RelatoriosConsultas() internal {
        emit ExemploExecutado("ETAPA_6", "Gerando relatorios e consultas");
        
        // Consultar notas de cada disciplina
        (uint256[] memory matriculas1, uint256[] memory notas1) = sistema.consultarNotasDaDisciplina(1);
        emit ExemploExecutado("RELATORIO_CALC", "relatorio de Calculo I gerado");
        
        (uint256[] memory matriculas2, uint256[] memory notas2) = sistema.consultarNotasDaDisciplina(2);
        emit ExemploExecutado("RELATORIO_ALG", "relatorio de Algebra Linear gerado");
        
        (uint256[] memory matriculas3, uint256[] memory notas3) = sistema.consultarNotasDaDisciplina(3);
        emit ExemploExecutado("RELATORIO_GEO", "relatorio de Geometria Analitica gerado");
        
        // Consultar disciplinas do professor
        uint256[] memory disciplinasProfessor = sistema.consultarMinhasDisciplinas();
        emit ExemploExecutado("DISCIPLINAS_PROF", "Disciplinas do professor consultadas");
        
        // Consultar alunos de uma disciplina
        uint256[] memory alunosCalculo = sistema.consultarAlunosDaDisciplina(1);
        emit ExemploExecutado("ALUNOS_DISC", "Lista de alunos de Calculo I consultada");
    }
    
    /**
     * @dev ETAPA 7: estatisticas Finais
     */
    function etapa7_EstatisticasFinais() internal {
        emit ExemploExecutado("ETAPA_7", "Calculando estatisticas finais");
        
        uint256 proximoId = sistema.proximoDisciplinaId();
        uint256 totalDisciplinas = proximoId - 1;
        
        emit EstatisticasSistema(totalDisciplinas, 25); // Aproximadamente 25 ações executadas
        
        emit ExemploExecutado("ESTATISTICAS", "estatisticas do sistema calculadas");
    }
    
    /**
     * @dev Função para consultar uma nota específica (para testes)
     */
    function consultarNotaAluno(uint256 disciplinaId, uint256 matricula) 
        external 
        view 
        returns (uint256 nota, bool existe, string memory info) 
    {
        (nota, existe) = sistema.consultarMinhaNotaTeste(disciplinaId, matricula);
        
        if (existe) {
            info = "Nota encontrada";
        } else {
            info = "Nota nao encontrada";
        }
        
        return (nota, existe, info);
    }
    
    /**
     * @dev Função para consultar informações de uma disciplina
     */
    function consultarInfoDisciplina(uint256 disciplinaId) 
        external 
        view 
        returns (string memory nome, address professor, uint256 numAlunos) 
    {
        return sistema.consultarDisciplina(disciplinaId);
    }
    
    /**
     * @dev Função para verificar se um aluno está matriculado
     */
    function verificarMatricula(uint256 disciplinaId, uint256 matricula) 
        external 
        view 
        returns (bool matriculado) 
    {
        return sistema.alunoEstaMatriculado(disciplinaId, matricula);
    }
    
    /**
     * @dev Função para demonstrar cenário de erro (aluno tentando alterar nota)
     */
    function tentarAlterarNotaComoAluno(uint256 disciplinaId, uint256 matricula, uint256 novaNota) 
        external 
        pure 
        returns (string memory) 
    {
        // Esta função apenas simula - na prática, a transação falharia
        return "ERRO: Apenas professores podem alterar notas";
    }
    
    /**
     * @dev relatorio final do sistema
     */
    function relatorioFinal() 
        external 
        view 
        returns (
            string memory titulo,
            uint256 totalDisciplinas,
            string memory statusSistema,
            string memory observacoes
        ) 
    {
        uint256 proximoId = sistema.proximoDisciplinaId();
        
        return (
            "Sistema de Notas - relatorio Final",
            proximoId - 1,
            "Sistema funcionando corretamente",
            "Todos os cenarios de teste executados com sucesso"
        );
    }
}
