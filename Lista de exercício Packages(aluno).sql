CREATE OR REPLACE PACKAGE PKG_ALUNO IS
    -- Proc para exclusão de aluno e suas matrículas
    PROCEDURE ExcluirAluno(p_AlunoID IN NUMBER);

    -- Cursor para listar alunos maiores de 18 anos
    CURSOR CursorAlunosMaior18;

    -- Cursor para listar alunos por curso
    CURSOR CursorAlunosPorCurso(p_CursoID IN NUMBER);
	
END PKG_ALUNO;

CREATE OR REPLACE PACKAGE BODY PKG_ALUNO IS

    -- Proc para exclusão de aluno e suas matrículas
    PROCEDURE ExcluirAluno(p_AlunoID IN NUMBER) IS
    BEGIN
        -- Remover registros de matrículas associadas ao aluno
        DELETE FROM AlunoDisciplina
        WHERE AlunoID = p_AlunoID;

        -- Remover o registro do aluno
        DELETE FROM Aluno
        WHERE AlunoID = p_AlunoID;

        -- Mensagem de confirmação
        DBMS_OUTPUT.PUT_LINE('Aluno e matrículas excluídos com sucesso.');
    END ExcluirAluno;

    -- Cursor para listar alunos maiores de 18 anos
    CURSOR CursorAlunosMaior18 IS
        SELECT Nome, DataNascimento
        FROM Aluno
        WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, DataNascimento) / 12) > 18;

    -- Cursor parametrizado para listar alunos por curso
    CURSOR CursorAlunosPorCurso(p_CursoID IN NUMBER) IS
        SELECT A.Nome
        FROM Aluno A
        INNER JOIN AlunoDisciplina AD ON A.AlunoID = AD.AlunoID
        WHERE AD.DisciplinaID = p_CursoID;

END PKG_ALUNO;

