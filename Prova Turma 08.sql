BEGIN
    SET LANGUAGE English
    --Criação Tabelas
    CREATE TABLE Res_Grupo
    (
        IdGrupo INT PRIMARY KEY,
        Nome VARCHAR(100) NOT NULL
    )

    CREATE TABLE Res_Cardapio
    (
        IdPrato INT PRIMARY KEY,
        NomePrato VARCHAR(150) NOT NULL,
        IdGrupo INT NOT NULL,
        PrecoVenda DECIMAL(10, 2),
        TempoPreparoMinutos INT,
        DescricaoPrato VARCHAR(1000),
        StatusPrato INT not null --(1-ATIVO,2-DESATIVADO)
    )

    CREATE TABLE Res_Ingrediente
    (
        IdIngrediente INT PRIMARY KEY,
        NomeIngrediente VARCHAR(100) NOT NULL,
        UnidadeMedida VARCHAR(20), -- kg, g, l, ml, um
        ValorUnitarioIngrediente DECIMAL(10, 2) NOT NULL
    )

    CREATE TABLE Res_IngredientePrato
    (
        IngredientePrato INT PRIMARY KEY,
        IdPrato INT NOT NULL,
        IdIngrediente INT NOT NULL,
        QuantidadeNecessaria DECIMAL(10, 2) NOT NULL,
    )

    CREATE TABLE Res_Procedimentos
    (
        IdProcedimento INT PRIMARY KEY,
        IdPrato INT NOT NULL,
        SequenciaExecucao INT NOT NULL,
        MinutosPasso INT,
        DescricaoEtapa VARCHAR(2000) NOT NULL
    )

    CREATE TABLE Res_Pedido
    (
        idPedido INT PRIMARY KEY,
        DataPedido DATETIME NOT NULL,
        DataEntrega DATETIME NULL,
        DataCancelamento DATETIME NULL
    )

    CREATE TABLE Res_PedidoPrato
    (
        idPedidoPrato INT PRIMARY KEY,
        idPedido INT NOT NULL,
        idPrato INT NOT NULL,
        Quantidade INT NOT NULL
    )

    --Inserção dos dados
    INSERT INTO Res_Grupo
    (
        IdGrupo,
        Nome
    )
    VALUES
    (1, 'Entradas'),
    (2, 'Pratos Principais'),
    (3, 'Sobremesas'),
    (4, 'Bebidas')

    INSERT INTO Res_Cardapio
    (
        IdPrato,
        NomePrato,
        IdGrupo,
        PrecoVenda,
        TempoPreparoMinutos,
        DescricaoPrato,
        StatusPrato
    )
    VALUES
    (1, 'Salada Caesar', 1, 28.90, 15, 'Salada com alface americana e frango', 1),
    (2, 'Filé de Frango Grelhado', 2, 39.90, 25, 'Frango grelhado com arroz e legumes', 1),
    (3, 'Lasanha à Bolonhesa', 2, 45.00, 40, 'Lasanha com molho bolonhesa', 1),
    (4, 'Pudim de Leite', 3, 18.00, 10, 'Pudim de leite condensado', 1),
    (5, 'Suco Natural de Laranja', 4, 8.50, 5, 'Suco natural', 1),
    (6, 'Sopa de Legumes', 1, 22.00, 20, 'Sopa quente de legumes', 1),
    (7, 'Bife Acebolado', 2, 42.00, 30, 'Bife com cebola', 1),
    (8, 'Mousse de Chocolate', 3, 20.00, 15, 'Mousse de chocolate', 1),
    (9, 'Refrigerante Lata', 4, 6.00, 1, 'Refrigerante em lata', 1),
    (10, 'Prato Executivo', 2, 35.00, 20, 'Arroz, feijão e carne', 1),
    (11, 'Batata Frita', 1, 18.00, 12, 'Batata frita crocante', 1),
    (12, 'Hambúrguer Artesanal', 2, 48.00, 35, 'Hambúrguer artesanal', 1),
    (13, 'Pizza Margherita', 2, 55.00, 45, 'Pizza tradicional', 1),
    (14, 'Sorvete', 3, 12.00, 2, 'Sorvete cremoso', 1),
    (15, 'Café Expresso', 4, 5.00, 2, 'Café expresso', 1),
    (16, 'Água Mineral', 4, 4.00, 1, 'Água sem gás', 1),
    (17, 'Risoto de Cogumelos', 2, 52.00, 38, 'Risoto cremoso', 1),
    (18, 'Panqueca de Carne', 2, 36.00, 28, 'Panqueca recheada', 1),
    (19, 'Torta de Limão', 3, 22.00, 18, 'Torta gelada', 1),
    (20, 'Chá Gelado', 4, 7.00, 3, 'Chá gelado natural', 1),
    (21, 'Coxinha de Frango', 1, 12.00, 10, 'Coxinha frita', 1),
    (22, 'Pastel de Carne', 1, 10.00, 8, 'Pastel frito crocante', 1),
    (23, 'Strogonoff de Frango', 2, 44.00, 30, 'Strogonoff com arroz', 1),
    (24, 'Feijoada', 2, 58.00, 60, 'Feijoada completa', 1),
    (25, 'Peixe Grelhado', 2, 46.00, 25, 'Peixe com legumes', 1),
    (26, 'Brownie', 3, 16.00, 15, 'Brownie de chocolate', 1),
    (27, 'Cheesecake', 3, 24.00, 20, 'Cheesecake de frutas vermelhas', 1),
    (28, 'Milkshake', 4, 14.00, 5, 'Milkshake cremoso', 1),
    (29, 'Suco Detox', 4, 11.00, 4, 'Suco verde detox', 1),
    (30, 'Vinho Taça', 4, 22.00, 1, 'Taça de vinho tinto', 1)

    INSERT INTO Res_Ingrediente
    (
        IdIngrediente,
        NomeIngrediente,
        UnidadeMedida,
        ValorUnitarioIngrediente
    )
    VALUES
    (1, 'Alface Americana', 'g', 0.02),
    (2, 'Frango', 'kg', 18.00),
    (3, 'Queijo Mussarela', 'kg', 32.00),
    (4, 'Carne Moída', 'kg', 29.00),
    (5, 'Massa para Lasanha', 'kg', 12.00),
    (6, 'Leite Condensado', 'um', 6.50),
    (7, 'Ovo', 'um', 1.20),
    (8, 'Laranja', 'kg', 4.50),
    (9, 'Arroz', 'kg', 6.00),
    (10, 'Legumes', 'kg', 7.50),
    (11, 'Chocolate', 'kg', 45.00),
    (12, 'Carne Bovina', 'kg', 38.00),
    (13, 'Batata', 'kg', 5.50),
    (14, 'Pão', 'um', 1.50),
    (15, 'Café', 'kg', 40.00),
    (16, 'Cogumelo', 'kg', 28.00),
    (17, 'Limão', 'kg', 6.00),
    (18, 'Sorvete Base', 'kg', 18.00),
    (19, 'Farinha de Trigo', 'kg', 4.50),
    (20, 'Óleo', 'l', 7.00),
    (21, 'Fermento', 'g', 0.03),
    (22, 'Creme de Leite', 'um', 4.80),
    (23, 'Feijão Preto', 'kg', 7.00),
    (24, 'Linguiça', 'kg', 22.00),
    (25, 'Costela Suína', 'kg', 26.00),
    (26, 'Peixe Branco', 'kg', 35.00),
    (27, 'Frutas Vermelhas', 'kg', 28.00),
    (28, 'Leite', 'l', 4.20),
    (29, 'Açúcar', 'kg', 4.00),
    (30, 'Manteiga', 'kg', 32.00),
    (31, 'Biscoito', 'kg', 18.00),
    (32, 'Espinafre', 'kg', 9.00),
    (33, 'Gengibre', 'kg', 15.00),
    (34, 'Mel', 'kg', 24.00),
    (35, 'Vinho Tinto', 'l', 45.00),
    (36, 'Frango Desfiado', 'kg', 20.00),
    (37, 'Requeijão', 'kg', 26.00),
    (38, 'Cebola', 'kg', 5.00),
    (39, 'Alho', 'kg', 14.00),
    (40, 'Pimenta', 'g', 0.05);

    INSERT INTO Res_IngredientePrato
    (
        IngredientePrato,
        IdPrato,
        IdIngrediente,
        QuantidadeNecessaria
    )
    VALUES
    (1, 1, 1, 150),
    (2, 1, 2, 0.15),
    (3, 1, 3, 0.05),
    (4, 2, 2, 0.25),
    (5, 2, 9, 0.20),
    (6, 2, 10, 0.15),
    (7, 3, 4, 0.30),
    (8, 3, 5, 0.25),
    (9, 3, 3, 0.20),
    (10, 4, 6, 1),
    (11, 4, 7, 3),
    (12, 5, 8, 0.40),
    (13, 6, 10, 0.30),
    (14, 6, 9, 0.20),
    (15, 7, 12, 0.30),
    (16, 7, 10, 0.10),
    (17, 8, 11, 0.15),
    (18, 8, 7, 2),
    (19, 9, 14, 1),
    (20, 10, 9, 0.25),
    (21, 10, 12, 0.20),
    (22, 11, 13, 0.30),
    (23, 12, 12, 0.25),
    (24, 12, 14, 1),
    (25, 13, 5, 0.35),
    (26, 13, 3, 0.25),
    (27, 14, 18, 0.20),
    (28, 15, 15, 0.05),
    (29, 17, 16, 0.25),
    (30, 17, 9, 0.20),
    (31, 18, 4, 0.20),
    (32, 19, 17, 0.20),
    (33, 19, 6, 1),
    (34, 20, 17, 0.15),
    (35, 21, 36, 0.15),
    (36, 21, 19, 0.10),
    (37, 21, 20, 0.05),
    (38, 22, 4, 0.12),
    (39, 22, 19, 0.10),
    (40, 22, 20, 0.04),
    (41, 23, 2, 0.25),
    (42, 23, 22, 1),
    (43, 23, 9, 0.20),
    (44, 24, 23, 0.30),
    (45, 24, 24, 0.20),
    (46, 24, 25, 0.25),
    (47, 25, 26, 0.30),
    (48, 25, 10, 0.20),
    (49, 26, 11, 0.20),
    (50, 26, 30, 0.05),
    (51, 27, 31, 0.20),
    (52, 27, 27, 0.15),
    (53, 28, 28, 0.30),
    (54, 28, 29, 0.05),
    (55, 29, 32, 0.10),
    (56, 29, 33, 0.02),
    (57, 30, 35, 0.15),
    (58, 21, 38, 0.05),
    (59, 22, 39, 0.03),
    (60, 23, 40, 0.01),
    (61, 24, 38, 0.10),
    (62, 25, 39, 0.02),
    (63, 26, 29, 0.05),
    (64, 27, 28, 0.20);

    INSERT INTO Res_Procedimentos
    (
        IdProcedimento,
        IdPrato,
        SequenciaExecucao,
        MinutosPasso,
        DescricaoEtapa
    )
    VALUES
    (1, 1, 1, 5, 'Higienizar alface'),
    (2, 1, 2, 7, 'Grelhar frango'),
    (3, 1, 3, 3, 'Misturar ingredientes'),
    (4, 2, 1, 10, 'Temperar frango'),
    (5, 2, 2, 12, 'Grelhar frango'),
    (6, 2, 3, 3, 'Montar prato'),
    (7, 2, 4, 3, 'Aquecer no micro-ondas'),
    (8, 3, 1, 15, 'Preparar molho'),
    (9, 3, 2, 10, 'Montar lasanha'),
    (10, 3, 3, 15, 'Assar no forno'),
    (11, 4, 1, 5, 'Misturar ingredientes'),
    (12, 4, 2, 5, 'Resfriar'),
    (13, 5, 1, 5, 'Espremer laranja'),
    (14, 6, 1, 10, 'Cozinhar legumes'),
    (15, 6, 2, 10, 'Finalizar sopa'),
    (16, 7, 1, 15, 'Grelhar carne'),
    (17, 7, 2, 10, 'Preparar cebola'),
    (18, 8, 1, 10, 'Derreter chocolate'),
    (19, 8, 2, 5, 'Misturar ingredientes'),
    (20, 10, 1, 8, 'Preparar arroz'),
    (21, 10, 2, 12, 'Grelhar carne'),
    (22, 12, 1, 15, 'Grelhar hambúrguer'),
    (23, 12, 2, 5, 'Montar sanduíche'),
    (24, 13, 1, 20, 'Preparar massa'),
    (25, 13, 2, 25, 'Assar pizza'),
    (26, 17, 1, 20, 'Preparar risoto'),
    (27, 18, 1, 15, 'Preparar recheio'),
    (28, 18, 2, 13, 'Montar panqueca'),
    (29, 19, 1, 10, 'Preparar creme'),
    (30, 19, 2, 8, 'Montar torta'),
    (31, 10, 3, 3, 'Aquecer no micro-ondas'),
    (72, 3, 3, 3, 'Aquecer no micro-ondas'),
    (32, 21, 1, 5, 'Preparar massa'),
    (33, 21, 2, 5, 'Fritar coxinha'),
    (34, 22, 1, 4, 'Preparar recheio'),
    (35, 22, 2, 4, 'Fritar pastel'),
    (36, 23, 1, 10, 'Preparar frango'),
    (37, 23, 2, 10, 'Adicionar molho'),
    (38, 23, 3, 10, 'Finalizar'),
    (39, 24, 1, 20, 'Cozinhar feijão'),
    (40, 24, 2, 20, 'Adicionar carnes'),
    (41, 24, 3, 20, 'Finalizar feijoada'),
    (42, 25, 1, 12, 'Temperar peixe'),
    (43, 25, 2, 13, 'Grelhar peixe'),
    (44, 26, 1, 8, 'Preparar massa'),
    (45, 26, 2, 7, 'Assar brownie'),
    (46, 27, 1, 10, 'Preparar base'),
    (47, 27, 2, 10, 'Montar cheesecake'),
    (48, 28, 1, 3, 'Bater ingredientes'),
    (49, 29, 1, 2, 'Preparar suco'),
    (50, 30, 1, 1, 'Servir vinho'),
    (51, 21, 3, 3, 'Finalizar'),
    (52, 22, 3, 2, 'Escorrer óleo'),
    (53, 23, 4, 3, 'Aquecer'),
    (54, 24, 4, 5, 'Ajustar tempero'),
    (55, 25, 3, 3, 'Finalizar'),
    (56, 26, 3, 2, 'Resfriar'),
    (57, 27, 3, 3, 'Geladeira'),
    (58, 28, 2, 2, 'Servir'),
    (59, 29, 2, 2, 'Servir'),
    (60, 30, 2, 1, 'Servir'),
    (61, 21, 4, 2, 'Montagem'),
    (62, 22, 4, 2, 'Montagem'),
    (63, 23, 5, 2, 'Montagem'),
    (64, 24, 5, 3, 'Montagem'),
    (65, 25, 4, 2, 'Montagem'),
    (66, 26, 4, 2, 'Montagem'),
    (67, 27, 4, 2, 'Montagem'),
    (68, 28, 3, 1, 'Montagem'),
    (69, 29, 3, 1, 'Montagem'),
    (70, 30, 3, 1, 'Montagem'),
    (71, 30, 4, 1, 'Finalizar');

    
    INSERT INTO Res_Pedido
    (
        IdPedido,
        DataPedido,
        DataEntrega,
        DataCancelamento
    )
    VALUES
    (1, '2025-06-01 12:00', '2025-06-01 12:45', NULL),
    (2, '2025-06-01 13:10', '2025-06-01 13:55', NULL),
    (3, '2025-06-02 19:00', '2025-06-02 19:50', NULL),
    (4, '2025-06-02 20:30', '2025-06-02 21:20', NULL),
    (5, '2025-06-03 12:40', '2025-06-03 13:25', NULL),
    (6, '2025-06-03 21:10', '2025-06-03 22:00', NULL),
    (7, '2025-06-04 13:00', '2025-06-04 13:40', NULL),
    (8, '2025-06-04 19:30', NULL, '2025-06-04 19:45'),
    (9, '2025-06-05 20:00', NULL, NULL),
    (10, '2025-06-05 12:15', '2025-06-05 13:00', NULL),
    (11, '2025-06-05 13:20', '2025-06-05 14:05', NULL),
    (12, '2025-06-06 19:10', '2025-06-06 20:00', NULL),
    (13, '2025-06-06 20:40', '2025-06-06 21:30', NULL),
    (14, '2025-06-07 12:30', '2025-06-07 13:15', NULL),
    (15, '2025-06-07 21:00', '2025-06-07 21:55', NULL),
    (16, '2025-06-07 19:20', NULL, '2025-06-07 19:40'),
    (17, '2025-06-08 12:10', NULL, NULL),
    (18, '2025-06-08 20:00', NULL, NULL),
    (19, '2025-01-10 12:00', '2025-01-10 12:50', NULL),
    (20, '2025-02-05 19:10', '2025-02-05 20:00', NULL),
    (21, '2025-03-12 13:00', '2025-03-12 13:45', NULL),
    (22, '2025-04-18 20:10', '2025-04-18 21:00', NULL),
    (23, '2025-05-06 12:30', '2025-05-06 13:20', NULL),
    (24, '2025-06-15 19:00', '2025-06-15 19:50', NULL),
    (25, '2025-07-04 21:10', '2025-07-04 22:00', NULL),
    (26, '2025-08-11 13:20', '2025-08-11 14:00', NULL),
    (27, '2025-09-03 20:00', NULL, NULL),
    (28, '2025-10-22 12:10', '2025-10-22 13:00', NULL),
    (29, '2025-11-14 19:30', '2025-11-14 20:20', NULL),
    (30, '2025-12-20 21:00', '2025-12-20 21:50', NULL),
    (31, '2025-01-25 13:15', '2025-01-25 14:00', NULL),
    (32, '2025-02-14 20:00', '2025-02-14 20:50', NULL),
    (33, '2025-03-27 12:40', '2025-03-27 13:30', NULL),
    (34, '2025-04-09 19:20', '2025-04-09 20:10', NULL),
    (35, '2025-05-21 13:10', '2025-05-21 14:00', NULL),
    (36, '2025-06-30 20:30', '2025-06-30 21:20', NULL),
    (37, '2025-07-18 12:00', '2025-07-18 12:50', NULL),
    (38, '2025-08-26 19:00', '2025-08-26 19:50', NULL),
    (39, '2025-09-15 13:00', '2025-09-15 13:45', NULL),
    (40, '2025-10-05 20:10', '2025-10-05 21:00', NULL),
    (41, '2025-11-02 12:30', '2025-11-02 13:15', NULL),
    (42, '2025-12-01 19:40', '2025-12-01 20:30', NULL),
    (43, '2025-03-01 21:00', NULL, '2025-03-01 21:15'),
    (44, '2025-06-10 12:10', NULL, NULL),
    (45, '2025-09-22 20:20', NULL, NULL),
    (46, '2025-11-28 13:00', '2025-11-28 13:50', NULL),
    (47, '2025-12-15 19:10', '2025-12-15 20:00', NULL),
    (48, '2025-12-29 21:30', '2025-12-29 22:20', NULL);

    INSERT INTO Res_PedidoPrato
    (
        IdPedidoPrato,
        IdPedido,
        IdPrato,
        Quantidade
    )
    VALUES
    (1, 1, 2, 1),
    (2, 1, 5, 2),
    (3, 2, 3, 1),
    (4, 2, 9, 2),
    (5, 3, 7, 1),
    (6, 3, 4, 1),
    (7, 4, 12, 1),
    (8, 4, 8, 1),
    (9, 5, 1, 1),
    (10, 5, 6, 1),
    (11, 6, 13, 1),
    (12, 6, 14, 2),
    (13, 7, 10, 1),
    (14, 7, 15, 1),
    (15, 8, 17, 1),
    (16, 8, 19, 1),
    (17, 9, 5, 1),
    (18, 10, 2, 1),
    (19, 10, 5, 2),
    (20, 10, 14, 1),
    (21, 11, 3, 1),
    (22, 11, 9, 2),
    (23, 12, 7, 1),
    (24, 12, 8, 1),
    (25, 12, 15, 2),
    (26, 13, 12, 1),
    (27, 13, 5, 1),
    (28, 14, 1, 1),
    (29, 14, 6, 1),
    (30, 14, 16, 2),
    (31, 15, 13, 1),
    (32, 15, 19, 1),
    (33, 15, 20, 1),
    (34, 16, 7, 1),
    (35, 16, 4, 1),
    (36, 17, 2, 1),
    (37, 17, 5, 1),
    (38, 18, 17, 1),
    (39, 18, 8, 1),
    (40, 19, 21, 2),
    (41, 19, 29, 1),
    (42, 20, 24, 1),
    (43, 20, 30, 2),
    (44, 21, 23, 1),
    (45, 21, 28, 1),
    (46, 22, 27, 1),
    (47, 22, 26, 1),
    (48, 23, 25, 1),
    (49, 23, 29, 1),
    (50, 24, 24, 1),
    (51, 24, 30, 1),
    (52, 25, 23, 1),
    (53, 25, 28, 2),
    (54, 26, 21, 1),
    (55, 26, 22, 1),
    (56, 27, 30, 1),
    (57, 27, 29, 1),
    (58, 28, 25, 1),
    (59, 28, 26, 1),
    (60, 29, 27, 1),
    (61, 29, 28, 1),
    (62, 30, 24, 1),
    (63, 30, 30, 2),
    (64, 31, 21, 2),
    (65, 31, 28, 1),
    (66, 32, 23, 1),
    (67, 32, 29, 1),
    (68, 33, 25, 1),
    (69, 33, 26, 1),
    (70, 34, 24, 1),
    (71, 34, 30, 1),
    (72, 35, 27, 1),
    (73, 35, 28, 1),
    (74, 36, 23, 1),
    (75, 36, 29, 1),
    (76, 37, 21, 1),
    (77, 37, 22, 1),
    (78, 38, 25, 1),
    (79, 38, 26, 1)

