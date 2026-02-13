USE dbTreinamento

INSERT INTO dbo.Efab_Time (Nome) VALUES 
('Brasil'), ('Croácia'), ('Austrália'), ('Japão'); 

SELECT * FROM dbo.Efab_Time

INSERT INTO dbo.Efab_Jogador (Nome, idTime) VALUES ('Kaka', 1), ('Nakamura', 4), ('Adriano', 1), ('Kovak', 2), ('John', 3), ('Wayne', 3)

SELECT * FROM dbo.Efab_Jogador

INSERT INTO dbo.Efab_Jogo (idTime1, idTime2, Placar1, Placar2) VALUES (1, 2, 1, 0), (3, 4, 3, 1), (2, 4, 1, 1), (1, 3, 1, 1), (4, 1, 1, 3)

SELECT * FROM dbo.Efab_Jogo

INSERT INTO dbo.Efab_Participacao (idJogo, idJogador, GolsMarcados) VALUES (1, 1, 1), (2, 5, 2), (2, 6, 1), (2, 2, 1), (3, 4, 1), (3, 2, 1), (4, 3, 1)

SELECT * FROM dbo.Efab_Participacao


--1 Selecionar todos os times que ganharam pelo menos uma partida

SELECT DISTINCT
	t.Nome AS Time
FROM dbo.Efab_Time t
INNER JOIN dbo.Efab_Jogo j
	ON j.idTime1 = t.idTime OR j.idTime2 = t.idTime
WHERE 
(t.idTime = j.idTime1 AND j.Placar1 > j.Placar2) 
OR 
(t.idTime = j.idTime2 AND j.Placar2 > j.Placar1)  



--2 Listar todos os times com o total de gols marcados e sofridos e o saldo de gols

SELECT 
	t.Nome,
	SUM(CASE 
			WHEN t.idTime = j.idTime1 THEN j.Placar1
			WHEN t.idTime = j.idTime2 THEN j.Placar2
		END
	) AS GolsMarcados,
	SUM(CASE 
			WHEN t.idTime = j.idTime1 THEN j.Placar2
			WHEN t.idTime = j.idTime2 THEN j.Placar1
		END 
	) AS GolsSofridos,
	SUM(CASE 
			WHEN t.idTime = j.idTime1 THEN j.Placar1 - j.Placar2
			WHEN t.idTime = j.idTime2 THEN j.Placar2 - j.Placar1
		END
	) AS SaldoGols
FROM dbo.Efab_Time t
INNER JOIN dbo.Efab_Jogo j
	ON j.idTime1 = t.idTime OR j.idTime2 = t.idTime
GROUP BY t.Nome


--3 Listar o artilheiro de cada equipe, exibindo o nome e a quantidade de gols

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
	--comparação entre a soma de gols marcados do campeonato e o maximo de gols marcados por jogador 
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
		
	--4 Selecionar o jogador que fez mais gols no campeonato

	SELECT TOP 1 WITH TIES
		jogr.Nome AS Jogador
	FROM dbo.Efab_Jogador jogr
	INNER JOIN dbo.Efab_Participacao part
		ON part.idJogador = jogr.idJogador
	GROUP BY jogr.Nome
	ORDER BY SUM(part.GolsMarcados) DESC


	
	--5 Listar a classificação dos times com base nos seguintes critérios: 
		--a) Número de Pontos (Vitória vale 3 pontos, Empate vale 1 ponto, derrota vale 0);
		--b) Saldo de Gols
		--c) Gols Marcados

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