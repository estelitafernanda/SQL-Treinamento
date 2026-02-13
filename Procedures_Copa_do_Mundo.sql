-- =======================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Desrição: Selecionar registros da tabela Efab_Time
-- ===================================

--========== Procedure Time ==========

--==== SELECT ====

USE dbTreinamento

CREATE PROCEDURE [dbo].[stp_Efab_Time_Sel]
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)

        SELECT 
            idTime,
            Nome
        FROM dbo.Efab_Time

        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Time_Sel

-- =================================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Inserir registro da tabela Efab_Time
-- =================================================

--==== INSERT ====

ALTER PROCEDURE [dbo].[stp_Efab_Time_Ins](
    @IdTime INT = NULL,
    @Nome VARCHAR(50) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)


        IF @Nome IS NULL
        BEGIN
            RAISERROR('Informe o nome do time', 16, 1)
        END


        IF LEN(@Nome) = 0
        BEGIN
            RAISERROR('Digite um nome válido que não seja só espaço', 16, 1)
        END

        IF EXISTS (
            SELECT *
            FROM Efab_Time
            WHERE Nome = @Nome
        )
        BEGIN
            RAISERROR('Nome de time já cadastrado', 16, 1)
        END

        INSERT Efab_Time(Nome)
        VALUES (@Nome)

        

        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Time_Ins @Nome = 'Suiça'
EXEC dbo.stp_Efab_Time_Sel

-- =================================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Atualizar registro da tabela Efab_Time
-- =================================================

--==== UPDATE ====