END

/*
OBSERVAÇÕES IMPORTANTES:
 * OS REGISTROS CARREGADOS NAS TABELAS SÃO EXEMPLIFICATIVOS, E SERVEM PARA O ENTENDIMENTO DA BASE DE DADOS, PORTANTO AS RESPOSTAS DEVEM CONTEMPLAR QUALQUER REGISTRO QUE ATENDA AOS CRITÉRIOS EXIGIDOS NAS QUESTÕES, NÃO AOS DADOS CARREGADOS.

 * APENAS COMECE A PROVA APÓS INFORMADO PELOS FISCÁIS PRESENTES.

 * INSIRA AS RESPOSTAS AS PERGUNTAS ABAIXO DE CADA UMA DA QUESTÃO CORRESPONDENTE.

 * APÓS A CONCLUSÃO DE SUA PROVA, GRAVE O ARQUIVO NA SUA AREA DE TRABALHO COM O SEGUINTE PADRÃO DE NOME: SeuNomeCompleto_Turma8 . APÓS ISSO ENTRE EM CONTATO COM UM DOS FISCÁIS.

*/


 /*
 1 - Construa uma procedure para listar os itens do cardápio a ser disponibilizado para IFood e
 para o app do restaurante, destacando por grupo, o Nome do prato, descrição do prato,
 tempo de elaboração, valor do prato.
 Resultado esperado (dados meramente ilustrativos)
 Grupo             | NomePrato     |  DescricaoPrato    | TempoElaboracao | Valor    |
-------------------|---------------|  --------------    | --------------- | -------- |
Entradas           | Nome do Prato | Descricao do Prato | 10 minutos      | R$ xx,xx |
Pratos Principais  | Nome do Prato | Descricao do Prato | 50 minutos      | R$ xx,xx |
Sobremesas         | Nome do Prato | Descricao do Prato | 5  minutos      | R$ xx,xx |

 */
 GO
 -- Procedure que lista os pratos ativos do cardápio,
