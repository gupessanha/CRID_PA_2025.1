# 🎯 Guia Rápido para Remix IDE

## 📋 Passo a Passo para Testar no Remix

### 1. 🚀 Configuração Inicial

1. Acesse https://remix.ethereum.org/
2. Crie uma nova pasta chamada `SistemaNotas`
3. Faça upload dos seguintes arquivos:
   - `crid.sol` (contrato principal)
   - `TesteSistemaNotas.sol` (testes)
   - `ExemploSimplificado.sol` (exemplo compatível com Remix)

### 2. ⚙️ Compilação

1. Vá para a aba **"Solidity Compiler"**
2. Selecione a versão do compilador: **0.8.19** ou superior
3. Clique em **"Compile crid.sol"**
4. Compile também os outros arquivos
5. Verifique se não há erros de compilação

### 3. 🚀 Deploy dos Contratos

1. Vá para a aba **"Deploy & Run Transactions"**
2. Selecione o ambiente: **"Remix VM (London)"** para testes
3. **Deploy na seguinte ordem:**

#### A. Deploy do SistemaNotas
- Selecione `SistemaNotas` no dropdown
- Clique em **"Deploy"**
- ✅ Anote o endereço do contrato

#### B. Deploy do TesteSistemaNotas
- Selecione `TesteSistemaNotas` 
- Clique em **"Deploy"**
- ✅ Pronto para executar testes

#### C. Deploy do ExemploSimplificado  
- Selecione `ExemploSimplificado`
- Clique em **"Deploy"**
- ✅ Pronto para exemplos práticos

### 4. 🧪 Executando Testes

#### Usando TesteSistemaNotas:
```
1. Expandir o contrato deployado
2. Clicar em "executarTodosTestes"
3. Verificar os eventos na aba "Logs"
4. Executar "testeCompleto" para cenário real
```

#### Usando ExemploSimplificado:
```
1. Clicar em "exemploCompleto" 
2. Verificar logs de sucesso/erro
3. Testar funções individuais:
   - testeRegistroUsuarios()
   - testeCriacaoDisciplinas() 
   - testeLancamentoNotas()
```

### 5. 🔍 Interação Manual

#### Registrar Professor:
```
1. Ir para contrato SistemaNotas
2. Clicar em "registrarProfessor"
3. Confirmar transação
```

#### Registrar Aluno:
```
1. Expandir "registrarAluno"
2. Inserir: matricula: 12345, nome: "João Silva"
3. Clicar em "transact"
```

#### Criar Disciplina:
```
1. Expandir "criarDisciplina"
2. Inserir: "Matemática"
3. Clicar em "transact"
```

#### Matricular Aluno:
```
1. Expandir "matricularAluno"
2. Inserir: disciplinaId: 1, matricula: 12345
3. Clicar em "transact"
```

#### Lançar Nota:
```
1. Expandir "lancarNota"
2. Inserir: disciplinaId: 1, matricula: 12345, nota: 850
3. Clicar em "transact"
```

### 6. 📊 Consultas

#### Ver Nota do Aluno:
```
1. Expandir "consultarMinhaNotaTeste"
2. Inserir: disciplinaId: 1, matricula: 12345
3. Clicar em "call"
4. Resultado: [850, true] = Nota 8.5, existe
```

#### Ver Alunos da Disciplina:
```
1. Expandir "consultarAlunosDaDisciplina"
2. Inserir: disciplinaId: 1
3. Clicar em "call"
```

### 7. 🔍 Verificando Logs

1. Ir para aba **"Terminal"** no bottom
2. Verificar transações e eventos
3. Logs mostram success/failure de cada operação

### 8. 🐛 Troubleshooting

#### "Revert" ou "Execution reverted":
- ✅ Verificar se professor foi registrado antes de criar disciplina
- ✅ Verificar se aluno foi registrado antes de matricular
- ✅ Verificar se aluno está matriculado antes de lançar nota

#### "Gas estimation failed":
- ✅ Verificar parâmetros das funções
- ✅ Usar valores corretos (nota entre 0-1000)

#### "TypeError" durante deploy:
- ✅ Usar `ExemploSimplificado.sol` ao invés do original
- ✅ Verificar se todos os imports estão corretos

### 9. 🎯 Cenário Completo de Teste

```javascript
// 1. Deploy SistemaNotas
// 2. Registrar professor: registrarProfessor()
// 3. Registrar aluno: registrarAluno(12345, "João Silva")  
// 4. Criar disciplina: criarDisciplina("Matemática")
// 5. Matricular: matricularAluno(1, 12345)
// 6. Lançar nota: lancarNota(1, 12345, 850)
// 7. Consultar: consultarMinhaNotaTeste(1, 12345)
// Resultado esperado: [850, true]
```

### 10. 📋 Checklist de Sucesso

- [ ] Todos os contratos compilaram sem erro
- [ ] Deploy realizado com sucesso  
- [ ] Professor registrado
- [ ] Aluno registrado
- [ ] Disciplina criada
- [ ] Aluno matriculado
- [ ] Nota lançada
- [ ] Consulta funcionando
- [ ] Eventos aparecendo nos logs

## 🎉 Parabéns!

Se chegou até aqui, o sistema está funcionando perfeitamente! 

### 📞 Dúvidas Comuns

**Q: Nota aparece como 850 ao invés de 8.5?**  
R: Correto! Notas são multiplicadas por 100 para evitar decimais.

**Q: Como alterar uma nota?**  
R: Use `alterarNota(disciplinaId, matricula, novaNota)`

**Q: Professor não consegue ver nota de aluno?**  
R: Use `consultarNotasDaDisciplina(disciplinaId)` para ver todas as notas

**Q: Aluno pode ver nota de outro aluno?**  
R: Não! Cada aluno só vê suas próprias notas por segurança.

---

🔗 **Para mais detalhes, consulte o README.md e MANUAL.md**
