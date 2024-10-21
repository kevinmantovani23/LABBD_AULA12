CREATE DATABASE exIMCjasper
USE exIMCjasper

CREATE TABLE pessoa(
id			INT,
nome		VARCHAR(60),
altura		INT,
peso		INT,
PRIMARY KEY(id)
)

CREATE alter FUNCTION f_tabela_info()

RETURNS @tabela TABLE(
id		INT,
nome	VARCHAR(60), 
altura  DECIMAL(5,2),
peso	INT,
imc		DECIMAL(5,2),
situacao VARCHAR(100)
)
AS
BEGIN

	DECLARE @id INT
	DECLARE @nome VARCHAR(60)
	DECLARE @alturaOrg INT
	DECLARE @altura DECIMAL(5,2)
	DECLARE @peso INT
	DECLARE @imc DECIMAL(5,2)
	DECLARE @situacao VARCHAR(100)

	DECLARE cPessoa CURSOR FOR SELECT p.id, p.nome, p.altura, p.peso FROM pessoa p
	OPEN cPessoa
	FETCH NEXT FROM cPessoa INTO @id, @nome, @alturaOrg, @peso
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @altura = CAST((@alturaOrg / 100.0) AS DECIMAL (5,2))
		SET @imc = CAST((@peso / (@altura * @altura)) AS DECIMAL(5,2))
		/*Menor que 16: Magreza grave
			• Entre 16 e 16,9: Magreza moderada
			• Entre 17 e 18,5: Magreza leve
			• Entre 18,6 e 24,9: Peso ideal
			• Entre 25 e 29,9: Sobrepeso
			• Entre 30 e 34,9: Obesidade grau I
			• Entre 35 e 39,9: Obesidade grau II ou severa
			• Maior que 40: Obesidade grau III ou mórbida
		*/
		IF @imc < 16
		BEGIN
			SET @situacao = 'Magreza grave'
		END

		IF @imc >= 16 AND @imc < 17
		BEGIN
			SET @situacao = 'Magreza moderada'
		END

		IF @imc >= 17 AND @imc < 18.6
		BEGIN
			SET @situacao = 'Magreza leve'
		END

		IF @imc >= 18.6 AND @imc < 25
		BEGIN
			SET @situacao = 'Peso ideal'
		END

		IF @imc >= 25 AND @imc < 30
		BEGIN
			SET @situacao = 'Sobrepeso'
		END

		IF @imc >= 30 AND @imc < 35
		BEGIN
			SET @situacao = 'Obesidade grau I'
		END

		IF @imc >= 35 AND @imc < 40
		BEGIN
			SET @situacao = 'Obesidade grau II ou severa'
		END

		IF @imc >= 40
		BEGIN
			SET @situacao = 'Obesidade grau III ou mórbida'
		END
		INSERT INTO @tabela VALUES(@id, @nome, @altura, @peso, @imc, @situacao)
		FETCH NEXT FROM cPessoa INTO @id, @nome, @altura, @peso
		END
		CLOSE cPessoa
		DEALLOCATE cPessoa
		RETURN
		
END

INSERT INTO pessoa VALUES (1,'Miguel',184,65)
INSERT INTO pessoa VALUES (2,'Arthur',181,85)
INSERT INTO pessoa VALUES (3,'Gael',200,65)
INSERT INTO pessoa VALUES (4,'Théo',162,102)
INSERT INTO pessoa VALUES (5,'Heitor',202,81)
INSERT INTO pessoa VALUES (6,'Ravi',150,91)
INSERT INTO pessoa VALUES (7,'Davi',164,140)
INSERT INTO pessoa VALUES (8,'Bernardo',155,125)
INSERT INTO pessoa VALUES (9,'Noah',155,78)
INSERT INTO pessoa VALUES (10,'Gabriel',191,108)
INSERT INTO pessoa VALUES (11,'Samuel',170,99)
INSERT INTO pessoa VALUES (12,'Pedro',184,85)
INSERT INTO pessoa VALUES (13,'Anthony',205,116)
INSERT INTO pessoa VALUES (14,'Isaac',163,120)
INSERT INTO pessoa VALUES (15,'Benício',205,87)
INSERT INTO pessoa VALUES (16,'Benjamin',171,95)
INSERT INTO pessoa VALUES (17,'Matheus',186,87)
INSERT INTO pessoa VALUES (18,'Lucas',178,134)
INSERT INTO pessoa VALUES (19,'Joaquim',152,136)
INSERT INTO pessoa VALUES (20,'Nicolas',203,116)
INSERT INTO pessoa VALUES (21,'Lucca',170,83)
INSERT INTO pessoa VALUES (22,'Lorenzo',198,76)
INSERT INTO pessoa VALUES (23,'Henrique',192,66)
INSERT INTO pessoa VALUES (24,'João Miguel',203,120)
INSERT INTO pessoa VALUES (25,'Rafael',183,87)
INSERT INTO pessoa VALUES (26,'Henry',161,74)
INSERT INTO pessoa VALUES (27,'Murilo',172,75)
INSERT INTO pessoa VALUES (28,'Levi',164,123)
INSERT INTO pessoa VALUES (29,'Guilherme',204,79)
INSERT INTO pessoa VALUES (30,'Vicente',198,137)
INSERT INTO pessoa VALUES (31,'Felipe',168,70)
INSERT INTO pessoa VALUES (32,'Bryan',170,95)
INSERT INTO pessoa VALUES (33,'Matteo',195,74)
INSERT INTO pessoa VALUES (34,'Bento',179,113)
INSERT INTO pessoa VALUES (35,'João Pedro',152,112)
INSERT INTO pessoa VALUES (36,'Pietro',190,105)
INSERT INTO pessoa VALUES (37,'Leonardo',182,92)
INSERT INTO pessoa VALUES (38,'Daniel',198,83)
INSERT INTO pessoa VALUES (39,'Gustavo',205,95)
INSERT INTO pessoa VALUES (40,'Pedro Henrique',192,75)

select * from dbo.f_tabela_info()