-- permitindo filtro opcional por grupo e nome do prato
	ALTER PROCEDURE listar_itens_cardapio
	AS
	BEGIN
		SELECT
				g.Nome AS Grupo,
				c.NomePrato,
				c.DescricaoPrato,
				c.TempoPreparoMinutos AS TempoElaboracao,
				c.PrecoVenda AS Valor
		FROM Res_Cardapio c
			INNER JOIN Res_Grupo g
				ON g.IdGrupo = c.IdGrupo
		WHERE c.StatusPrato = 1 -- apenas pratos ativos
			--AND (@NomePrato IS NOT NULL AND c.NomePrato LIKE '%' + @NomePrato + '%')
			--AND (@Grupo IS NOT NULL AND g.Nome LIKE '%' + @Grupo + '%')
		ORDER BY g.Nome, c.NomePrato
	END

	EXEC listar_itens_cardapio



/*
2 - 
a) Aconteceu um problema no circuito elétrico do restaurante que atingiu todos os fornos de micro-ondas, 
crie uma segunda versão da procedure criada no item 01 que gere o cardápio excluindo todos os pratos 
que façam uso de forno de micro-ondas.

 Resultado esperado (dados meramente ilustrativos)
 Grupo             | NomePrato     |  DescricaoPrato    | TempoElaboracao | Valor    |
-------------------|---------------|  --------------    | --------------- | -------- |
Entradas           | Nome do Prato | Descricao do Prato | 10 minutos      | R$ xx,xx |
Pratos Principais  | Nome do Prato | Descricao do Prato | 50 minutos      | R$ xx,xx |
Sobremesas         | Nome do Prato | Descricao do Prato | 5  minutos      | R$ xx,xx |

*/
GO
-- Remove da listagem os pratos que possuem alguma etapa com uso de micro-ondas
	ALTER PROCEDURE listar_itens_cardapio
	AS
	BEGIN
		SELECT DISTINCT 
				g.Nome AS Grupo,
				c.NomePrato,
				c.DescricaoPrato,
				c.TempoPreparoMinutos AS TempoElaboracao,
				c.PrecoVenda AS Valor
		FROM Res_Cardapio c
			INNER JOIN Res_Grupo g
				ON g.IdGrupo = c.IdGrupo
			INNER JOIN Res_Procedimentos proce
				ON proce.IdPrato = c.IdPrato
			WHERE c.StatusPrato = 1
				--AND (@NomePrato IS NOT NULL AND c.NomePrato LIKE '%' + @NomePrato + '%')
				--AND (@Grupo IS NOT NULL AND g.Nome LIKE '%' + @Grupo + '%')
                -- exclui pratos que possuem etapa com micro-ondas
				AND proce.DescricaoEtapa NOT LIKE '%micro-ondas%'
			ORDER BY g.Nome, c.NomePrato
		END

		EXEC listar_itens_cardapio

