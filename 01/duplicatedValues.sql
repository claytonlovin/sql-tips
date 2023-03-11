

-- 1 CRIAR A TABELA USUARIO 

CREATE TABLE Usuarios (
  id_usuario INT PRIMARY KEY,
  nome VARCHAR(50),
  email VARCHAR(50)
);


-- 2 CRIA A TABELA GRUPO 
CREATE TABLE Grupo (
  id_grupo INT PRIMARY KEY,
  nome_grupo VARCHAR(50)
);


-- 3 CRIA TABELA GRUPO USUARIO 
CREATE TABLE Grupo_Usuario (
  id_grupo_usuario INT IDENTITY(1,1),
  id_grupo INT,
  id_usuario INT,
  PRIMARY KEY (id_grupo_usuario),
  FOREIGN KEY (id_grupo) REFERENCES Grupo(id_grupo),
  FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- 4 INSERIR NA USUARIO NA GRUPO E NA GRUPO_USUARIO

INSERT INTO Usuarios (id_usuario, nome, email)
VALUES (1, 'João', 'joao@gmail.com'),
       (2, 'Maria', 'maria@gmail.com'),
       (3, 'José', 'jose@gmail.com'),
       (4, 'Ana', 'ana@gmail.com');

INSERT INTO Grupo (id_grupo, nome_grupo)
VALUES (1, 'Grupo A'),
       (2, 'Grupo B'),
       (3, 'Grupo C');

INSERT INTO Grupo_Usuario (id_grupo, id_usuario)
VALUES (1, 1),
       (1, 2),
       (2, 2),
       (2, 3),
       (2, 3),
       (3, 1),
       (3, 2),
       (3, 3),
       (3, 4),
       (3, 4);


-- 5 SELECIONAR VALORES DUPLICADOS

SELECT * FROM  Grupo_Usuario

SELECT
  gu.id_grupo, 
  gu.id_usuario, 
  u.nome, 
  COUNT(*) AS quantidade_duplicados 
FROM Grupo_Usuario gu 
INNER JOIN Usuarios u ON gu.id_usuario = u.id_usuario 
GROUP BY gu.id_grupo, gu.id_usuario, u.nome 
HAVING COUNT(*) > 1;

-- 6 DELETAR VALORES DUPLICADOS

BEGIN TRAN


;WITH cte AS (
  SELECT 
    id_grupo, 
    id_usuario, 
    ROW_NUMBER() OVER (PARTITION BY id_grupo, id_usuario ORDER BY (SELECT 0)) AS rn
  FROM Grupo_Usuario
)
DELETE FROM cte WHERE rn > 1;


SELECT * FROM Grupo_Usuario


ROLLBACK