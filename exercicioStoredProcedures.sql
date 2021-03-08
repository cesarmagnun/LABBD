--Ex1

CREATE DATABASE cadastro


CREATE TABLE PESSOA(
CPF CHAR(11) NOT NULL,
NOME VARCHAR(80) NOT NULL
CONSTRAINT PK_CPF PRIMARY KEY(CPF)
)
SELECT * FROM PESSOA 
DELETE PESSOA

DECLARE @out VARCHAR(MAX)
EXEC sp_inserecadastro 65019228010, 'Cesar', @out OUTPUT
PRINT @out

DECLARE @out VARCHAR(MAX)
EXEC sp_inserecadastro 42931342817, 'Cesar', @out OUTPUT
PRINT @out

DECLARE @out VARCHAR(MAX)
EXEC sp_inserecadastro 11351318802, '', @out OUTPUT
PRINT @out


CREATE PROCEDURE sp_inserecadastro(@cpf BIGINT, @nome VARCHAR(80), @saida VARCHAR(MAX) OUTPUT)
AS
DECLARE @soma INT,
		@cont INT,
		@digito1 VARCHAR,
		@digito2 VARCHAR 
SET @soma = 0
SET @cont = 10
SET @digito1 = ''
SET	@digito2 = '' 

WHILE(@cont > 1)
BEGIN
SET @soma = @soma + CAST(SUBSTRING(CAST(@cpf AS VARCHAR), 11 - @cont, 1) AS INT) * @cont
SET @cont = @cont - 1
END
IF (@soma % 11 < 2)
BEGIN
	SET @digito1 = 0
END
ELSE
BEGIN
	SET @digito1 = 11 - (@soma % 11)
END
PRINT @digito1
IF (@digito1 != SUBSTRING(CAST(@cpf AS VARCHAR), 10, 1))
BEGIN
	RAISERROR('CPF INVÁLIDO! -Primeiro dígito incorreto', 16, 1)
END
ELSE
	BEGIN
	SET @soma = 0
	SET @cont = 11

	WHILE(@cont > 1)
	BEGIN
	SET @soma = @soma + CAST(SUBSTRING(CAST(@cpf AS VARCHAR), 12 - @cont, 1) AS INT) * @cont
	SET @cont = @cont - 1
	END
	IF (@soma % 11 < 2)
	BEGIN
		SET @digito2 = 0
	END
	ELSE
	BEGIN
		SET @digito2 = 11 - (@soma % 11)
	END
	PRINT @digito2

	IF(@digito2 != SUBSTRING(CAST(@cpf AS VARCHAR), 11, 1))
	BEGIN
		RAISERROR('CPF INVÁLIDO! -Segundo dígito incorreto', 16, 1)
	END
	ELSE
	BEGIN
		IF(LEN(@nome) < 1)
		BEGIN
			RAISERROR('O nome em branco!', 16 ,1)
		END
		ELSE
		BEGIN
			INSERT INTO PESSOA (CPF, NOME) VALUES (@cpf, @nome)
			SET @saida = 'Pessoa inserida com sucesso!'
		END
	END	
END










--Ex2

CREATE DATABASE academia

CREATE TABLE ALUNO(
CODIGO_ALUNO VARCHAR NOT NULL,
NOME VARCHAR(100) NOT NULL
CONSTRAINT PK_CODIGO_ALUNO PRIMARY KEY(CODIGO_ALUNO)
)

CREATE TABLE ATIVIDADE(
CODIGO VARCHAR NOT NULL,
DESCRICAO VARCHAR(100) NOT NULL,
IMC DECIMAL(7,2) NOT NULL
CONSTRAINT PK_CODIGO PRIMARY KEY(CODIGO)
)

CREATE TABLE ATIVIDADESALUNO(
CODIGO_ALUNO VARCHAR NOT NULL,
ALTURA DECIMAL(7,2) NOT NULL,
PESO DECIMAL(7,2) NOT NULL,
IMC DECIMAL(7,2) NOT NULL,
ATIVIDADE VARCHAR NOT NULL,
CONSTRAINT FK_CODIGO_ALUNO FOREIGN KEY (CODIGO_ALUNO) REFERENCES ALUNO (CODIGO_ALUNO),
CONSTRAINT FK_ATIVIDADE FOREIGN KEY(ATIVIDADE) REFERENCES ATIVIDADE (CODIGO),
CONSTRAINT PK_ATIVIDADESALUNO PRIMARY KEY(CODIGO_ALUNO, ATIVIDADE)
)

INSERT INTO ATIVIDADE (CODIGO, DESCRICAO, IMC) VALUES 
(1, 'Corrida + Step', 18.5),
(2, 'Biceps + Costas + Pernas', 24.9),
(3, 'Esteira + Biceps + Costas + Pernas', 29.9),
(4, 'Bicicleta + Biceps + Costas + Pernas', 34.9),
(5, 'Esteira + Bicicleta', 39.9)

CREATE PROCEDURE sp_alunoatividades (@codigo_aluno INT, @peso DECIMAL(5,2),
		@altura DECIMAL(5,2), @nome VARCHAR(100),  
		@saida VARCHAR(MAX) OUTPUT)
AS	
		DECLARE @imc DECIMAL(5,2),
				@atividade int
		IF (@codigo_aluno IS NULL AND @nome IS NOT NULL AND @altura IS NOT NULL AND @peso IS NOT NULL)
		BEGIN
			SET @imc = @peso / (@altura * @altura)
			
			IF (@imc < 24.90 AND @imc >= 18.50)			 
				SET @atividade = 1
			IF (@imc < 29.90 AND @imc >= 24.90)
			    SET @atividade = 2
			IF (@imc < 34.90 AND @imc >= 29.90)
			    SET @atividade = 3		
			IF (@imc < 39.90 AND @imc >= 34.90)
				SET @atividade = 4	
			IF (@imc >= 40)
				SET @atividade = 5
				
			INSERT INTO ATIVIDADESALUNO (CODIGO_ALUNO, ALTURA, PESO, IMC, ATIVIDADE) VALUES
			(@codigo_aluno, @altura, @peso, @imc, @atividade)
			
			INSERT INTO ALUNO (CODIGO_ALUNO, NOME) VALUES
			(@codigo_aluno, @nome)
		END	
		ELSE 
		BEGIN 
			IF(@codigo_aluno IS NOT NULL AND @altura IS NOT NULL AND @peso IS NOT NULL)
				SET @codigo_aluno = (SELECT CODIGO_ALUNO FROM ATIVIDADESALUNO WHERE CODIGO_ALUNO = @codigo_aluno)
				UPDATE ATIVIDADESALUNO SET altura = @altura, peso = @peso, IMC = @imc, atividade = @atividade 
				WHERE CODI = @codigo_aluno
		END	
		
	DECLARE @saida VARCHAR(MAX)
	EXEC sp_alunoatividades 1,80,1.10,'Ciclano', @saida OUTPUT
	PRINT @saida
	
	DECLARE @saida VARCHAR(MAX)
	EXEC sp_alunoatividades null,70,1.70,'Fulano', @saida OUTPUT
	PRINT @saida
	