/*
b) Ajuste a procedure para receber um parâmetro de nome @TipoConsulta ( 0 ou 1). 
    - Quando @TipoConsulta = 0: Retorna o resultado esperado da alternativa a.
    - Quando @TipoConsulta = 1: Retorna uma nova análise que mostra:
        * Grupo
        * Quantidade de pratos disponíveis originalmente
        * Quantidade de pratos que ficaram indisponíveis (usam micro-ondas)
        * Percentual de redução do cardápio por grupo

Resultado esperado quando @TipoConsulta = 1 (dados meramente ilustrativos)
Grupo              | QtdOriginal | QtdIndisponivel | PercentualReducao  |
-------------------|-------------|-----------------|-------------------|
Entradas           | 5           | 1               | 20.00%            |
Pratos Principais  | 10          | 3               | 30.00%            |
Sobremesas         | 4           | 0               | 0.00%             |
*/

GO
-- @TipoConsulta controla o tipo de retorno:
-- 0 = lista pratos sem micro-ondas
-- 1 = relatório estatístico de impacto por grupo
	ALTER PROCEDURE listar_itens_cardapio(
		@TipoConsulta BIT = 0
	)
	AS
	IF @TipoConsulta = 0
	BEGIN
		SELECT DISTINCT 
				g.Nome AS Grupo,
				c.NomePrato,
				c.DescricaoPrato,
				c.TempoPreparoMinutos AS TempoElaboracao,
				c.PrecoVenda AS Valor
		FROM Res_Cardapio c
			INNER JOIN Res_Grupo g
				ON g.IdGrupo = c.IdGrupo
			INNER JOIN Res_Procedimentos proce
				ON proce.IdPrato = c.IdPrato
			WHERE c.StatusPrato = 1
				--AND (@NomePrato IS NOT NULL AND c.NomePrato LIKE '%' + @NomePrato + '%')
				--AND (@Grupo IS NOT NULL AND g.Nome LIKE '%' + @Grupo + '%')
				AND proce.DescricaoEtapa NOT LIKE '%micro-ondas%'
			ORDER BY g.Nome, c.NomePrato
		END;
	ELSE IF @TipoConsulta = 1
    BEGIN
    -- calcula o percentual da remoção dos pratos com micro-ondas por grupo
        SELECT 
            g.Nome AS Grupo,
            COUNT(DISTINCT c.IdPrato) AS QtdOriginal,
            COUNT(DISTINCT CASE WHEN proce.DescricaoEtapa LIKE '%micro-ondas%' THEN c.IdPrato END) AS QtdIndisponivel,
            CAST(
                (COUNT(DISTINCT CASE WHEN proce.DescricaoEtapa LIKE '%micro-ondas%' THEN c.IdPrato END) * 100.0) 
                / NULLIF(COUNT(DISTINCT c.IdPrato), 0) 
            AS DECIMAL(5,2)) AS PercentualReducao
            
        FROM Res_Cardapio c
        INNER JOIN Res_Grupo g 
			ON g.IdGrupo = c.IdGrupo
        LEFT JOIN Res_Procedimentos proce 
			ON proce.IdPrato = c.IdPrato
        WHERE c.StatusPrato = 1
        GROUP BY g.Nome
        ORDER BY g.Nome
    END

	EXEC listar_itens_cardapio


