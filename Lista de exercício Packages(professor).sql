CREATE OR REPLACE PACKAGE PKG_PROFESSOR IS
    -- Cursor para listar total de turmas por professor (mais de uma turma)
    CURSOR CursorTotalTurmasPorProfessor;

    -- Function para retornar o total de turmas de um professor
    FUNCTION TotalTurmasProfessor(p_ProfessorID IN NUMBER) RETURN NUMBER;

    -- Function para retornar o nome do professor de uma disciplina
    FUNCTION NomeProfessorDisciplina(p_DisciplinaID IN NUMBER) RETURN VARCHAR2;
END PKG_PROFESSOR;

CREATE OR REPLACE PACKAGE BODY PKG_PROFESSOR IS

    -- Cursor para listar total de turmas por professor
    CURSOR CursorTotalTurmasPorProfessor IS
        SELECT P.Nome AS NomeProfessor, COUNT(T.TurmaID) AS TotalTurmas
        FROM Professor P
        JOIN Turma T ON P.ProfessorID = T.ProfessorID
        GROUP BY P.Nome
        HAVING COUNT(T.TurmaID) > 1;

    -- Function para retornar o total de turmas de um professor
    FUNCTION TotalTurmasProfessor(p_ProfessorID IN NUMBER) RETURN NUMBER IS
        v_TotalTurmas NUMBER := 0;
    BEGIN
        SELECT COUNT(T.TurmaID)
        INTO v_TotalTurmas
        FROM Turma T
        WHERE T.ProfessorID = p_ProfessorID;

        RETURN v_TotalTurmas;
    END TotalTurmasProfessor;

    -- Function para retornar o nome do professor de uma disciplina
    FUNCTION NomeProfessorDisciplina(p_DisciplinaID IN NUMBER) RETURN VARCHAR2 IS
        v_NomeProfessor VARCHAR2(100);
    BEGIN
        SELECT P.Nome
        INTO v_NomeProfessor
        FROM Professor P
        JOIN Turma T ON P.ProfessorID = T.ProfessorID
        JOIN Disciplina D ON T.DisciplinaID = D.DisciplinaID
        WHERE D.DisciplinaID = p_DisciplinaID;

        RETURN v_NomeProfessor;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'Professor não encontrado';
        WHEN OTHERS THEN
            RETURN 'Erro ao buscar professor';
    END NomeProfessorDisciplina;

END PKG_PROFESSOR;


