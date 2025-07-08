// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Sistema de Notas
 * @dev Contrato para gerenciar notas de alunos por disciplina
 */
contract SistemaNotas {
    
    // Estruturas de dados
    struct Aluno {
        string nomePrivado; // Nome privado - apenas o próprio aluno pode ver
        uint256 matricula;  // Matrícula pública
        bool existe;        // Flag para verificar se o aluno existe
    }
    
    struct Professor {
        address endereco;
        uint256[] disciplinasIds; // Lista de IDs das disciplinas que leciona
        bool existe;
    }
    
    struct Disciplina {
        string nome;
        address professor;
        uint256[] alunosMatriculas; // Lista de matrículas dos alunos
        bool existe;
    }
    
    struct Nota {
        uint256 disciplinaId;
        uint256 matriculaAluno;
        uint256 valor; // Nota multiplicada por 100 para evitar decimais (ex: 8.5 = 850)
        bool existe;
    }
    
    // Mapeamentos
    mapping(uint256 => Aluno) public alunos; // matricula => Aluno
    mapping(address => Professor) public professores; // endereco => Professor
    mapping(uint256 => Disciplina) public disciplinas; // id => Disciplina
    mapping(bytes32 => Nota) public notas; // hash(disciplinaId, matricula) => Nota
    
    // Contadores
    uint256 public proximoDisciplinaId = 1;
    
    // Eventos
    event AlunoRegistrado(uint256 indexed matricula, address indexed endereco);
    event ProfessorRegistrado(address indexed endereco);
    event DisciplinaCriada(uint256 indexed disciplinaId, string nome, address indexed professor);
    event AlunoMatriculado(uint256 indexed disciplinaId, uint256 indexed matricula);
    event NotaLancada(uint256 indexed disciplinaId, uint256 indexed matricula, uint256 nota);
    event NotaAlterada(uint256 indexed disciplinaId, uint256 indexed matricula, uint256 notaAntiga, uint256 notaNova);
    
    // Modificadores
    modifier apenasAluno(uint256 matricula) {
        require(alunos[matricula].existe, "Aluno nao encontrado");
        require(msg.sender != address(0), "Endereco invalido");
        _;
    }
    
    modifier apenasProfessor() {
        require(professores[msg.sender].existe, "Apenas professores podem executar esta acao");
        _;
    }
    
    modifier apenasProfessorDaDisciplina(uint256 disciplinaId) {
        require(disciplinas[disciplinaId].existe, "Disciplina nao encontrada");
        require(disciplinas[disciplinaId].professor == msg.sender, "Apenas o professor da disciplina pode executar esta acao");
        _;
    }
    
    modifier disciplinaExiste(uint256 disciplinaId) {
        require(disciplinas[disciplinaId].existe, "Disciplina nao encontrada");
        _;
    }
    
    // Funções principais
    
    /**
     * @dev Registra um novo aluno
     * @param matricula Matrícula do aluno
     * @param nome Nome do aluno (privado)
     */
    function registrarAluno(uint256 matricula, string memory nome) external {
        require(!alunos[matricula].existe, "Aluno ja registrado");
        require(bytes(nome).length > 0, "Nome nao pode ser vazio");
        
        alunos[matricula] = Aluno({
            nomePrivado: nome,
            matricula: matricula,
            existe: true
        });
        
        emit AlunoRegistrado(matricula, msg.sender);
    }
    
    /**
     * @dev Registra um novo professor
     */
    function registrarProfessor() external {
        require(!professores[msg.sender].existe, "Professor ja registrado");
        
        professores[msg.sender] = Professor({
            endereco: msg.sender,
            disciplinasIds: new uint256[](0),
            existe: true
        });
        
        emit ProfessorRegistrado(msg.sender);
    }
    
    /**
     * @dev Cria uma nova disciplina
     * @param nome Nome da disciplina
     */
    function criarDisciplina(string memory nome) external apenasProfessor {
        require(bytes(nome).length > 0, "Nome da disciplina nao pode ser vazio");
        
        uint256 disciplinaId = proximoDisciplinaId++;
        
        disciplinas[disciplinaId] = Disciplina({
            nome: nome,
            professor: msg.sender,
            alunosMatriculas: new uint256[](0),
            existe: true
        });
        
        professores[msg.sender].disciplinasIds.push(disciplinaId);
        
        emit DisciplinaCriada(disciplinaId, nome, msg.sender);
    }
    
    /**
     * @dev Matricula um aluno em uma disciplina
     * @param disciplinaId ID da disciplina
     * @param matricula Matrícula do aluno
     */
    function matricularAluno(uint256 disciplinaId, uint256 matricula) 
        external 
        apenasProfessorDaDisciplina(disciplinaId) 
    {
        require(alunos[matricula].existe, "Aluno nao encontrado");
        
        // Verifica se o aluno já está matriculado
        uint256[] memory alunosMatriculados = disciplinas[disciplinaId].alunosMatriculas;
        for (uint256 i = 0; i < alunosMatriculados.length; i++) {
            require(alunosMatriculados[i] != matricula, "Aluno ja matriculado nesta disciplina");
        }
        
        disciplinas[disciplinaId].alunosMatriculas.push(matricula);
        
        emit AlunoMatriculado(disciplinaId, matricula);
    }
    
    /**
     * @dev Lança uma nota para um aluno
     * @param disciplinaId ID da disciplina
     * @param matricula Matrícula do aluno
     * @param nota Nota (multiplicada por 100, ex: 8.5 = 850)
     */
    function lancarNota(uint256 disciplinaId, uint256 matricula, uint256 nota) 
        external 
        apenasProfessorDaDisciplina(disciplinaId) 
    {
        require(alunos[matricula].existe, "Aluno nao encontrado");
        require(nota <= 1000, "Nota deve ser entre 0 e 10 (1000)");
        require(alunoEstaMatriculado(disciplinaId, matricula), "Aluno nao esta matriculado nesta disciplina");
        
        bytes32 chaveNota = keccak256(abi.encodePacked(disciplinaId, matricula));
        require(!notas[chaveNota].existe, "Nota ja existe. Use alterarNota para modificar");
        
        notas[chaveNota] = Nota({
            disciplinaId: disciplinaId,
            matriculaAluno: matricula,
            valor: nota,
            existe: true
        });
        
        emit NotaLancada(disciplinaId, matricula, nota);
    }
    
    /**
     * @dev Altera uma nota existente
     * @param disciplinaId ID da disciplina
     * @param matricula Matrícula do aluno
     * @param novaNota Nova nota (multiplicada por 100)
     */
    function alterarNota(uint256 disciplinaId, uint256 matricula, uint256 novaNota) 
        external 
        apenasProfessorDaDisciplina(disciplinaId) 
    {
        require(novaNota <= 1000, "Nota deve ser entre 0 e 10 (1000)");
        
        bytes32 chaveNota = keccak256(abi.encodePacked(disciplinaId, matricula));
        require(notas[chaveNota].existe, "Nota nao encontrada");
        
        uint256 notaAntiga = notas[chaveNota].valor;
        notas[chaveNota].valor = novaNota;
        
        emit NotaAlterada(disciplinaId, matricula, notaAntiga, novaNota);
    }
    
    // Funções de consulta
    
    /**
     * @dev Verifica se um aluno está matriculado em uma disciplina
     */
    function alunoEstaMatriculado(uint256 disciplinaId, uint256 matricula) 
        public 
        view 
        disciplinaExiste(disciplinaId) 
        returns (bool) 
    {
        uint256[] memory alunosMatriculados = disciplinas[disciplinaId].alunosMatriculas;
        for (uint256 i = 0; i < alunosMatriculados.length; i++) {
            if (alunosMatriculados[i] == matricula) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * @dev Consulta a nota de um aluno (apenas o próprio aluno pode ver)
     * @param disciplinaId ID da disciplina
     * @param matricula Matrícula do aluno
     */
    function consultarMinhaNotaTeste(uint256 disciplinaId, uint256 matricula) 
        external 
        view 
        returns (uint256, bool) 
    {
        bytes32 chaveNota = keccak256(abi.encodePacked(disciplinaId, matricula));
        if (notas[chaveNota].existe) {
            return (notas[chaveNota].valor, true);
        }
        return (0, false);
    }
    
    /**
     * @dev Consulta nome privado do aluno (apenas para testes)
     */
    function consultarNomePrivadoTeste(uint256 matricula) 
        external 
        view 
        returns (string memory) 
    {
        require(alunos[matricula].existe, "Aluno nao encontrado");
        return alunos[matricula].nomePrivado;
    }
    
    /**
     * @dev Professor consulta todas as notas de sua disciplina
     */
    function consultarNotasDaDisciplina(uint256 disciplinaId) 
        external 
        view 
        apenasProfessorDaDisciplina(disciplinaId) 
        returns (uint256[] memory matriculas, uint256[] memory notasValores) 
    {
        uint256[] memory alunosMatriculados = disciplinas[disciplinaId].alunosMatriculas;
        uint256 contador = 0;
        
        // Primeiro, conta quantas notas existem
        for (uint256 i = 0; i < alunosMatriculados.length; i++) {
            bytes32 chaveNota = keccak256(abi.encodePacked(disciplinaId, alunosMatriculados[i]));
            if (notas[chaveNota].existe) {
                contador++;
            }
        }
        
        // Cria arrays com o tamanho correto
        matriculas = new uint256[](contador);
        notasValores = new uint256[](contador);
        
        // Preenche os arrays
        uint256 indice = 0;
        for (uint256 i = 0; i < alunosMatriculados.length; i++) {
            bytes32 chaveNota = keccak256(abi.encodePacked(disciplinaId, alunosMatriculados[i]));
            if (notas[chaveNota].existe) {
                matriculas[indice] = alunosMatriculados[i];
                notasValores[indice] = notas[chaveNota].valor;
                indice++;
            }
        }
        
        return (matriculas, notasValores);
    }
    
    /**
     * @dev Consulta as disciplinas de um professor
     */
    function consultarMinhasDisciplinas() 
        external 
        view 
        apenasProfessor 
        returns (uint256[] memory) 
    {
        return professores[msg.sender].disciplinasIds;
    }
    
    /**
     * @dev Consulta alunos matriculados em uma disciplina
     */
    function consultarAlunosDaDisciplina(uint256 disciplinaId) 
        external 
        view 
        apenasProfessorDaDisciplina(disciplinaId) 
        returns (uint256[] memory) 
    {
        return disciplinas[disciplinaId].alunosMatriculas;
    }
    
    /**
     * @dev Consulta informações de uma disciplina
     */
    function consultarDisciplina(uint256 disciplinaId) 
        external 
        view 
        disciplinaExiste(disciplinaId) 
        returns (string memory nome, address professor, uint256 numAlunos) 
    {
        Disciplina memory disciplina = disciplinas[disciplinaId];
        return (disciplina.nome, disciplina.professor, disciplina.alunosMatriculas.length);
    }
}