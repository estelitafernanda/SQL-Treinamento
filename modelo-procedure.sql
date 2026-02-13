/*
Objetivo: Procedure para selecionar de dados da tabela
Criado por: Noélio Dutra
Data criação: 17/05/2023
*/
CREATE TABLE PessoaFJ(
	TipoDocumento INT,
	Documento VARCHAR(14),
	Nome VARCHAR(40),
	DataNascimento VARCHAR(10)
)

SELECT * FROM PessoaFJ


ALTER PROCEDURE [dbo].[stp_Procedure_Sel]
(
    @TipoDocumento INT,
	@Documento VARCHAR(14),
	@Nome VARCHAR(40),
	@DataNascimento VARCHAR(10)
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)

        IF @TipoDocumento IS NULL
        BEGIN
            RAISERROR('Informe o Tipo do Documento', 16, 1)
        END
		IF @Documento IS NULL
        BEGIN
            RAISERROR('Informe o Documento', 16, 1)
        END
		IF @Nome IS NULL
        BEGIN
            RAISERROR('Informe o Nome', 16, 1)
        END
		IF @DataNascimento IS NULL
        BEGIN
            RAISERROR('Informe a Data de Nascimento', 16, 1)
        END

		DECLARE @ResultadoConcatenacao VARCHAR(63)


        SET @ResultadoConcatenacao = 
            CONCAT(CAST(@TipoDocumento AS VARCHAR), @Documento, @Nome, REPLACE(@DataNascimento, '/', ''))
	

		SET @ResultadoConcatenacao = 
		CONCAT(SUBSTRING(@ResultadoConcatenacao, 1, LEN(@ResultadoConcatenacao) - 8 ) , REPLICATE(' ', 63 - LEN(@ResultadoConcatenacao)), SUBSTRING(@ResultadoConcatenacao, LEN(@ResultadoConcatenacao) - 7, 10)) 

		SELECT @ResultadoConcatenacao AS ResultadoEsperado

        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END



DELETE FROM PessoaFJ

EXEC [dbo].[stp_Procedure_Sel] @TipoDocumento = 2, @Documento = '12345678909', @Nome = 'MACHADO DE ASSIS', @DataNascimento = '21/06/1839'





