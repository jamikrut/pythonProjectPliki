use jamikrut
select DB_NAME()

CREATE TABLE Customers
(
    ID              int PRIMARY KEY,
    Firstname       nvarchar(50) NOT NULL,
    Lastname        nvarchar(50) NOT NULL,
    WrongColumnName date
)

SELECT *
FROM Customers

ALTER TABLE Customers
    DROP COLUMN WrongColumnName

SELECT *
FROM Customers

ALTER TABLE Customers
    ADD BirthDate date


DROP TABLE IF EXISTS Ingredients

-- Tabela ze składnikami

CREATE TABLE Ingredients
(
    ingredient_id   int IDENTITY PRIMARY KEY, -- PK, not null
    ingredient_name nvarchar(100) NOT NULL,
    calories        int,
    type            varchar(20)
)

INSERT INTO Ingredients (ingredient_name, calories)
VALUES (N'Bagietki francuskie', 70),
       (N'Bułeczki do hot-dogów', 283),
       (N'Chałki zdobne', 335)

SELECT * FROM Ingredients

--"NAME";"CALORIES";"PROTEIN";"FAT";"CARBS";"FIBER";"TYPE"

-- "NAME";"CALORIES";"PROTEIN";"FAT";"CARBS";"FIBER";"TYPE"
-- "Bagietki francuskie";283;8.70;1.70;59.2;2;"BREAD"
-- "Bułeczki do hot-dogów";341;9.50;7.50;59.8;1.8;"BREAD"

INSERT INTO Customers (ID, Firstname, Lastname, BirthDate)
VALUES (1, 'John', 'Smith', '19800105')