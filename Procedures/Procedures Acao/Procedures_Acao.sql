USE dbTreinamento


--SELECT AÇÃO--

CREATE PROCEDURE [dbo].[stp_Efab_Acao_Sel](
    @TipoConsulta INT = NULL,
    @IdAcao INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)
    IF @TipoConsulta = 0
    BEGIN
        SELECT
            a.idAcao,
            p.idPagina,
            a.Codigo,
            a.Caption,
            a.NomeProcedure,
            p.Codigo AS CodigoPagina,
            p.Caption AS CaptionPagina,
            m.idModulo,
            m.Codigo AS CodigoModulo,
            m.Caption AS CaptionModulo,
            s.idSistema,
            s.Codigo AS CodigoSistema,
            s.Caption AS CaptionSistema
        FROM dbo.Efab_Acao a
        INNER JOIN Efab_Pagina p ON p.idPagina = a.idPagina
        INNER JOIN Efab_Modulo m ON m.idModulo = p.idModulo
        INNER JOIN Efab_Sistema s ON s.idSistema = m.idSistema
        WHERE idAcao = @IdAcao OR @IdAcao IS NULL
    END
    IF @TipoConsulta = 0
    BEGIN
        SELECT 
            idPagina,
            Codigo,
            Caption
        FROM Efab_Pagina
    END
        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

--INSERT AÇÃO--

ALTER PROCEDURE [dbo].[stp_Efab_Acao_Ins](
    @IdAcao INT = NULL,
    @IdPagina INT = NULL,
    @Codigo VARCHAR(50) = NULL,
    @Caption VARCHAR(50) = NULL,
    @NomeProcedure VARCHAR(100) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255), 
            @Erro BIT


        IF @IdPagina IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'idPagina', 'Informe a página da ação')
            SET @Erro = 1
        END

        IF @Codigo IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'codigo', 'Informe o codigo da ação')
            SET @Erro = 1
        END

        IF @Caption IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'caption', 'Informe o caption da ação')
            SET @Erro = 1
        END
        IF @NomeProcedure IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'nomeProcedure', 'Informe o nome da procedure da ação')
            SET @Erro = 1
        END


        IF @Erro = 1 RETURN 1 

        IF NOT EXISTS(
            SELECT *
            FROM Efab_Pagina
            WHERE idPagina = @IdPagina
        )
        BEGIN
            RAISERROR('Não existe essa página', 16, 1)
        END

        IF EXISTS (
            SELECT *
            FROM Efab_Acao
            WHERE Codigo = @Codigo
        )
        BEGIN
            RAISERROR('Ação ja cadastrado com esse código', 16, 1)
        END

        INSERT Efab_Acao(idPagina, Codigo, Caption, NomeProcedure)
        VALUES (@IdPagina, @Codigo, @Caption, @NomeProcedure)

        
        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

---UPDATE AÇÃO---

ALTER PROCEDURE [dbo].[stp_Efab_Acao_Upd](
    @IdAcao INT = NULL,
    @IdPagina INT = NULL,
    @Codigo VARCHAR(50) = NULL,
    @Caption VARCHAR(50) = NULL,
    @NomeProcedure VARCHAR(100) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255), @Erro BIT 

         IF @IdPagina IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'idPagina', 'Informe a página da ação')
            SET @Erro = 1
        END

        IF @Codigo IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'codigo', 'Informe o codigo da ação')
            SET @Erro = 1
        END

        IF @Caption IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'caption', 'Informe o caption da ação')
            SET @Erro = 1
        END
        IF @NomeProcedure IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'nomeProcedure', 'Informe o nome da procedure da ação')
            SET @Erro = 1
        END

        IF @Erro = 1 RETURN 1 

        IF NOT EXISTS(
            SELECT idPagina
            FROM Efab_Pagina
            WHERE idPagina = @IdPagina
        )
        BEGIN
            RAISERROR('Não existe essa página', 16, 1)
        END

         IF EXISTS (
            SELECT *
            FROM Efab_Acao
            WHERE Codigo = @Codigo
        )
        BEGIN
            RAISERROR('Ação ja cadastrado com esse código', 16, 1)
        END


        UPDATE Efab_Acao SET 
            idPagina = @IdPagina,
            Codigo = @Codigo,
            Caption = @Caption, 
            NomeProcedure = @NomeProcedure
        WHERE idAcao = @IdAcao


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

---DELETE AÇÃO---

CREATE PROCEDURE [dbo].[stp_Efab_Acao_Del](
    @IdAcao INT = NULL,
    @IdPagina INT = NULL,
    @Codigo VARCHAR(50) = NULL,
    @Caption VARCHAR(50) = NULL,
    @NomeProcedure VARCHAR(100) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)
        
        IF @IdAcao IS NULL
        BEGIN
            RAISERROR('Não foi possível encontrar a ação', 16, 1)
        END


        IF NOT EXISTS (
            SELECT idAcao
            FROM Efab_Acao
            WHERE idAcao = @IdAcao
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar a página', 16, 1)
        END
        IF EXISTS(
            SELECT idAcao
            FROM Efab_Autorizacao
            WHERE idAcao = @IdAcao
        )
        BEGIN
            RAISERROR('Operação cancelada. Não é possível apagar essa página pois ele já está vinculado a uma ação', 16, 1)
        END

        DELETE Efab_Acao
        WHERE idAcao = @IdAcao 


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END