/*
3 - Liste os pratos que participaram de no máximo 2 pedidos cancelados, entenda como pedido cancelado os pedidos que tiverem
data de cancelamento informada.
*/

	SELECT
		c.IdPrato,
		c.NomePrato,
		COUNT(pp.idPedido) AS QuantPedidosCancelados
	FROM Res_Cardapio c
	LEFT JOIN Res_PedidoPrato pp
		ON pp.idPrato = c.IdPrato
	LEFT JOIN Res_Pedido p
		ON p.idPedido = pp.idPedido AND p.DataCancelamento IS NOT NULL
	--WHERE p.DataCancelamento IS NOT NULL
	GROUP BY c.IdPrato, c.NomePrato
    -- Conta quantos pedidos cancelados cada prato teve
	--no máximo 2 pedidos cancelados
	HAVING COUNT (pp.idPedido) <= 2; 

	

/*
4 - Liste todos os pratos do cardapio que estão ativos, que NÃO foram vendidos nos últimos 3 meses e 
NÃO utilizam ingredientes cujo valor unitário fique entre R$5,00 e R$15,00. Considere que pedidos cancelados devem ser 
desconsiderados, ou seja, não contam como venda.
*/

--pratos do cardapio que estão ativos 
	SELECT 
		c.IdPrato,
		c.NomePrato
	FROM Res_Cardapio c
	WHERE c.StatusPrato = 1
	-- que não foram vendidos nos últimos 3 meses
		AND NOT EXISTS (
			SELECT 1
			FROM Res_PedidoPrato pp
				INNER JOIN Res_Pedido p
				ON p.idPedido = pp.idPedido
			WHERE 
			pp.idPrato = c.IdPrato  
			AND
			p.DataCancelamento IS NULL 
			AND 
			p.DataPedido >= DATEADD(MONTH, -3, GETDATE())
		)
		-- e que não utilizam ingredientes no valor unitário entre 5 e 15  
		AND NOT EXISTS (
			SELECT 1
			FROM Res_IngredientePrato ip
			INNER JOIN Res_Ingrediente i
				ON i.IdIngrediente = ip.IdIngrediente
			WHERE 
				c.IdPrato = ip.IdPrato
				AND
				i.ValorUnitarioIngrediente BETWEEN 5 AND 15 
		);



