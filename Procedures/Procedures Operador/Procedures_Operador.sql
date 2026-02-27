USE dbTreinamento


--SELECT OPERADOR--

CREATE PROCEDURE [dbo].[stp_Efab_Operador_Sel](
    @IdOperador INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)
    BEGIN
        SELECT
            o.idOperador,
            o.Cpf,
            o.Nome,
            o.Senha
        FROM dbo.Efab_Operador o
        WHERE idOperador = @IdOperador OR @IdOperador IS NULL
    END
    
        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

--INSERT OPERADOR--

CREATE PROCEDURE [dbo].[stp_Efab_Operador_Ins](
    @IdOperador INT = NULL,
    @Cpf VARCHAR(11) = NULL,
    @Nome VARCHAR(50) = NULL,
    @Senha VARCHAR(100) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255), 
            @Erro BIT


        IF @IdOperador IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'idOperador', 'Informe o operador')
            SET @Erro = 1
        END

        IF @Cpf IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'cpf', 'Informe o CPF')
            SET @Erro = 1
        END
        IF LEN(@Cpf) < 11
        BEGIN
            RAISERROR(50001, 10, 1, 'cpf', 'Faltam números no CPF')
            SET @Erro = 1
        END

        IF @Nome IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'nome', 'Informe o nome do operador')
            SET @Erro = 1
        END

        IF ISNUMERIC(@Nome) = 1
        BEGIN
            RAISERROR(50001, 10, 1, 'nome', 'O nome do operador não pode ser numérico')
            SET @Erro = 1
        END

        IF LEN(@Nome) < 3
        BEGIN
            RAISERROR(50001, 10, 1, 'nome', 'O nome não pode ter menos que 3 caracteres')
            SET @Erro = 1
        END
        IF @Senha IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'senha', 'Informe a senha')
            SET @Erro = 1
        END

        IF @Erro = 1 RETURN 1 


        INSERT Efab_Operador(Cpf, Nome, Senha)
        VALUES (@Cpf, @Nome, @Senha)

        
        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

---UPDATE OPERADOR---

CREATE PROCEDURE [dbo].[stp_Efab_Operador_Upd](
    @IdOperador INT = NULL,
    @Cpf VARCHAR(11) = NULL,
    @Nome VARCHAR(50) = NULL,
    @Senha VARCHAR(100) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255), @Erro BIT 

        IF @IdOperador IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'idOperador', 'Não foi possível encontrar esse operador')
            SET @Erro = 1
        END

        IF @Cpf IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'cpf', 'Informe o CPF')
            SET @Erro = 1
        END
        IF LEN(@Cpf) < 11
        BEGIN
            RAISERROR(50001, 10, 1, 'cpf', 'Faltam números no CPF')
            SET @Erro = 1
        END

        IF @Nome IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'nome', 'Informe o nome do operador')
            SET @Erro = 1
        END

        IF ISNUMERIC(@Nome) = 1
        BEGIN
            RAISERROR(50001, 10, 1, 'nome', 'O nome do operador não pode ser numérico')
            SET @Erro = 1
        END

        IF LEN(@Nome) < 3
        BEGIN
            RAISERROR(50001, 10, 1, 'nome', 'O nome não pode ter menos que 3 caracteres')
            SET @Erro = 1
        END
        IF @Senha IS NULL
        BEGIN
            RAISERROR(50001, 10, 1, 'senha', 'Informe a senha')
            SET @Erro = 1
        END

        IF @Erro = 1 RETURN 1 

        IF NOT EXISTS(
            SELECT idOperador
            FROM Efab_Operador
            WHERE idOperador = @IdOperador
        )
        BEGIN
            RAISERROR('Não existe esse operador', 16, 1)
        END


        UPDATE Efab_Operador SET 
            Cpf = @Cpf,
            Nome = @Nome, 
            Senha = @Senha
        WHERE idOperador = @IdOperador

        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

---DELETE OPERADOR---

CREATE PROCEDURE [dbo].[stp_Efab_Operador_Del](
    @IdOperador INT = NULL,
    @Cpf VARCHAR(11) = NULL,
    @Nome VARCHAR(50) = NULL,
    @Senha VARCHAR(100) = NULL
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)
        
        IF @IdOperador IS NULL
        BEGIN
            RAISERROR('Não foi possível encontrar esse operador', 16, 1)
        END


        IF NOT EXISTS (
            SELECT idOperador
            FROM Efab_Operador
            WHERE idOperador = @IdOperador
        )
        BEGIN
            RAISERROR('Operação cancelada. Não foi possível identificar esse operador', 16, 1)
        END
        IF EXISTS(
            SELECT idOperador
            FROM Efab_Autorizacao
            WHERE idOperador = @IdOperador
        )
        BEGIN
            RAISERROR('Operação cancelada. Não é possível apagar esse operador pois ele já está vinculado a uma autorização', 16, 1)
        END

        DELETE Efab_Operador
        WHERE idOperador = @IdOperador 


        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END