ALTER PROCEDURE [dbo].[stp_Efab_Time_Upd](
    @IdTime INT = NULL,
    @Nome VARCHAR(50) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)
        
        IF @IdTime IS NULL
        BEGIN
            RAISERROR('Informe o ID do time', 16, 1)
        END


        IF @Nome IS NULL
        BEGIN
            RAISERROR('Informe o nome do time', 16, 1)
        END

        IF LEN(@Nome) = 0
        BEGIN
            RAISERROR('Digite um nome válido que não seja só espaço', 16, 1)
        END

        IF NOT EXISTS (
            SELECT idTime
            FROM Efab_Time
            WHERE idTime = @idTime
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o time informado pelo ID %d', 16, 1, @IdTime)
        END

        IF EXISTS (
            SELECT idTime
            FROM Efab_Time
            WHERE Nome = @Nome
        )

        BEGIN
            RAISERROR('Operação cancelada. Já existe um time com esse nome %s', 16, 1, @Nome)
        END


        UPDATE Efab_Time SET 
            Nome = @Nome
        WHERE idTime = @IdTime


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Time_Upd @IdTime = 1, @Nome ='Brasil'
EXEC dbo.stp_Efab_Time_Sel

-- ================================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Deletar registro da tabela Efab_Time
-- ================================================

--==== DELETE ====

ALTER PROCEDURE [dbo].[stp_Efab_Time_Del](
    @IdTime INT = NULL,
    @Nome VARCHAR(50) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)
        
        IF @IdTime IS NULL
        BEGIN
            RAISERROR('Informe o ID do time', 16, 1)
        END

        IF @Nome IS NULL
         BEGIN
            RAISERROR('Informe o nome do time', 16, 1)
        END


        IF NOT EXISTS (
            SELECT idTime
            FROM Efab_Time
            WHERE idTime = @idTime
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o time informado pelo ID %d', 16, 1, @IdTime)
        END

        IF EXISTS (
            SELECT idTime
            FROM Efab_Jogador
            WHERE idTime = @idTime
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível apagar pois jogador tem um time', 16, 1, @IdTime)
        END
        IF EXISTS (
            SELECT idTime1
            FROM Efab_Jogo
            WHERE idTime1 = @IdTime
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível apagar pois o jogo precisa de um time pelo ID %d', 16, 1, @IdTime)
        END
        IF EXISTS (
            SELECT idTime2
            FROM Efab_Jogo
            WHERE idTime2 = @IdTime
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível apagar pois o jogo precisa de um time pelo ID %d', 16, 1, @IdTime)
        END


        DELETE Efab_Time
        WHERE idTime = @IdTime


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END


EXEC dbo.stp_Efab_Time_Del @IdTime = 2
EXEC dbo.stp_Efab_Time_Sel


-- =======================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Selecionar registro da tabela Efab_Jogador
-- ===================================

--========= Procedure Jogador =============

--==== SELECT ====
ALTER PROCEDURE [dbo].[stp_Efab_Jogador_Sel](
    @TipoConsulta INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)

        IF @TipoConsulta = 0
            SELECT 
                idJogador,
                jogr.Nome AS Jogador,
                t.Nome AS [Time],
                t.idTime
            FROM dbo.Efab_Jogador jogr
            INNER JOIN dbo.Efab_Time t
                ON t.idTime = jogr.idTime
        IF @TipoConsulta = 1
            SELECT 
                t.idTime,
                t.Nome
            FROM dbo.Efab_Time t

        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Jogador_Sel

-- ==================================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Inserir registro da tabela Efab_Jogador
-- ==================================================

--==== INSERT ====

ALTER PROCEDURE [dbo].[stp_Efab_Jogador_Ins](
    @IdJogador INT = NULL,
    @Jogador VARCHAR(50) = NULL,
    @IdTime INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)


        IF @Jogador IS NULL
        BEGIN
            RAISERROR('Informe o nome do jogador', 16, 1)
        END

        IF @IdTime IS NULL
        BEGIN
            RAISERROR('Informe o time', 16, 1)
        END

        IF LEN(@Jogador) = 0
        BEGIN
            RAISERROR('Digite um nome válido que não seja só espaço', 16, 1)
        END


        IF EXISTS (
            SELECT *
            FROM Efab_Jogador
            WHERE Nome = @Jogador AND idTime = @IdTime
        )
        BEGIN
            RAISERROR('Nome de jogador já cadastrado', 16, 1)
        END

        IF NOT EXISTS (
            SELECT idTime
            FROM Efab_Time
            WHERE idTime = @idTime
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o time informado pelo ID %d', 16, 1, @IdTime)
        END

        INSERT Efab_Jogador(Nome, idTime)
        VALUES (@Jogador, @IdTime)

        
        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH 
END

EXEC dbo.stp_Efab_Jogador_Ins @Jogador = '  ', @IdTime = 1
EXEC dbo.stp_Efab_Jogador_Sel


-- =======================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Atualizar registro da tabela Efab_Jogador
-- ===================================

--==== UPDATE ====

ALTER PROCEDURE [dbo].[stp_Efab_Jogador_Upd](
    @IdJogador INT = NULL,
    @Jogador VARCHAR(50) = NULL,
    @IdTime INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)

        IF @IdJogador IS NULL
        BEGIN
            RAISERROR('Informe o ID do Jogador', 16, 1)
        END

        IF @Jogador IS NULL
        BEGIN
            RAISERROR('Informe o nome do Jogador', 16, 1)
        END

        IF LEN(@Jogador) = 0
        BEGIN
            RAISERROR('Digite um nome válido que não seja só espaço', 16, 1)
        END

        IF @IdTime IS NULL
        BEGIN
            RAISERROR('Informe o ID do time', 16, 1)
        END

        IF NOT EXISTS (
            SELECT idJogador
            FROM Efab_Jogador
            WHERE idJogador = @IdJogador
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o jogador informado pelo ID %d', 16, 1, @IdJogador)
        END

        IF EXISTS (
            SELECT idJogador
            FROM Efab_Jogador
            WHERE Nome = @Jogador AND idTime = @IdTime
        )

        BEGIN
            RAISERROR('Operação cancelada. Já existe um jogador desse time com esse nome %s', 16, 1, @Jogador)
        END

        IF NOT EXISTS (
            SELECT idTime
            FROM Efab_Time
            WHERE idTime = @idTime
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o time informado pelo ID %d', 16, 1, @IdTime)
        END


        UPDATE Efab_Jogador SET 
            Nome = @Jogador,
            idTime = @IdTime
        WHERE idJogador = @IdJogador


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Jogador_Upd @IdJogador = 8, @Jogador = 'Neymara', @IdTime = 4
EXEC dbo.stp_Efab_Jogador_Sel

-- =======================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Deletar registro da tabela Efab_Jogador
-- ===================================

--==== DELETE ====

ALTER PROCEDURE [dbo].[stp_Efab_Jogador_Del](
    @IdJogador INT = NULL,
    @Jogador VARCHAR(50) = NULL,
    @IdTime INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)
        
        IF @IdJogador IS NULL
        BEGIN
            RAISERROR('Informe o ID do jogador', 16, 1)
        END


        IF NOT EXISTS (
            SELECT idJogador
            FROM Efab_Jogador
            WHERE idJogador = @IdJogador
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o jogador informado pelo ID %d', 16, 1, @IdJogador)
        END

        IF EXISTS(
        
            SELECT idJogador
            FROM Efab_Participacao
            WHERE idJogador = @IdJogador
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível deletar o jogador pois ele está em uma participação', 16, 1)
        END

        DELETE Efab_Jogador
        WHERE idJogador = @IdJogador


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Jogador_Del @IdJogador = 3
EXEC dbo.stp_Efab_Jogador_Sel


-- =======================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Selecionar registro da tabela Efab_Jogo
-- ===================================

--========== JOGO ===========

--==== SELECT ====

ALTER PROCEDURE [dbo].[stp_Efab_Jogo_Sel]( 
    @TipoConsulta INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)

    IF @TipoConsulta = 0
        SELECT 
            idJogo,
            t1.Nome AS Time1,
            t2.Nome AS Time2,
            j.Placar1,
            j.Placar2,
            t1.idTime AS IdTime1,
            t2.idTime AS IdTime2
        FROM dbo.Efab_Jogo j
        INNER JOIN Efab_Time t1 ON t1.idTime = j.idTime1
        INNER JOIN Efab_Time t2 ON t2.idTime = j.idTime2
    IF @TipoConsulta = 1
        SELECT
           t.idTime,
           t.Nome
        FROM dbo.Efab_Time t
        
        
        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Jogo_Sel

-- =======================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Inserir registro da tabela Efab_Jogo
-- ===================================

--==== INSERT ====

ALTER PROCEDURE [dbo].[stp_Efab_Jogo_Ins](
    @IdTime1 INT = NULL,
    @IdTime2 INT = NULL,
    @Placar1 INT = NULL,
    @Placar2 INT = NULL

)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)


        IF @IdTime1 IS NULL
        BEGIN
            RAISERROR('Informe o time1', 16, 1)
        END

        IF @IdTime2 IS NULL
        BEGIN
            RAISERROR('Informe o time2', 16, 1)
        END

        IF @IdTime1 = @IdTime2
        BEGIN
           RAISERROR('Operação cancelada. Não foi possível adicionar o jogo com times iguais informado pelo ID', 16, 1)
        END

        IF NOT EXISTS (
            SELECT idTime
            FROM Efab_Time
            WHERE idTime = @idTime1
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o time informado pelo ID %d', 16, 1, @IdTime1)
        END

        IF NOT EXISTS (
            SELECT idTime
            FROM Efab_Time
            WHERE idTime = @idTime2
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o time informado pelo ID %d', 16, 1, @IdTime2)
        END

        INSERT Efab_Jogo(idTime1, idTime2)
        VALUES (@IdTime1, @IdTime2)

        
        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Jogo_Ins @IdTime1 = 2, @IdTime2 = 2, @Placar1 = 2, @Placar2 = 3

EXEC dbo.stp_Efab_Jogo_Sel


-- =================================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Atualizar registro da tabela Efab_Jogo
-- =================================================

--==== UPDATE ====

ALTER PROCEDURE [dbo].[stp_Efab_Jogo_Upd](
    @IdJogo INT = NULL,
    @IdTime1 INT = NULL,
    @IdTime2 INT = NULL,
    @Placar1 INT = NULL,
    @Placar2 INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)

        IF @IdJogo IS NULL
        BEGIN
            RAISERROR('Informe o ID do Jogador', 16, 1)
        END

        IF @IdTime1 IS NULL
        BEGIN
            RAISERROR('Informe o nome do Jogador', 16, 1)
        END

        IF @IdTime2 IS NULL
        BEGIN
            RAISERROR('Informe o ID do time', 16, 1)
        END

        IF @IdTime1 = @IdTime2
        BEGIN
           RAISERROR('Operação cancelada. Não foi possível atualizar o jogo com times iguais', 16, 1)
        END

        IF NOT EXISTS (
            SELECT idJogo
            FROM Efab_Jogo
            WHERE idJogo = @IdJogo
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o jogo informado pelo ID %d', 16, 1, @IdJogo)
        END

        IF NOT EXISTS (
            SELECT idTime
            FROM Efab_Time
            WHERE idTime = @IdTime1
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o time informado pelo ID %d', 16, 1, @IdTime1)
        END

        IF NOT EXISTS (
            SELECT idTime
            FROM Efab_Time
            WHERE idTime = @IdTime2
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o time informado pelo ID %d', 16, 1, @IdTime2)
        END


        UPDATE Efab_Jogo SET 
            idTime1 = @IdTime1,
            idTime2 = @IdTime2
        WHERE idJogo = @IdJogo


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Jogo_Upd @IdJogo = 7, @IdTime1 = 3, @IdTime2 = 2, @Placar1 = 3, @Placar2 = 3

EXEC dbo.stp_Efab_Jogo_Sel

-- ===============================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Deletar registro da tabela Efab_Jogo
-- ===============================================

--==== DELETE ====

ALTER PROCEDURE [dbo].[stp_Efab_Jogo_Del](
    @IdJogo INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)
        
        IF @IdJogo IS NULL
        BEGIN
            RAISERROR('Informe o ID do jogo', 16, 1)
        END


        IF EXISTS (
            SELECT idJogo
            FROM Efab_Participacao
            WHERE idJogo = @IdJogo
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível deletar o jogo pois está vinculado a uma participacao', 16, 1)
        END

        IF NOT EXISTS (
            SELECT idJogo
            FROM Efab_Jogo
            WHERE idJogo = @IdJogo
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o jogo informado pelo ID %d', 16, 1, @IdJogo)
        END

        DELETE Efab_Jogo
        WHERE idJogo = @IdJogo


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Jogo_Del @IdJogo = 7

EXEC dbo.stp_Efab_Jogo_Sel


-- ==========================================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Selecionar registro da tabela Efab_Participacao
-- ==========================================================

--======== PARTICIPAÇÃO ==========

--==== SELECT ====

CREATE PROCEDURE [dbo].[stp_Efab_Participacao_Sel]
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)

        SELECT 
            idParticipacao,
            t1.Nome AS Time1,
            t2.Nome AS Time2,
            j.Placar1,
            j.Placar2,
            jogr.Nome AS Jogador,
            part.GolsMarcados
        FROM dbo.Efab_Participacao part
        INNER JOIN dbo.Efab_Jogo j ON j.idJogo = part.idJogo
        INNER JOIN Efab_Time t1 ON t1.idTime = j.idTime1
        INNER JOIN Efab_Time t2 ON t2.idTime = j.idTime2
        INNER JOIN dbo.Efab_Jogador jogr ON jogr.idJogador = part.idJogador

        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Participacao_Sel


-- =======================================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Inserir registro da tabela Efab_Participacao
-- =======================================================

--==== INSERT ====

ALTER PROCEDURE [dbo].[stp_Efab_Participacao_Ins](
    @IdJogo INT = NULL,
    @IdJogador INT = NULL,
    @GolsMarcados INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)


        IF @IdJogo IS NULL
        BEGIN
            RAISERROR('Informe o time1', 16, 1)
        END

        IF @IdJogador IS NULL
        BEGIN
            RAISERROR('Informe o time2', 16, 1)
        END

        IF @GolsMarcados IS NULL
        BEGIN
            RAISERROR('Informe o Gol', 16, 1)
        END

        IF @GolsMarcados <= 0 
        BEGIN
            RAISERROR('Operação cancelada. Não é possível cadastrar gols marcados menor ou igual a 0 ', 16, 1)
        END

        IF NOT EXISTS (
            SELECT idJogo
            FROM Efab_Jogo
            WHERE idJogo = @IdJogo
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o jogo informado pelo ID %d', 16, 1, @IdJogo)
        END

        IF NOT EXISTS (
            SELECT idJogador
            FROM Efab_Jogador
            WHERE idJogador = @IdJogador
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o jogador informado pelo ID %d', 16, 1, @IdJogador)
        END

        INSERT Efab_Participacao(idJogo, idJogador, GolsMarcados)
        VALUES (@IdJogo, @IdJogador, @GolsMarcados)

        
        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC DBO.stp_Efab_Participacao_Ins @IdJogo = 1, @IdJogador = 1, @GolsMarcados = 4
exec dbo.stp_Efab_Participacao_Sel


-- =========================================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Atualizar registro da tabela Efab_Participacao
-- =========================================================

--==== UPDATE ====

CREATE PROCEDURE [dbo].[stp_Efab_Participacao_Upd](
    @IdParticipacao INT = NULL, 
    @IdJogo INT = NULL,
    @IdJogador INT = NULL,
    @GolsMarcados INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)

        IF @IdParticipacao IS NULL
        BEGIN
            RAISERROR('Informe o nome do Jogador', 16, 1)
        END

        IF @IdJogo IS NULL
        BEGIN
            RAISERROR('Informe o ID do Jogador', 16, 1)
        END

        IF @IdJogador IS NULL
        BEGIN
            RAISERROR('Informe o ID do time', 16, 1)
        END

        IF @GolsMarcados IS NULL
        BEGIN
            RAISERROR('Informe o ID do time', 16, 1)
        END

        IF NOT EXISTS (
            SELECT idParticipacao
            FROM Efab_Participacao
            WHERE idParticipacao = @IdParticipacao
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o jogo informado pelo ID %d', 16, 1, @IdParticipacao)
        END

        IF NOT EXISTS (
            SELECT idJogo
            FROM Efab_Jogo
            WHERE idJogo = @IdJogo
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o jogo informado pelo ID %d', 16, 1, @IdJogo)
        END

        IF NOT EXISTS (
            SELECT idJogador
            FROM Efab_Jogador
            WHERE idJogador = @IdJogador
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o time informado pelo ID %d', 16, 1, @IdJogador)
        END


        UPDATE Efab_Participacao SET 
            idJogo = @IdJogo,
            idJogador = @IdJogador,
            GolsMarcados = @GolsMarcados
        WHERE idParticipacao = @IdParticipacao


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

exec dbo.stp_Efab_Participacao_Upd @IdParticipacao = 8, @IdJogo = 1, @IdJogador = 1, @GolsMarcados = 3
exec dbo.stp_Efab_Participacao_Sel


-- =======================================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Deletar registro da tabela Efab_Participacao
-- =======================================================

--==== DELETE ====

CREATE PROCEDURE [dbo].[stp_Efab_Participacao_Del](
    @IdParticipacao INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)
        
        IF @IdParticipacao IS NULL
        BEGIN
            RAISERROR('Informe o ID da Participacao', 16, 1)
        END


        IF NOT EXISTS (
            SELECT idParticipacao
            FROM Efab_Participacao
            WHERE idParticipacao = @IdParticipacao
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar a participacao informado pelo ID %d', 16, 1, @IdParticipacao)
        END

        DELETE Efab_Participacao
        WHERE idParticipacao = @IdParticipacao


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

exec dbo.stp_Efab_Participacao_Del @IdParticipacao = 8
exec dbo.stp_Efab_Participacao_Sel

-- ==========================================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Selecionar registro da tabela Efab_Artilharia
-- ==========================================================

--======= ARTILHARIA ========

CREATE PROCEDURE [dbo].[stp_Efab_Artilharia_Sel]
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)

        SELECT 
		t.Nome AS Time,
		jogr.Nome AS Artilheiro,
		SUM(part.GolsMarcados) AS GolsMarcados
	    FROM dbo.Efab_Time t
	        INNER JOIN dbo.Efab_Jogador jogr
		        ON jogr.idTime = t.idTime
	        INNER JOIN dbo.Efab_Participacao part
		        ON part.idJogador = jogr.idJogador
	    GROUP BY t.idTime, t.Nome, jogr.Nome
	    HAVING 
		    SUM(part.GolsMarcados) = 
			    (SELECT MAX(SomaGols)
			     FROM ( 
				    SELECT 
					    SUM(part2.GolsMarcados) AS SomaGols
				        FROM dbo.Efab_Jogador jogr2
				        INNER JOIN dbo.Efab_Participacao part2
					        ON part2.idJogador = jogr2.idJogador
				        WHERE jogr2.idTime = t.idTime
				        GROUP BY jogr2.idJogador
			        ) x
		        )
	     ORDER BY SUM(part.GolsMarcados) DESC

        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Artilharia_Sel

-- ==========================================================
-- Autora: Estelita Fernanda
-- Data criação: 06/02/2026
-- Descrição: Selecionar registro da tabela Efab_Classificacao
-- ==========================================================


--==== Classificação ====


CREATE PROCEDURE [dbo].[stp_Efab_Classificacao_Sel]
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)

        SELECT 
		    t.Nome,
		    SUM(CASE 
				    WHEN t.idTime = j.idTime1 AND j.Placar1 > j.Placar2 THEN 3 
				    WHEN t.idTime = j.idTime2 AND j.Placar2 > j.Placar1 THEN 3 
				    WHEN t.idTime = j.idTime1 AND j.Placar1 = j.Placar2 THEN 1
				    WHEN t.idTime = j.idTime2 AND j.Placar2 = j.Placar1 THEN 1
			    END
		    ) AS Pontos,
		    SUM(CASE 
			    WHEN t.idTime = j.idTime1 THEN j.Placar1 - j.Placar2
			    WHEN t.idTime = j.idTime2 THEN j.Placar2 - j.Placar1
		    END
		    ) AS SaldoGols,
		    SUM(CASE 
				    WHEN t.idTime = j.idTime1 THEN j.Placar1
				    WHEN t.idTime = j.idTime2 THEN j.Placar2
			    END
		    ) AS GolsMarcados
	    FROM dbo.Efab_Time t
	    INNER JOIN dbo.Efab_Jogo j
		    ON j.idTime1 = t.idTime OR j.idTime2 = t.idTime
	    GROUP BY t.Nome
	    ORDER BY Pontos DESC

        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

EXEC dbo.stp_Efab_Classificacao_Sel