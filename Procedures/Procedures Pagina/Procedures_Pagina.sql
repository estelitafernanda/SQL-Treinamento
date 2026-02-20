USE dbTreinamento


--SELECT PÁGINA--

ALTER PROCEDURE [dbo].[stp_Efab_Pagina_Sel](
    @TipoConsulta INT = NULL,
    @IdPagina INT = NULL
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
            p.idPagina,
            m.idModulo,
            p.Codigo,
            p.Caption,
            m.Codigo AS CodigoModulo,
            m.Caption AS CaptionModulo,
            s.idSistema,
            s.Codigo AS CodigoSistema,
            s.Caption AS CaptionSistema
        FROM dbo.Efab_Pagina p
        INNER JOIN Efab_Modulo m ON m.idModulo = p.idModulo
        INNER JOIN Efab_Sistema s ON s.idSistema = m.idSistema
        WHERE idPagina = @IdPagina OR @IdPagina IS NULL
    END
    IF @TipoConsulta = 1
    BEGIN
        SELECT 
            idModulo,
            Codigo,
            Caption
        FROM dbo.Efab_Modulo
        
    END
        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

--INSERT PÁGINA--

CREATE PROCEDURE [dbo].[stp_Efab_Pagina_Ins](
    @IdPagina INT = NULL,
    @IdModulo INT = NULL,
    @Codigo VARCHAR(50) = NULL,
    @Caption VARCHAR(50) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255), 
            @Erro BIT


        IF @IdModulo IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'idModulo', 'Informe o modulo da página')
            SET @Erro = 1
        END

        IF @Codigo IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'codigo', 'Informe o codigo da página')
            SET @Erro = 1
        END

        IF @Caption IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'caption', 'Informe o caption da página')
            SET @Erro = 1
        END


        IF @Erro = 1 RETURN 1 

        IF NOT EXISTS(
            SELECT *
            FROM Efab_Modulo
            WHERE idModulo = @IdModulo
        )
        BEGIN
            RAISERROR('Não existe esse módulo', 16, 1)
        END

        IF EXISTS (
            SELECT *
            FROM Efab_Pagina
            WHERE Codigo = @Codigo
        )
        BEGIN
            RAISERROR('Página ja cadastrado com esse código', 16, 1)
        END

        INSERT Efab_Pagina(idModulo, Codigo, Caption)
        VALUES (@IdModulo, @Codigo, @Caption)

        

        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

---UPDATE PÁGINA---

CREATE PROCEDURE [dbo].[stp_Efab_Pagina_Upd](
    @IdPagina INT = NULL,
    @IdModulo INT = NULL,
    @Codigo VARCHAR(50) = NULL,
    @Caption VARCHAR(50) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255), @Erro BIT 

        IF @IdModulo IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'idModulo', 'Informe o modulo da página')
            SET @Erro = 1
        END

        IF @Codigo IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'codigo', 'Informe o codigo da página')
            SET @Erro = 1
        END

        IF @Caption IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'caption', 'Informe o caption da página')
            SET @Erro = 1
        END


        IF @Erro = 1 RETURN 1 

        IF NOT EXISTS(
            SELECT idModulo
            FROM Efab_Modulo
            WHERE idModulo = @IdModulo
        )
        BEGIN
             RAISERROR('Operação cancelada. Esse módulo não existe', 16, 1)
        END


        IF NOT EXISTS (
            SELECT idPagina
            FROM Efab_Pagina
            WHERE idPagina = @IdPagina
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar a página', 16, 1)
        END

        IF EXISTS(
            SELECT *
            FROM Efab_Pagina
            WHERE Codigo = @Codigo
        )
        BEGIN
            RAISERROR('Operação cancelada. Já existe uma página com esse código', 16, 1)
        END


        UPDATE Efab_Pagina SET 
            idModulo = @IdModulo,
            Codigo = @Codigo,
            Caption = @Caption
        WHERE idPagina = @IdPagina


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

---DELETE PÁGINA---

ALTER PROCEDURE [dbo].[stp_Efab_Pagina_Del](
    @IdPagina INT = NULL,
    @IdModulo INT = NULL,
    @Codigo VARCHAR(50) = NULL,
    @Caption VARCHAR(50) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)
        
        IF @IdPagina IS NULL
        BEGIN
            RAISERROR('Não foi possível encontrar a página', 16, 1)
        END


        IF NOT EXISTS (
            SELECT idPagina
            FROM Efab_Pagina
            WHERE idPagina = @IdPagina
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar a página', 16, 1)
        END
        IF EXISTS(
            SELECT idPagina
            FROM Efab_Acao
            WHERE idPagina = @IdPagina
        )
        BEGIN
            RAISERROR('Operação cancelada. Não é possível apagar essa página pois ele já está vinculado a uma ação', 16, 1)
        END

        DELETE Efab_Pagina
        WHERE idPagina = @IdPagina


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END