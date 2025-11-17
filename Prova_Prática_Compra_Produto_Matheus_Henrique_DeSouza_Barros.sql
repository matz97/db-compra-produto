-- Prova Prática - Compra Produto
-- Autor: Matheus Souza
-- SGBD: PostgreSQL
-- Nome do arquivo: Prova_Prática_Compra_Produto_Matheus_Souza.sql

------------------------------------------------------------
-- PARTE 1: CRIAÇÃO DAS TABELAS
------------------------------------------------------------

-- Tabela Cliente
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20)
);

-- Tabela Atendente
CREATE TABLE atendente (
    id_atendente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

-- Tabela Produto
CREATE TABLE produto (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor NUMERIC(10,2) NOT NULL
);

-- Tabela Compra
CREATE TABLE compra (
    id_compra SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_atendente INT NOT NULL,
    data_compra DATE NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_atendente FOREIGN KEY (id_atendente) REFERENCES atendente(id_atendente)
);

-- Tabela Compra_Produto (itens de compra)
CREATE TABLE compra_produto (
    id_compra_produto SERIAL PRIMARY KEY,
    id_compra INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario NUMERIC(10,2) NOT NULL,
    CONSTRAINT fk_compra FOREIGN KEY (id_compra) REFERENCES compra(id_compra),
    CONSTRAINT fk_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

------------------------------------------------------------
-- PARTE 2: INSERÇÃO DE DADOS
------------------------------------------------------------

INSERT INTO cliente (nome, email, telefone) VALUES
('Maria Silva', 'maria.silva@email.com', '1199999-0001'),
('João Pereira', 'joao.p@email.com', '1199999-0002'),
('Ana Costa', 'ana.costa@email.com', '1199999-0003');

INSERT INTO atendente (nome, email) VALUES
('Carlos Mendes', 'carlos.m@empresa.com'),
('Fernanda Lima', 'fernanda.l@empresa.com'),
('Paulo Santos', 'paulo.s@empresa.com');

INSERT INTO produto (nome, valor) VALUES
('Mouse Gamer', 150.00),
('Teclado Mecânico', 350.00),
('Monitor 24 Polegadas', 900.00);

INSERT INTO compra (id_cliente, id_atendente, data_compra) VALUES
(1, 1, '2025-10-05'),
(2, 2, '2025-10-10'),
(1, 3, '2025-10-15');

INSERT INTO compra_produto (id_compra, id_produto, quantidade, valor_unitario) VALUES
(1, 1, 2, 150.00),
(1, 2, 1, 350.00),
(2, 3, 1, 900.00),
(3, 2, 2, 350.00),
(3, 1, 1, 150.00);

------------------------------------------------------------
-- PARTE 3: CONSULTAS SQL
------------------------------------------------------------

-- 1. Nome do cliente, nome do atendente e valor total de cada compra
SELECT co.id_compra,
       c.nome AS cliente,
       a.nome AS atendente,
       SUM(cp.quantidade * cp.valor_unitario) AS valor_total
FROM compra co
JOIN cliente c ON co.id_cliente = c.id_cliente
JOIN atendente a ON co.id_atendente = a.id_atendente
JOIN compra_produto cp ON co.id_compra = cp.id_compra
GROUP BY co.id_compra, c.nome, a.nome;

-- 2. Produtos vendidos, quantidade e valor parcial por compra
SELECT co.id_compra,
       p.nome AS produto,
       cp.quantidade,
       (cp.quantidade * cp.valor_unitario) AS valor_parcial
FROM compra_produto cp
JOIN produto p ON cp.id_produto = p.id_produto
JOIN compra co ON cp.id_compra = co.id_compra;

-- 3. Compras após 01/10/2025
SELECT * FROM compra
WHERE data_compra > '2025-10-01';

-- 4. Clientes que realizaram mais de uma compra
SELECT c.nome,
       COUNT(*) AS total_compras
FROM compra co
JOIN cliente c ON co.id_cliente = c.id_cliente
GROUP BY c.nome
HAVING COUNT(*) > 1;

------------------------------------------------------------
-- PARTE 4: ALTERAÇÕES E ATUALIZAÇÕES
------------------------------------------------------------

-- 1. Adicionar coluna estoque na tabela produto
ALTER TABLE produto ADD COLUMN estoque INT;

-- 2. Atualizar estoque de todos os produtos para 100
UPDATE produto SET estoque = 100;

-- 3. Atualizar email da cliente Maria Silva
UPDATE cliente SET email = 'maria.silva@novoemail.com'
WHERE nome = 'Maria Silva';

------------------------------------------------------------
-- PARTE 5: CONSULTAS DE AGREGAÇÃO E JUNÇÃO
------------------------------------------------------------

-- 1. Total geral de vendas
SELECT SUM(cp.quantidade * cp.valor_unitario) AS total_geral_vendas
FROM compra_produto cp;

-- 2. Nome do produto mais caro e seu valor
SELECT nome, valor
FROM produto
ORDER BY valor DESC
LIMIT 1;

-- 3. Atendentes e número de vendas
SELECT a.nome,
       COUNT(*) AS numero_vendas
FROM compra co
JOIN atendente a ON co.id_atendente = a.id_atendente
GROUP BY a.nome;
