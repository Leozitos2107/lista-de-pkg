Lista de Packages contendo Aluno, Disciplina e Professor.

Estrutura do Projeto

Pacote PKG_ALUNO Funcionalidades:
Excluir aluno e matrículas:

Procedure ExcluirAluno(p_AlunoID IN NUMBER): Recebe o ID de um aluno como parâmetro. Remove o registro do aluno na tabela Aluno e todas as suas matrículas na tabela AlunoDisciplina.

Exemplo exclusão aluno e matriculas:

BEGIN PKG_ALUNO.ExcluirAluno(101); -- 101 é um exemplo de ID do aluno END;

Cursor CursorAlunosMaior18: Retorna o nome e a data de nascimento de todos os alunos com idade >18 anos.

Exemplo para listar alunos maiores de 18 anos:

DECLARE v_Nome Aluno.Nome%TYPE; v_DataNascimento Aluno.DataNascimento%TYPE; BEGIN OPEN PKG_ALUNO.CursorAlunosMaior18; LOOP FETCH PKG_ALUNO.CursorAlunosMaior18 INTO v_Nome, v_DataNascimento; EXIT WHEN PKG_ALUNO.CursorAlunosMaior18%NOTFOUND; DBMS_OUTPUT.PUT_LINE('Nome: ' || v_Nome || ', Data de Nascimento: ' || v_DataNascimento); END LOOP; CLOSE PKG_ALUNO.CursorAlunosMaior18; END;

Cursor CursorAlunosPorCurso(p_CursoID IN NUMBER): Recebe o ID de um curso como parâmetro. Retorna o nome dos alunos matriculados de cursos especificos.

Exemplo de listar alunos por curso:

DECLARE v_Nome Aluno.Nome%TYPE; BEGIN OPEN PKG_ALUNO.CursorAlunosPorCurso(1); -- Substitua 1 pelo ID do curso LOOP FETCH PKG_ALUNO.CursorAlunosPorCurso INTO v_Nome; EXIT WHEN PKG_ALUNO.CursorAlunosPorCurso%NOTFOUND; DBMS_OUTPUT.PUT_LINE('Aluno: ' || v_Nome); END LOOP; CLOSE PKG_ALUNO.CursorAlunosPorCurso; END;

Pacote PKG_DISCIPLINA Funcionalidades: Cadastrar nova disciplina:
Procedure CadastrarDisciplina(p_Nome IN VARCHAR2, p_Descricao IN VARCHAR2, p_CargaHoraria IN NUMBER): Recebe o nome, descrição e carga horária da disciplina. Insere uma nova disciplina na tabela de disciplinas.

Exemplo: BEGIN PKG_DISCIPLINA.CadastrarDisciplina('Matemática', 'Curso básico de matemática', 60); END;

Listar total de alunos por disciplina:

Cursor CursorTotalAlunosPorDisciplina: Lista o nome das disciplinas e o número total de alunos matriculados.

Exemplo:

DECLARE v_Nome Disciplina.Nome%TYPE; v_TotalAlunos NUMBER; BEGIN OPEN PKG_DISCIPLINA.CursorTotalAlunosPorDisciplina; LOOP FETCH PKG_DISCIPLINA.CursorTotalAlunosPorDisciplina INTO v_Nome, v_TotalAlunos; EXIT WHEN PKG_DISCIPLINA.CursorTotalAlunosPorDisciplina%NOTFOUND; DBMS_OUTPUT.PUT_LINE('Disciplina: ' || v_Nome || ', Total de Alunos: ' || v_TotalAlunos); END LOOP; CLOSE PKG_DISCIPLINA.CursorTotalAlunosPorDisciplina; END;

Calcular média de idade por disciplina:

Cursor CursorMediaIdadePorDisciplina(p_DisciplinaID IN NUMBER): Recebe o ID de uma disciplina como parâmetro. Calcula a média de idade dos alunos matriculados na disciplina.

Exemplo:

DECLARE v_MediaIdade NUMBER; BEGIN OPEN PKG_DISCIPLINA.CursorMediaIdadePorDisciplina(1); -- Substitua 1 pelo ID da disciplina FETCH PKG_DISCIPLINA.CursorMediaIdadePorDisciplina INTO v_MediaIdade; DBMS_OUTPUT.PUT_LINE('Média de idade: ' || v_MediaIdade); CLOSE PKG_DISCIPLINA.CursorMediaIdadePorDisciplina; END;

Listar alunos de uma disciplina:

Procedure ListarAlunosPorDisciplina(p_DisciplinaID IN NUMBER): Recebe o ID de uma disciplina como parâmetro. Exibe os nomes dos alunos matriculados na disciplina.

Exemplo:

BEGIN PKG_DISCIPLINA.ListarAlunosPorDisciplina(1); -- Substitua 1 pelo ID da disciplina END;

Pacote PKG_PROFESSOR Funcionalidades:
Listar total de turmas por professor:

Cursor CursorTotalTurmasPorProfessor: Lista os nomes dos professores e o número total de turmas. Exibe apenas os professores responsáveis por uma ou mais turmas.

Exemplo:

DECLARE v_NomeProfessor VARCHAR2(100); v_TotalTurmas NUMBER; BEGIN OPEN PKG_PROFESSOR.CursorTotalTurmasPorProfessor; LOOP FETCH PKG_PROFESSOR.CursorTotalTurmasPorProfessor INTO v_NomeProfessor, v_TotalTurmas; EXIT WHEN PKG_PROFESSOR.CursorTotalTurmasPorProfessor%NOTFOUND; DBMS_OUTPUT.PUT_LINE('Professor: ' || v_NomeProfessor || ', Total de Turmas: ' || v_TotalTurmas); END LOOP; CLOSE PKG_PROFESSOR.CursorTotalTurmasPorProfessor; END;

Obter total de turmas de um professor:

Function TotalTurmasProfessor(p_ProfessorID IN NUMBER) RETURN NUMBER: Recebe o ID de um professor como parâmetro. Retorna o número total de turmas em que o professor atua como responsável.

Exemplo:

DECLARE v_TotalTurmas NUMBER; BEGIN v_TotalTurmas := PKG_PROFESSOR.TotalTurmasProfessor(1); -- Substitua 1 pelo ID do professor DBMS_OUTPUT.PUT_LINE('Total de turmas: ' || v_TotalTurmas); END;

Obter professor de uma disciplina:

Function NomeProfessorDisciplina(p_DisciplinaID IN NUMBER) RETURN VARCHAR2: Recebe o ID de uma disciplina como parâmetro. Retorna o nome do professor que ministra a disciplina.

Exemplo:

DECLARE v_NomeProfessor VARCHAR2(100); BEGIN v_NomeProfessor := PKG_PROFESSOR.NomeProfessorDisciplina(2); -- Substitua 2 pelo ID da disciplina DBMS_OUTPUT.PUT_LINE('Professor: ' || v_NomeProfessor); END;