/*
5 - O custo de um prato no restaurante é definido pela soma do custo de todos os ingredientes utilizados, considerando a quantidade necessária de cada ingrediente e o seu valor unitário. Sobre esse custo base, é 
aplicado um fator de complexidade, de acordo com o tempo de preparo do prato, além de um reajuste operacional fixo de 5%.

O cálculo do custo final do prato deve seguir a seguinte regra: Custo Final = (Custo dos Ingredientes × Fator de Complexidade) + 5%
Os fatores de complexidade são definidos conforme o tempo de preparo do prato:
    * Pratos com até 10 minutos de preparo: fator 1
    * Pratos entre 11 e 30 minutos de preparo: fator 1,5
    * Pratos acima de 30 minutos de preparo: fator 2

Além disso, o restaurante concede um desconto operacional de 15% no custo final do prato caso o prato não tenha sido vendido nos últimos 90 dias.

a) Escreva uma função que receba o id do Prato e retorne o custo final do prato e o valor do desconto, conforme as regras descritas na questão.
Resultado esperado:

SELECT * FROM dbo.fn_CustoPrato(5)

| CustoFinal   | Desconto |
| -------      | -------  |
| 1024,96      | 204,99	  |
*/


CREATE FUNCTION dbo.fn_CustoPrato(@IdPrato INT)
RETURNS TABLE
AS
RETURN (
-- soma do custo de todos os ingredientes do prato
	WITH CustoBase AS(
		SELECT
			SUM (ip.QuantidadeNecessaria * i.ValorUnitarioIngrediente) AS CustoIngredientes
		FROM Res_IngredientePrato ip
		INNER JOIN Res_Ingrediente i
			ON i.IdIngrediente = ip.IdIngrediente
		WHERE @IdPrato = ip.IdPrato 
		
	),
    -- aplica o fator de complexidade de acordo o tempo
	CalculoFator AS (
		SELECT
			c.idPrato,
			cb.CustoIngredientes, 
			CASE 
					WHEN c.TempoPreparoMinutos <= 10 THEN 1.0
					WHEN c.TempoPreparoMinutos <= 30 THEN 1.5
					ELSE 2.0
				END
			AS Fator
		FROM Res_Cardapio c
		CROSS JOIN CustoBase cb
		WHERE @IdPrato = c.IdPrato 
	),
    -- aplica reajuste de 5% e possível desconto de 15%
	CustoTotal AS (
		SELECT 
			(CustoIngredientes * Fator) * 1.05 AS Total,
			CASE 
                WHEN NOT EXISTS (
                    SELECT 1 FROM Res_Pedido p
                    INNER JOIN Res_PedidoPrato pp 
						ON pp.IdPedido = p.IdPedido
                    WHERE pp.IdPrato = @IdPrato 
                    AND p.DataPedido >= DATEADD(DAY, -90, GETDATE())
                ) THEN ((CustoIngredientes * Fator) * 1.05) * 0.15 
                ELSE 0 
            END AS ValorDesconto
		FROM CalculoFator
	)                                                 
	SELECT
	--"CAST" transforma o resultado e força para ser do tipo decimal 
        CAST(Total AS DECIMAL(10,2)) AS CustoFinal,
        CAST(ValorDesconto AS DECIMAL(10,2)) AS ValorDoDesconto
	FROM CustoTotal
)

SELECT * FROM dbo.fn_CustoPrato(5)




/*
b) Sabendo que a tabela Res_Cardapio não possui os campos responsáveis por armazenar o custo final calculado do prato e o valor do desconto aplicado, faça as alterações necessárias na estrutura da tabela para receber 
estas informçaões e, utilizando a função criada no item a), atualize esses valores na tabela.

*/
	
	ALTER TABLE Res_Cardapio	
		ADD CustoFinal DECIMAL(10, 2),
			ValorDesconto DECIMAL(10, 2); 

	--Atualizando os dados de CustoFinal e ValorDesconto
    --CROSS APPLY executa a função para cada prato
	UPDATE c
	SET 
		c.CustoFinal = f.CustoFinal,
		c.ValorDesconto = f.ValorDoDesconto
	FROM Res_Cardapio c
	CROSS APPLY dbo.fn_CustoPrato(c.IdPrato) f;


	SELECT * FROM Res_Cardapio



