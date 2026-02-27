USE dbTreinamento


--SELECT AUTORIZACAO--

CREATE PROCEDURE [dbo].[stp_Efab_Autorizacao_Sel](
    @TipoConsulta INT = NULL,
    @IdOperador INT = NULL
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
            o.idOperador,
            o.Cpf,
            o.Nome,
            o.Senha
        FROM Efab_Operador o
    END
    IF @TipoConsulta = 1
    BEGIN
        SELECT
            s.Caption AS Sistema,
            m.Caption AS Modulo,
            p.Caption AS Pagina,
            a.Caption AS Acao,
            au.idAutorizacao 
        FROM dbo.Efab_Sistema s

        INNER JOIN Efab_Modulo m ON m.idSistema = s.idSistema
        INNER JOIN Efab_Pagina p ON p.idModulo = m.idModulo
        INNER JOIN Efab_Acao a ON a.idPagina = p.idPagina
        LEFT JOIN Efab_Autorizacao au ON au.idAcao = a.idAcao 
        WHERE au.idOperador = @IdOperador
        ORDER BY s.Caption, m.Caption, p.Caption, a.Caption
    END
    
        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END


---UPDATE AUTORIZACAO---

CREATE PROCEDURE [dbo].[stp_Efab_Autorizacao_Upd](
    @IdOperador INT = NULL,
    @Acoes VARCHAR(MAX)
)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON

        DECLARE 
            @MsgErro VARCHAR(255)

        --tabela temporária
        CREATE TABLE #AcoesSelecionadas(
            idAcao INT 
        )
        --inserindo dados na tabela temporaria
        INSERT INTO #AcoesSelecionadas(idAcao)
        SELECT CAST(value AS INT)
        FROM STRING_SPLIT(@Acoes, ',')

        --deletando as ações da tabela autorização de acordo com o operador e as ações que não existem na tabela temporária
        DELETE A
        FROM Efab_Autorizacao A
        WHERE A.idOperador = @IdOperador
        AND NOT EXISTS (
            SELECT 1
            FROM #AcoesSelecionadas T
            WHERE T.idAcao = A.idAcao
        )

        --inserindo na tabela autorização as ações que estão na tabela temporária mas que não existem na tabela autorização
        INSERT INTO Efab_Autorizacao (idOperador, idAcao)
        SELECT @IdOperador, T.idAcao
        FROM #AcoesSelecionadas T
        WHERE NOT EXISTS (
            SELECT 1
            FROM Efab_Autorizacao A
            WHERE A.idOperador = @IdOperador
            AND A.idAcao = T.idAcao
        )

        RETURN 0
    END TRY
    BEGIN CATCH
        SET @MsgErro = ERROR_MESSAGE()
         IF OBJECT_ID('tempdb..#AcoesSelecionadas') IS NOT NULL
            DROP TABLE #AcoesSelecionadas
        RAISERROR(@MsgErro, 16, 1)
        RETURN 1
    END CATCH
END

