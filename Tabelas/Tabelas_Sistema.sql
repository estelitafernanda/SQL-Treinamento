CREATE TABLE Efab_Sistema(
	idSistema INT PRIMARY KEY IDENTITY(1,1),
	Codigo VARCHAR(50) NOT NULL,
	Caption VARCHAR(50) NOT NULL,
); 

CREATE TABLE Efab_Modulo(
	idModulo INT PRIMARY KEY IDENTITY(1,1),
	idSistema INT NOT NULL,
	Codigo VARCHAR(50) NOT NULL,
	Caption VARCHAR(50) NOT NULL,

	CONSTRAINT FK_Efab_Modulo_Efab_Sistema
	FOREIGN KEY (idSistema) 
	REFERENCES Efab_Sistema (idSistema)
);

CREATE TABLE Efab_Pagina(
	idPagina INT PRIMARY KEY IDENTITY(1,1),
	idModulo INT NOT NULL,
	Codigo VARCHAR(50) NOT NULL,
	Caption VARCHAR(50) NOT NULL,

	CONSTRAINT FK_Efab_Pagina_Efab_Modulo
	FOREIGN KEY (idModulo)
	REFERENCES Efab_Modulo (idModulo)

); 

CREATE TABLE Efab_Acao(
	idAcao INT PRIMARY KEY IDENTITY(1,1),
	idPagina INT NOT NULL,
	Codigo VARCHAR(50) NOT NULL,
	Caption VARCHAR(50) NOT NULL,
	NomeProcedure VARCHAR(100) NOT NULL,

	CONSTRAINT FK_Efab_Acao_Efab_Pagina
	FOREIGN KEY (idPagina)
	REFERENCES Efab_Pagina (idPagina)
);


CREATE TABLE Efab_Operador(
	idOperador INT PRIMARY KEY IDENTITY(1,1),
	Cpf VARCHAR(11) NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	Senha VARCHAR(50) NOT NULL
);

CREATE TABLE Efab_Autorizacao(
	idAutorizacao INT PRIMARY KEY IDENTITY(1,1),
	idAcao INT NOT NULL,
	idOperador INT NOT NULL,

	CONSTRAINT FK_Efab_Autorizacao_Efab_Acao
	FOREIGN KEY (idAcao)
	REFERENCES Efab_Acao (idAcao),

	CONSTRAINT FK_Efab_Autorizacao_Efab_Operador
	FOREIGN KEY (idOperador)
	REFERENCES Efab_Operador (idOperador) 

);