/*
6 -Gere um relatório estatístico com o tempo médio de preparo dos pratos, agrupando-os de acordo com a faixa de preço de venda do prato, considerando os seguintes 
grupos: até R$ 20,00 , de R$ 20,01 até R$ 50,00 e 
acima de R$ 50,00.

O relatório deve exibir o tempo médio de preparo de cada grupo e o resultado deve ser apresentado ordenado pelos grupos de tempo em ordem crescente.

Resultado esperado (dados meramente ilustrativos)

Faixa de Preço| Valor médio  |
------------ |------------- |
< 20         | 7.5          |
20,01 até 50 | 22           |
> 50         | 38.4         |
*/

	SELECT
		FaixaDePreco.FaixaPreco, 
		CAST(AVG(FaixaDePreco.Tempo) AS DECIMAL(10, 2)) AS [Valor Médio]
	FROM (
	--subquery para definir a faixa de preço de acordo com os casos
		SELECT 
		-- alterar o tipo para decimal pois o atributo TempoPreparoMinutos é inteiro
			CAST(c.TempoPreparoMinutos AS DECIMAL(10,2)) AS Tempo,
			CASE 
				WHEN PrecoVenda <= 20.00 THEN 'Até R$ 20,00'
				WHEN PrecoVenda <= 50.00 THEN 'De R$ 20,01 até R$ 50,00'
				ELSE 'Acima de R$ 50,00'
			END AS FaixaPreco,
			CASE 
				WHEN PrecoVenda <= 20.00 THEN 1
				WHEN PrecoVenda <= 50.00 THEN 2
				ELSE 3
			END AS OrdemFaixa
		FROM Res_Cardapio c
	) AS FaixaDePreco
	GROUP BY FaixaDePreco.FaixaPreco, FaixaDePreco.OrdemFaixa
	ORDER BY FaixaDePreco.OrdemFaixa ASC
	


	--verificando se a média bateu com a quantidade de pratos que tem o preço menor/igual a 20
	SELECT 
		c.NomePrato,
		c.TempoPreparoMinutos AS Tempo
	FROM Res_Cardapio c
	WHERE c.PrecoVenda <= 20
	GROUP BY c.IdPrato, c.NomePrato, c.TempoPreparoMinutos

/*

7 - Se o custo de todos os ingredientes que possuem a unidade de medida 'kg' subir 15%, 
quais seriam os 3 pratos que sofreriam o maior aumento no custo de produção e de quanto foi esse aumento?

Resultado esperado (dados meramente ilustrativos)

Nome do Prato| Valor Aumento|
------------ |------------- |
Salada       | R$ 40,00     |
             |              |
             |              |
*/

	SELECT TOP 3
		c.NomePrato AS [Nome do Prato],
		--15% de aumento no valor do prato multiplicando a quantidade necessaria pelo valor do ingrediente
		SUM(ip.QuantidadeNecessaria * i.ValorUnitarioIngrediente * 0.15) AS ValorAumento
	FROM Res_Cardapio c
	INNER JOIN Res_IngredientePrato ip
		ON ip.IdPrato = c.IdPrato
	INNER JOIN Res_Ingrediente i
		ON i.IdIngrediente = ip.IdIngrediente
	--Se a unidadeMedida for igual a kg
	WHERE i.UnidadeMedida LIKE '%kg%'
	GROUP BY c.NomePrato
	ORDER BY ValorAumento DESC



/*
8 - O Gerente solicitou uma lista de todos os pratos que atendam SIMULTANEAMENTE aos seguintes critérios:
   * Possuam exatamente 3 ou 5 procedimentos para preparo
   * Utilizem pelo menos um ingrediente com UnidadeMedida 'kg'
   * Utilizem no máximo um ingrediente com UnidadeMedida 'um'
A lista deve exibir: Nome do Prato, Procedimentos, Ingredientes.
OBS: Os procedimentos devem ser ordenados pela sua sequencia de execução
OBS 2: Para cada prato deve conter somente uma unica linha por prato, com todas as informações consolidadas, conforme exemplificado abaixo.

Resultado esperado (dados meramente ilustrativos)
Prato               |  Procedimentos	                                                                             | Ingredientes
------------        |  ---------------------------------------------------------------------------------------       | -------------------------------------------
Lasanha à Bolonhesa | 1- Preparar o molho bolonhesa, 2- Montar as camadas da lasanha, 3- Levar ao forno para assar   | Carne Moída, Massa para Lasanha, Queijo Mussarela	
Pudim de Leite      | 1- Misturar ingredientes, 2- Resfriar, 3- Desenformar                                          | Leite Condensado, Ovo, Açúcar
*/


	SELECT
		c.NomePrato AS Prato,
		-- subquery para não repetir as etapas por sequência na consulta 
		(SELECT 
			STRING_AGG(CAST(proce.SequenciaExecucao AS VARCHAR) + '-' + proce.DescricaoEtapa, ', ') 
			WITHIN GROUP (ORDER BY proce.SequenciaExecucao)
		 FROM Res_Procedimentos proce 
		 WHERE proce.IdPrato = c.IdPrato
    ) AS Procedimentos, 
	-- subquery para não repetir o nome dos ingredientes na consulta 
		(SELECT 
			STRING_AGG(i.NomeIngrediente, ', ')
		FROM Res_IngredientePrato ip
			JOIN Res_Ingrediente i ON i.IdIngrediente = ip.IdIngrediente
		WHERE ip.IdPrato = c.IdPrato
		) AS Ingredientes
	FROM Res_Cardapio c 
	WHERE
	--Condições com subqueries 
		-- 3 ou 5
		(SELECT COUNT(*) 
		FROM Res_Procedimentos p 
		WHERE p.IdPrato = c.IdPrato) IN (3, 5)

		--pelo menos 1
		AND (SELECT COUNT(*) 
		FROM Res_IngredientePrato ip
				JOIN Res_Ingrediente i ON i.IdIngrediente = ip.IdIngrediente
		WHERE ip.IdPrato = c.IdPrato AND i.UnidadeMedida = 'kg') >= 1 

		--no máximo 1
		AND (SELECT COUNT(*) 
			FROM Res_IngredientePrato ip
				JOIN Res_Ingrediente i ON i.IdIngrediente = ip.IdIngrediente
			WHERE ip.IdPrato = c.IdPrato AND i.UnidadeMedida = 'um') <= 1
	GROUP BY c.IdPrato, c.NomePrato   

	
/*
9 -  Gere um relatório de todos os pratos que foram solicitados no horario (10:00 - 14:00), separando a quantidade de pratos por cada hora e separando a quantidade de pratos entreges e cancelados.
Um prato deve ser considerado entregue quando o pedido possuir DataEntrega preenchida e considerado cancelado quando possuir DataCancelamento preenchida.
Ao final do resultado, deve ser incluída uma última linha contendo o total geral de pedidos entregues e o total geral de pedidos cancelados no período.
OBS: Subsitutuir 'NULL' POR 'X'
 
  Resultado esperado:
 
Prato          | Quantidade Entregue | Quantidade Cancelada | Horario | Pedidos Entregues | Pedidos Cancelados
Salada Caesar  | 2                   | 0                    | 10:00   | X                 | X
Salada Caesar  | 1                   | 1                    | 11:00   | X                 | X
...
TOTAL          | X                   | X                    | X       | 155               | 155
*/


