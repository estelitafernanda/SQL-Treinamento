
-- Exercicio Função Ler
ALTER FUNCTION dbo.funcao_ler_transacao (@Entrada TEXT)
RETURNS TABLE
AS 
RETURN (
	SELECT 
		CASE 
			WHEN CAST(SUBSTRING(@Entrada, 1, 1) AS INT ) =  1 THEN 'CPF' 
			WHEN CAST(SUBSTRING(@Entrada, 1, 1) AS INT ) =  2 THEN 'CNPJ'
			ELSE 'Inválido'
		END AS TipoDocumento, 
		CAST(SUBSTRING(@Entrada, 2, 14) AS BIGINT) AS Documento,
		TRIM(SUBSTRING(@Entrada, 16, 39)) AS Nome, 
		FORMAT(CAST(CONCAT(SUBSTRING(@Entrada, 59, 4), '-', SUBSTRING(@Entrada, 57, 2), '-' ,SUBSTRING(@Entrada, 55, 2)) AS DATE), 'dd/MM/yyyy') AS DataNascimento
)

SELECT * FROM dbo.funcao_ler_transacao('100012345678909MACHADO DE ASSIS                       21061839')

SELECT * FROM dbo.funcao_ler_transacao('203406710000104LOG TECNOLOGIA E SISTEMAS              20091999')


-- Função Formatar Texto
ALTER FUNCTION dbo.funcao_formatar_texto(@Entrada VARCHAR(100), @QuantidadeCaracteres INT, @TipoTexto VARCHAR(1))
RETURNS VARCHAR(100)
AS
BEGIN
	IF LEN(@Entrada) >= @QuantidadeCaracteres 
	BEGIN
		RETURN @Entrada
	END
	RETURN 
		CASE 
			WHEN @TipoTexto = 'N' THEN RIGHT(REPLICATE('0', @QuantidadeCaracteres)  + @Entrada, @QuantidadeCaracteres)
			WHEN @TipoTexto = 'C' THEN LEFT(@Entrada + REPLICATE(' ', @QuantidadeCaracteres), @QuantidadeCaracteres) 
			ELSE @Entrada
		END 
END

SELECT dbo.funcao_formatar_texto('35', 1, 'N')


-- Exercicício Algoritmo da Chave HASH
ALTER FUNCTION dbo.funcao_hash(@Hash VARCHAR(25))
RETURNS VARCHAR(25)
AS 
BEGIN
DECLARE @HashPosicaoFinal CHAR(1)
DECLARE @Digito INT

	SET @HashPosicaoFinal = SUBSTRING(@Hash, LEN(@Hash), 1)
	SET @Digito =
		CASE 
			WHEN @HashPosicaoFinal IN ('9','X','G') THEN 1
			WHEN @HashPosicaoFinal IN ('F','H','0') THEN 2
			WHEN @HashPosicaoFinal IN ('C','M','5','K') THEN 3
			WHEN @HashPosicaoFinal IN ('A','E','I','6') THEN 4
			WHEN @HashPosicaoFinal IN ('L','N','D','8') THEN 5
			WHEN @HashPosicaoFinal IN ('1','S','O','P') THEN 6
			WHEN @HashPosicaoFinal IN ('V','T','3') THEN 7
			WHEN @HashPosicaoFinal IN ('W','2','Y','J') THEN 8
			WHEN @HashPosicaoFinal IN ('4','Q','U','R') THEN 9
			WHEN @HashPosicaoFinal IN ('7','B','Z') THEN 0
	END

DECLARE @p1 VARCHAR(6) = SUBSTRING(@Hash, 1, 6)
DECLARE @p2 VARCHAR(6) = SUBSTRING(@Hash, 7, 6)
DECLARE @p3 VARCHAR(6) = SUBSTRING(@Hash, 13, 6)
DECLARE @p4 VARCHAR(6) = SUBSTRING(@Hash, 19, 6)
DECLARE @hashReposicionado VARCHAR(25)

SET @hashReposicionado = 
	CASE 
        WHEN @digito IN (0,1) THEN CONCAT(@p4, @p2, @p3, @p1, CAST(@Digito AS VARCHAR))
        WHEN @digito IN (2,3) THEN CONCAT(@p3, @p1, @p2, @p4, CAST(@Digito AS VARCHAR))
        WHEN @digito IN (4,5) THEN CONCAT(@p1, @p3, @p4, @p2, CAST(@Digito AS VARCHAR))
        WHEN @digito IN (6,7) THEN CONCAT(@p4, @p2, @p1, @p3, CAST(@Digito AS VARCHAR))
        WHEN @digito IN (8,9) THEN CONCAT(@p2, @p4, @p3, @p1, CAST(@Digito AS VARCHAR))
    END

	DECLARE @i INT = 1
	DECLARE @Resultado VARCHAR(25) = ''
	DECLARE @c CHAR(1)

	WHILE @i <= 24
    BEGIN
        SET @c = SUBSTRING(@hashReposicionado, @i, 1);

        SET @Resultado = @Resultado +
        CASE 
            WHEN @c IN ('9','X','G') THEN '1'
            WHEN @c IN ('F','H','0') THEN '2'
            WHEN @c IN ('C','M','5','K') THEN '3'
            WHEN @c IN ('A','E','I','6') THEN '4'
            WHEN @c IN ('L','N','D','8') THEN '5'
            WHEN @c IN ('1','S','O','P') THEN '6'
            WHEN @c IN ('V','T','3') THEN '7'
            WHEN @c IN ('W','2','Y','J') THEN '8'
            WHEN @c IN ('4','Q','U','R') THEN '9'
            WHEN @c IN ('7','B','Z') THEN '0'
        END

        SET @i = @i + 1
	END
	RETURN @Resultado + CAST(@Digito AS VARCHAR)
END

SELECT dbo.funcao_hash('KRVK8XB60BXXXBK8BJ68B6PV0 ');
