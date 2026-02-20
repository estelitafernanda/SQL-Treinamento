USE dbTreinamento


--SELECT SISTEMA--

CREATE PROCEDURE [dbo].[stp_Efab_Sistema_Sel]
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)

        SELECT 
            idSistema,
            Codigo,
            Caption
        FROM dbo.Efab_Sistema

        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

--INSERT SISTEMA--

CREATE PROCEDURE [dbo].[stp_Efab_Sistema_Ins](
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

        IF EXISTS (
            SELECT *
            FROM Efab_Sistema
            WHERE Codigo = @Codigo
        )
        BEGIN
            RAISERROR('Sistema ja cadastrado com esse código', 16, 1)
        END

        INSERT Efab_Sistema(Codigo, Caption)
        VALUES (@Codigo, @Caption)

        

        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

---UPDATE SISTEMA---

CREATE PROCEDURE [dbo].[stp_Efab_Sistema_Upd](
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
            RAISERROR('Operação cancelada. Não foi possível identificar o sistema', 16, 1)
        END

        IF EXISTS(
            SELECT *
            FROM Efab_Sistema
            WHERE Codigo = @Codigo
        )
        BEGIN
            RAISERROR('Operação cancelada. Já existe um sistema com esse código', 16, 1)
        END


        UPDATE Efab_Sistema SET 
            Codigo = @Codigo,
            Caption = @Caption
        WHERE idSistema = @IdSistema


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

---DELETE SISTEMA---

ALTER PROCEDURE [dbo].[stp_Efab_Sistema_Del](
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
        
        IF @IdSistema IS NULL
        BEGIN
            RAISERROR('Não foi possível encontrar o sistema', 16, 1)
        END


        IF NOT EXISTS (
            SELECT idSistema
            FROM Efab_Sistema
            WHERE idSistema = @IdSistema
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar o sistema', 16, 1)
        END

        IF EXISTS(
            SELECT idSistema
            FROM Efab_Modulo
            WHERE idSistema = @IdSistema
        )
        BEGIN
            RAISERROR('Operação cancelada. Não é possível apagar esse sistema pois ele já está vinculado a um módulo', 16, 1)
        END

        DELETE Efab_Sistema
        WHERE idSistema = @IdSistema


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END