DROP TABLE #dados

	SELECT
	--verifica se o nome do prato é null, se for, substitui por Total Geral 
		ISNULL(CAST(c.NomePrato AS VARCHAR), 'TOTAL GERAL') AS Prato, 
		COUNT(pp.Quantidade) AS [Quantidade Entregue],

		SUM(CASE 
				WHEN p.DataCancelamento IS NOT NULL THEN pp.Quantidade 
				ELSE 0 
			END) AS [Quantidade Cancelada],
		--verifica se a data do pedido é null, se for, substitui por X 
		ISNULL(FORMAT(p.DataPedido, 'HH:00'), 'X') AS Horario,
		CAST(SUM(CASE 
				WHEN p.DataEntrega IS NOT NULL THEN 1 
				ELSE 0
			END) AS VARCHAR )AS [Pedidos Entregues], 
		CAST(SUM(CASE 
				WHEN p.DataCancelamento IS NOT NULL THEN 1
				ELSE 0 
			END) AS VARCHAR) AS [Pedidos Cancelados]
		
			--INTO #dados
	FROM Res_Cardapio c
	INNER JOIN Res_PedidoPrato pp
		ON pp.idPrato = c.IdPrato
	INNER JOIN Res_Pedido p
		ON p.idPedido = pp.idPedido
	--Filtro de horário entre 10 e 14 
	WHERE 
	--Datepart extrai partes especificas de uma data (hora)
		DATEPART(HOUR, p.DataPedido) BETWEEN 10 AND 14
	-- Agrupa por prato e hora, e o ROLLUP cria a linha de total no fim
	GROUP BY ROLLUP
		(FORMAT(p.DataPedido, 'HH:00'), c.NomePrato)
	HAVING 
		(FORMAT(p.DataPedido, 'HH:00') IS NOT NULL AND c.NomePrato IS NOT NULL)
		OR 
		(FORMAT(p.DataPedido, 'HH:00') IS NULL AND c.NomePrato IS NULL)
	ORDER BY CASE WHEN c.NomePrato IS NULL THEN 1 ELSE 0 END, Horario;

	--update #dados set [Pedidos Cancelados] = 'X' where [Pedidos Cancelados] = 0 and Prato = 'Total Geral'

	--select *

	--from #dados



	--entendendo  
	SELECT 
		CASE 
			WHEN p.DataEntrega IS NOT NULL THEN 1 
			ELSE 0
		END AS [Pedidos Entregues],
		CASE 
			WHEN p.DataCancelamento IS NOT NULL THEN 1
			ELSE 0
		END AS [Pedidos Cancelados]
	FROM Res_Pedido p




/*
10 - Gere uma consulta SQL para retornar o prato mais solicitado em cada mês, considerando a data do pedido. Devem ser considerados todos os pedidos registrados, independentemente de terem sido entregues ou cancelados. 
Caso, em um mesmo mês, dois ou mais pratos possuam a mesma quantidade máxima de solicitações, todos eles devem ser exibidos no resultado. O resultado deverá seguir o padrão apresentado abaixo:

Retorno esperado (meramente ilustrativo)

MesAno   | NomePrato       | Quantidade
---------|-----------------|-----------
06/2025  | Filé de Frango  | 25
07/2025  | Bife Acebolado  | 32
08/2025  | Salada Caesar   | 40
08/2025  | Lasanha         | 40
*/

	SELECT 
		t.MesAno,
		t.NomePrato,
		t.Quantidade
	FROM (
    ---- Subquery conta pedidos por prato em cada mês
		SELECT 
			FORMAT(p.DataPedido, 'MM/yyyy') AS MesAno,
			c.NomePrato,
			COUNT(p.idPedido) AS Quantidade
		FROM Res_Pedido p
		INNER JOIN Res_PedidoPrato pp
			ON pp.idPedido = p.idPedido
		INNER JOIN Res_Cardapio c
			ON c.IdPrato = pp.idPrato
		GROUP BY FORMAT(p.DataPedido, 'MM/yyyy'), c.NomePrato
                                    
	) t WHERE t.Quantidade = (
    -- Query externa pega apenas os que possuem a maior quantidade no mês
        SELECT MAX(t2.Quantidade)
        FROM (
            SELECT 
                FORMAT(p2.DataPedido, 'MM/yyyy') AS MesAno,
                c2.NomePrato,
                COUNT(pp2.Quantidade) AS Quantidade
            FROM Res_Pedido p2
            INNER JOIN Res_PedidoPrato pp2
                ON p2.idPedido = pp2.idPedido
            INNER JOIN Res_Cardapio c2
                ON pp2.idPrato = c2.IdPrato
            GROUP BY 
                FORMAT(p2.DataPedido, 'MM/yyyy'),
                c2.NomePrato
        ) t2
        -- Permite empate (mais de um prato no mês)
        WHERE t2.MesAno = t.MesAno
    )
    ORDER BY t.MesAno;
			
	


/*
11 - Escreva uma consulta SQL que retorne os pratos que utilizam mais de dois ingredientes distintos e cujo custo total de todos os ingredientes seja superior a R$ 100,00.

O resultado deve exibir o nome do prato, a quantidade de ingredientes distintos utilizados e o custo total dos ingredientes do prato.

Retorno esperado (meramente ilustrativo)
NomePrato   | NomeIngrediente | Custo
---------|-----------------   |-----------
Salada   | Queijo             | R$ 25,00
*/


	SELECT 
		c.NomePrato,
		COUNT (DISTINCT ip.IdIngrediente) AS QuantIngredientes,
		SUM(ip.QuantidadeNecessaria * i.ValorUnitarioIngrediente ) AS Custo
	FROM Res_Cardapio c
	INNER JOIN Res_IngredientePrato ip
		ON ip.IdPrato = c.IdPrato
	INNER JOIN Res_Ingrediente i
		ON i.IdIngrediente = ip.IdIngrediente 
	GROUP BY c.NomePrato
    -- mais de 2 ingredientes distintos
    -- custo total dos ingredientes maior que 100
	HAVING 
		COUNT(DISTINCT ip.IdIngrediente) > 2
		AND
		SUM(ip.QuantidadeNecessaria * i.ValorUnitarioIngrediente) > 10;
