USE LBD

-- criação das tabelas
CREATE TABLE PRODUTO(
CODIGO INT,
NOME VARCHAR(MAX),
VALOR DECIMAL(5,2)
CONSTRAINT PK_CODIGO PRIMARY KEY (CODIGO)
)

CREATE TABLE ENTRADA(
CODIGO_TRANSACAO INT,
CODIGO_PRODUTO INT,
QUANTIDADE INT,
VALOR_TOTAL DECIMAL(5,2)
CONSTRAINT PK_CODIGO_TRANSACAO_PRODUTO_E PRIMARY KEY (CODIGO_TRANSACAO, CODIGO_PRODUTO),
CONSTRAINT FK_CODIGO_PRODUTO_E FOREIGN KEY (CODIGO_PRODUTO) REFERENCES PRODUTO (CODIGO)
)

CREATE TABLE SAIDA(
CODIGO_TRANSACAO INT,
CODIGO_PRODUTO INT,
QUANTIDADE INT,
VALOR_TOTAL DECIMAL(5,2)
CONSTRAINT PK_CODIGO_TRANSACAO_PRODUTO_S PRIMARY KEY (CODIGO_TRANSACAO, CODIGO_PRODUTO),
CONSTRAINT FK_CODIGO_PRODUTO_S FOREIGN KEY (CODIGO_PRODUTO) REFERENCES PRODUTO (CODIGO)
)
--insert da tabela PRODUTO
INSERT INTO PRODUTO (CODIGO, NOME, VALOR) VALUES (1, 'LÁPIS', 2.50), (2, 'BORRACHA', 1.00), (3, 'CANETA', 3.00), (4, 'APONTADOR', 5.00)

--criação da procedure
/*
Considere a tabela Produto com os seguintes atributos:
Produto (Codigo | Nome | Valor)
Considere a tabela ENTRADA e a tabela SAÍDA com os seguintes atributos:
(Codigo_Transacao | Codigo_Produto | Quantidade | Valor_Total)
Cada produto que a empresa compra, entra na tabela ENTRADA. Cada produto que a empresa vende, entra na tabela SAIDA.
Criar uma procedure que receba um código (‘e’ para ENTRADA e ‘s’ para SAIDA), criar uma exceção de erro para código inválido, receba o codigo_transacao, codigo_produto e a quantidade e preencha a tabela correta, com o valor_total de cada transação de cada produto.
*/
CREATE PROCEDURE SP_ENTRADA_SAIDA(@CODIGO CHAR, @CODIGO_TRANSACAO INT, @CODIGO_PRODUTO INT, @QUANTIDADE INT)
AS
IF UPPER(@CODIGO) = 'E' OR UPPER(@CODIGO) = 'S'
BEGIN
	DECLARE @QUERY_DINAMICA VARCHAR(MAX),
			@TODOS_CAMPOS VARCHAR(MAX),
			@VALOR_PRODUTO DECIMAL(5,2)
	SELECT @VALOR_PRODUTO = VALOR FROM PRODUTO WHERE CODIGO = @CODIGO_PRODUTO
	SET @TODOS_CAMPOS = ' CODIGO_TRANSACAO, CODIGO_PRODUTO, QUANTIDADE, VALOR_TOTAL '
	IF UPPER(@CODIGO) = 'E'
	BEGIN
		BEGIN TRY
			SET @QUERY_DINAMICA = 'INSERT INTO ENTRADA ( ' + @TODOS_CAMPOS + ' ) VALUES ( ''' + CAST(@CODIGO_TRANSACAO AS VARCHAR) + ''' , ''' + CAST(@CODIGO_PRODUTO AS VARCHAR) + ''' , ''' + CAST(@QUANTIDADE AS VARCHAR) + ''' , ''' + CAST(@VALOR_PRODUTO * @QUANTIDADE AS VARCHAR) + ''' )'
			EXEC(@QUERY_DINAMICA)
		END TRY
		BEGIN CATCH
			IF (ERROR_MESSAGE() LIKE '%primary%')
			BEGIN
				RAISERROR('ID produto duplicado!', 16, 1)
			END
		END CATCH	
	END
	ELSE
	BEGIN
		BEGIN TRY
			SET @QUERY_DINAMICA = 'INSERT INTO SAIDA ( ' + @TODOS_CAMPOS + ' ) VALUES ( ''' + CAST(@CODIGO_TRANSACAO AS VARCHAR) + ''' , ''' + CAST(@CODIGO_PRODUTO AS VARCHAR) + ''' , ''' + CAST(@QUANTIDADE AS VARCHAR) + ''' , ''' + CAST(@VALOR_PRODUTO * @QUANTIDADE AS VARCHAR) + ''' )'
			EXEC(@QUERY_DINAMICA)
		END TRY
		BEGIN CATCH
			IF (ERROR_MESSAGE() LIKE '%primary%')
			BEGIN
				RAISERROR('ID produto duplicado!', 16, 1)
			END
		END CATCH
	END
END
ELSE
BEGIN
	RAISERROR('Código de entrada/saída inválido!', 16, 1)
END

--executando a procedure em todos os casos
EXEC SP_ENTRADA_SAIDA 'x', 1, 1, 2 --codigo de entrada/saída inváldo
EXEC SP_ENTRADA_SAIDA 'e', 1, 1, 2 --entrada de produto
EXEC SP_ENTRADA_SAIDA 's', 1, 3, 4 --saída de produto







