USE LBD

/*Fazer um algoritmo que leia 3 valores e retorne se os valores formam um triângulo e se ele é
isóceles, escaleno ou equilátero.
Condições para formar um triângulo
	Nenhum valor pode ser = 0
	Um lado não pode ser maior que a soma dos outros 2.
*/
DECLARE @arestaA DECIMAL(7,2),	
		@arestaB DECIMAL(7,2),
		@arestaC DECIMAL(7,2)
		
SET @arestaA = 0	
SET @arestaB = 10
SET @arestaC = 10
		
IF (@arestaA = 0 OR @arestaB = 0 OR @arestaC = 0)
BEGIN 
	print('O valores informados não correspondem um triângulo!')
END	
ELSE
BEGIN
	IF (@arestaA = @arestaB AND @arestaB = @arestaC)
	BEGIN
		print('Triângulo Equilátero!')
	END
	ELSE
	BEGIN
		IF (@arestaA != @arestaB AND @arestaB != @arestaC AND @arestaA != @arestaC)
		BEGIN 
			print('Triângulo Escaleno!')
		END
		ELSE
		BEGIN
			print('Triângulo Isósceles!')
		END
	END
END	


 -- Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles
 
 DECLARE @x DECIMAL(7,2)
 
 SET @x = 8
 
 IF (@x % 2 = 0) 
 BEGIN 
 PRINT('É múltiplo de 2')
 END
 IF (@x % 3 = 0) 
 BEGIN 
 PRINT('É múltiplo de 3')
 END
 IF (@x % 5 = 0) 
 BEGIN 
 PRINT('É múltiplo de 5')
 END
 IF NOT(@x % 2 = 0 OR @x % 3 = 0 OR @x % 5 = 0)
 BEGIN
 PRINT('Não é múltiplo de nenhum dos anteriores!')
 END 
 
 
 
 -- Fazer um algoritmo que leia 3 número e mostre o maior e o menor
 DECLARE @n1 DECIMAL(7,2),
		 @n2 DECIMAL(7,2),
		 @n3 DECIMAL(7,2)
		 
SET @n1 = 1		 
SET @n2 = 7
SET @n3 = 4
		 
IF (@n1 > @n2 AND @n1 > @n3 AND @n2 > @n3) 
BEGIN
	PRINT('MAIOR: n1   MENOR: n3')
END
IF (@n3 > @n2 AND @n3 > @n1 AND @n2 > @n1) 
BEGIN
	PRINT('MAIOR: n3   MENOR: n1')
END

IF (@n1 > @n2 AND @n1 > @n3 AND @n3 > @n2) 
BEGIN
	PRINT('MAIOR: n1   MENOR: n2')
END
IF (@n2 > @n3 AND @n2 > @n1 AND @n3 > @n1) 
BEGIN
	PRINT('MAIOR: n2   MENOR: n1')
END		

IF (@n2 > @n1 AND @n2 > @n3 AND @n1 > @n3) 
BEGIN
	PRINT('MAIOR: n2   MENOR: n3')
END
IF (@n3 > @n1 AND @n3 > @n2 AND @n1 > @n2) 
BEGIN
	PRINT('MAIOR: n3   MENOR: n2')
END	

 


/*
Fazer um algoritmo que calcule os 15 primeiros termos da série
1,1,2,3,5,8,13,21,...
E calcule a soma dos 15 termos
*/

DECLARE @i INT,
		@atual INT,
		@anterior INT,
		@soma INT
		 
SET @i = 0
SET @atual = 1
SET @anterior = 0
SET @soma = 0

WHILE (@i < 15)
BEGIN
	IF (@i = 0)
	BEGIN
		PRINT('T' + CAST(@i+1 AS VARCHAR) + '-> ' + CAST(@atual AS VARCHAR))
	END
	ELSE
	BEGIN
		SET @atual = @atual + @anterior
		SET @anterior = @atual - @anterior
		PRINT('T' + CAST(@i+1 AS VARCHAR) + '-> ' + CAST(@atual AS VARCHAR))
	END
SET @soma = @soma + @atual	
SET @i = @i + 1
END
PRINT('A SOMA DOS 15 PRIMEIROS TERMOS É:' + CAST(@soma AS VARCHAR))






-- Fazer um algorimto que separa uma frase, colocando todas as letras em maiúsculo e em minúsculo
DECLARE @frase VARCHAR(100),
		@novaFrase VARCHAR(100),
		@cont INT
SET @frase = 'Required. The string to extract from'
SET @novaFrase = ''
SET @cont = 0

WHILE (@cont < LEN(@frase))
BEGIN
	SET @novaFrase	= @novaFrase + UPPER(SUBSTRING(@frase, @cont+1, 1))
	SET @cont = @cont + 1
END
PRINT @novaFrase
SET @novaFrase = ''
SET @cont = 0
WHILE (@cont < LEN(@frase))
BEGIN
	SET @novaFrase = @novaFrase + LOWER(SUBSTRING(@frase, @cont+1, 1))
	SET @cont = @cont + 1
END
PRINT @novaFrase





-- Fazer um algoritmo que inverta uma palavra
DECLARE @palavra VARCHAR(100),
		@palavraInvert VARCHAR(100),
		@cont INT
        
SET @palavra = 'tenet'
SET @palavraInvert = ''
SET @cont = 0

WHILE (@cont < LEN(@palavra))
BEGIN
	SET @palavraInvert = @palavraInvert + SUBSTRING(@palavra, LEN(@palavra) - @cont, 1) 
	SET @cont = @cont + 1
END
PRINT @palavraInvert





-- Verificar palindromo
DECLARE @palavra VARCHAR(100),
		@palavraInvert VARCHAR(100),
		@cont INT
	
SET @palavra = 'otto'
SET @palavraInvert = ''
SET @cont = 0

WHILE (@cont < LEN(@palavra))
BEGIN
	SET @palavraInvert = @palavraInvert + SUBSTRING(@palavra, LEN(@palavra) - @cont, 1) 
	SET @cont = @cont + 1
END
IF (@palavraInvert = @palavra)
BEGIN
	PRINT('É palindromo!')
END
ELSE
BEGIN
	PRINT('Não é palindromo')
END


/*
Fazer, e m  SQL S erver,  o algoritmo a baixo, salientando que se deve 
verificar se um CPF, setado, é válido, comparando seu número com  seu 
dígito.  
Ex.: CPF: 235..656.323-90 
Saída: Válido ou Inválido
Apesar de satisfazerem o algoritmo, os CPF com todos os números iguais 
devem ser considerados inválidos.
*/

DECLARE @cpf BIGINT,
		@soma INT,
		@cont INT,
		@digito1 VARCHAR,
		@digito2 VARCHAR 

SET @cpf = 31342125802
SET @soma = 0
SET @cont = 10
SET @digito1 = ''
SET	@digito2 = '' 

WHILE(@cont > 1)
BEGIN
SET @soma = @soma + CAST(SUBSTRING(CAST(@cpf AS VARCHAR), 10 - @cont, 1) AS INT) * @cont
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

SET @soma = 0
SET @cont = 11

WHILE(@cont > 1)
BEGIN
SET @soma = @soma + CAST(SUBSTRING(CAST(@cpf AS VARCHAR), 11 - @cont, 1) AS INT) * @cont
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

IF(@digito1 = SUBSTRING(CAST(@cpf AS VARCHAR), 10, 1)
	AND @digito2 = SUBSTRING(CAST(@cpf AS VARCHAR), 11, 1))
BEGIN
	PRINT('Válido')
END
ELSE
BEGIN
	PRINT('Inválido')
END



















		





		 


		
		