-- Criação do package DISCIPLINA

CREATE OR REPLACE PACKAGE PKG_DISCIPLINA IS
   
    PROCEDURE CadastrarDisciplina(p_Nome IN VARCHAR2, p_Descricao IN VARCHAR2, p_CargaHoraria IN NUMBER);	-- Proc que Cadastra, tendo Nome, Descrição e Carga Horaria

    CURSOR CursorTotalAlunosPorDisciplina; -- Cursor para total de alunos por disciplina
	
    CURSOR CursorMediaIdadePorDisciplina(p_DisciplinaID IN NUMBER);	-- Cursor para calcular a média de idade dos alunos por disciplina
	
    PROCEDURE ListarAlunosPorDisciplina(p_DisciplinaID IN NUMBER);	-- Proc para listar alunos de uma disciplina
	
END PKG_DISCIPLINA;

-- 																		



--


-- Implementação do package DISCIPLINA 
CREATE OR REPLACE PACKAGE BODY PKG_DISCIPLINA IS

    PROCEDURE CadastrarDisciplina(p_Nome IN VARCHAR2, p_Descricao IN VARCHAR2, p_CargaHoraria IN NUMBER) IS		---- Proc para cadastrar uma nova disciplina
    BEGIN
        INSERT INTO Disciplina (DisciplinaID, Nome, CargaHoraria)
        VALUES (Disciplina_SEQ.NEXTVAL, p_Nome, p_CargaHoraria);
        
        DBMS_OUTPUT.PUT_LINE('Disciplina "' || p_Nome || '" cadastrada com sucesso.');
    END CadastrarDisciplina;

    -- Cursor para total de alunos por disciplina
    CURSOR CursorTotalAlunosPorDisciplina IS
        SELECT D.Nome, COUNT(AD.AlunoID) AS TotalAlunos
        FROM Disciplina D
        LEFT JOIN AlunoDisciplina AD ON D.DisciplinaID = AD.DisciplinaID
        GROUP BY D.Nome
        HAVING COUNT(AD.AlunoID) > 10;

    -- Cursor para calcular a média de idade dos alunos por disciplina
    CURSOR CursorMediaIdadePorDisciplina(p_DisciplinaID IN NUMBER) IS
        SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, A.DataNascimento) / 12)) AS MediaIdade
        FROM Aluno A
        JOIN AlunoDisciplina AD ON A.AlunoID = AD.AlunoID
        WHERE AD.DisciplinaID = p_DisciplinaID;

    -- Procedure para listar alunos de uma disciplina
    PROCEDURE ListarAlunosPorDisciplina(p_DisciplinaID IN NUMBER) IS
        CURSOR AlunosCursor IS
            SELECT A.Nome
            FROM Aluno A
            JOIN AlunoDisciplina AD ON A.AlunoID = AD.AlunoID
            WHERE AD.DisciplinaID = p_DisciplinaID;

        v_Nome Aluno.Nome%TYPE;
    BEGIN
        OPEN AlunosCursor;
        LOOP
            FETCH AlunosCursor INTO v_Nome;
            EXIT WHEN AlunosCursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || v_Nome);
        END LOOP;
        CLOSE AlunosCursor;
    END ListarAlunosPorDisciplina;

END PKG_DISCIPLINA;
/
