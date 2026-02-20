USE dbTreinamento


--SELECT Modulo--

ALTER PROCEDURE [dbo].[stp_Efab_Modulo_Sel](
    @TipoConsulta INT = NULL,
    @IdModulo INT = NULL
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
            m.idModulo,
            s.idSistema,
            m.Codigo AS CodigoModulo,
            m.Caption AS CodigoModulo,
            s.Codigo AS CodigoSistema,
            s.Caption AS CaptionSistema
        FROM dbo.Efab_Modulo m
        INNER JOIN Efab_Sistema s ON s.idSistema = m.idSistema
        WHERE idModulo = @IdModulo OR @IdModulo IS NULL

    END
    IF @TipoConsulta = 1
    BEGIN
        SELECT 
            idSistema,
            Codigo,
            Caption
        FROM Efab_Sistema
    END
        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

--INSERT MÓDULO--

CREATE PROCEDURE [dbo].[stp_Efab_Modulo_Ins](
    @IdModulo INT = NULL,
    @IdSistema INT = NULL,
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

        IF @IdSistema IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'idSistema', 'Informe o sistema do módulo')
            SET @Erro = 1
        END

        IF @Codigo IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'codigo', 'Informe o codigo do módulo')
            SET @Erro = 1
        END

        IF @Caption IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'caption', 'Informe o caption do módulo')
            SET @Erro = 1
        END


        IF @Erro = 1 RETURN 1 


        IF NOT EXISTS (
            SELECT *
            FROM Efab_Sistema
            WHERE idSistema = @IdSistema
        )
        BEGIN
            RAISERROR('Operação cancelada. Não existe esse sistema', 16, 1)
        END

        IF EXISTS (
            SELECT *
            FROM Efab_Modulo
            WHERE Codigo = @Codigo
        )
        BEGIN
            RAISERROR('Módulo já cadastrado com esse código', 16, 1)
        END

        INSERT Efab_Modulo(idSistema, Codigo, Caption)
        VALUES (@IdSistema, @Codigo, @Caption)


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

---UPDATE MÓDULO---

CREATE PROCEDURE [dbo].[stp_Efab_Modulo_Upd](
    @IdModulo INT = NULL,
    @IdSistema INT = NULL,
    @Codigo VARCHAR(50) = NULL,
    @Caption VARCHAR(50) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255), @Erro BIT 

        IF @IdSistema IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'idSistema', 'Informe o sistema do módulo')
            SET @Erro = 1
        END

        IF @Codigo IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'codigo', 'Informe o codigo do sistema')
            SET @Erro = 1
        END

        IF @Caption IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'caption', 'Informe o caption do sistema')
            SET @Erro = 1
        END


        IF @Erro = 1 RETURN 1 

        IF NOT EXISTS (
            SELECT idSistema
            FROM Efab_Sistema
            WHERE idSistema = @IdSistema
        )
        BEGIN
            RAISERROR('Operação cancelada. Esse sistema não existe', 16, 1)
        END

        IF EXISTS(
            SELECT *
            FROM Efab_Modulo
            WHERE Codigo = @Codigo
        )
        BEGIN
            RAISERROR('Operação cancelada. Já existe um modulo com esse código', 16, 1)
        END


        UPDATE Efab_Modulo SET 
            idSistema = @IdSistema,
            Codigo = @Codigo,
            Caption = @Caption
        WHERE idModulo = @IdModulo


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

---DELETE MÓDULO---

ALTER PROCEDURE [dbo].[stp_Efab_Modulo_Del](
    @IdModulo INT = NULL, 
    @IdSistema INT = NULL,
    @Codigo VARCHAR(50) = NULL,
    @Caption VARCHAR(50) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)
        
        IF @IdModulo IS NULL
        BEGIN
            RAISERROR('Não foi possível encontrar o sistema', 16, 1)
        END


        IF NOT EXISTS (
            SELECT idModulo
            FROM Efab_Modulo
            WHERE idModulo = @IdModulo
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o sistema', 16, 1)
        END

        IF EXISTS(
            SELECT idModulo
            FROM Efab_Pagina
            WHERE idModulo = @IdModulo
        )
        BEGIN
            RAISERROR('Operação cancelada. Não é possível apagar esse modulo pois ele já está vinculado a uma página', 16, 1)
        END

        DELETE Efab_Modulo
        WHERE idModulo = @IdModulo


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END