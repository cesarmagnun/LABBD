USE LBD

/*Fazer um algoritmo que leia 3 valores e retorne se os valores formam um tri�ngulo e se ele �
is�celes, escaleno ou equil�tero.
Condi��es para formar um tri�ngulo
	Nenhum valor pode ser = 0
	Um lado n�o pode ser maior que a soma dos outros 2.
*/
DECLARE @arestaA DECIMAL(7,2),	
		@arestaB DECIMAL(7,2),
		@arestaC DECIMAL(7,2)
		
SET @arestaA = 0	
SET @arestaB = 10
SET @arestaC = 10
		
IF (@arestaA = 0 OR @arestaB = 0 OR @arestaC = 0)
BEGIN 
	print('O valores informados n�o correspondem um tri�ngulo!')
END	
ELSE
BEGIN
	IF (@arestaA = @arestaB AND @arestaB = @arestaC)
	BEGIN
		print('Tri�ngulo Equil�tero!')
	END
	ELSE
	BEGIN
		IF (@arestaA != @arestaB AND @arestaB != @arestaC AND @arestaA != @arestaC)
		BEGIN 
			print('Tri�ngulo Escaleno!')
		END
		ELSE
		BEGIN
			print('Tri�ngulo Is�sceles!')
		END
	END
END	


 -- Fazer um algoritmo que leia 1 n�mero e mostre se s�o m�ltiplos de 2,3,5 ou nenhum deles
 
 DECLARE @x DECIMAL(7,2)
 
 SET @x = 8
 
 IF (@x % 2 = 0) 
 BEGIN 
 PRINT('� m�ltiplo de 2')
 END
 IF (@x % 3 = 0) 
 BEGIN 
 PRINT('� m�ltiplo de 3')
 END
 IF (@x % 5 = 0) 
 BEGIN 
 PRINT('� m�ltiplo de 5')
 END
 IF NOT(@x % 2 = 0 OR @x % 3 = 0 OR @x % 5 = 0)
 BEGIN
 PRINT('N�o � m�ltiplo de nenhum dos anteriores!')
 END 
 
 
 
 -- Fazer um algoritmo que leia 3 n�mero e mostre o maior e o menor
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
Fazer um algoritmo que calcule os 15 primeiros termos da s�rie
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
PRINT('A SOMA DOS 15 PRIMEIROS TERMOS �:' + CAST(@soma AS VARCHAR))






-- Fazer um algorimto que separa uma frase, colocando todas as letras em mai�sculo e em min�sculo
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
	PRINT('� palindromo!')
END
ELSE
BEGIN
	PRINT('N�o � palindromo')
END


/*
Fazer, e m  SQL S erver,  o algoritmo a baixo, salientando que se deve 
verificar se um CPF, setado, � v�lido, comparando seu n�mero com  seu 
d�gito.  
Ex.: CPF: 235..656.323-90 
Sa�da: V�lido ou Inv�lido
Apesar de satisfazerem o algoritmo, os CPF com todos os n�meros iguais 
devem ser considerados inv�lidos.
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
	PRINT('V�lido')
END
ELSE
BEGIN
	PRINT('Inv�lido')
END



















		





		 


		
		