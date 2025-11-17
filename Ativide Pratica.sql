-- Geração de Modelo Físico
-- SQL ANSI 2003 - brModelo

CREATE TABLE Funcionario (
    cod_func INTEGER PRIMARY KEY,
    nome_func VARCHAR(80) NOT NULL,
    numero_matricula VARCHAR(50) NOT NULL,
    sexo CHAR(1),
    endereco VARCHAR(50),
    telefone VARCHAR(20),
    email VARCHAR(80),
    rg VARCHAR(20),
    cpf CHAR(11),
    dt_nasc DATE,
    dt_admissao DATE
);

CREATE TABLE Departamento (
    cod_dep INTEGER PRIMARY KEY,
    nome_dep VARCHAR(80) NOT NULL,
    sigla_dep VARCHAR(4),
    responsavel_dep VARCHAR(80),
    ramal VARCHAR(10),
    cod_func INTEGER,
    endereco VARCHAR(40),
    FOREIGN KEY (cod_func) REFERENCES Funcionario (cod_func)
);

-- Inserção de Funcionários
INSERT INTO Funcionario 
(cod_func, nome_func, numero_matricula, sexo, endereco, telefone, email, rg, cpf, dt_admissao) 
VALUES 
(1, 'Machado de Assis', 'MAT001', 'M', 'Av. das Orquídeas', '6599888333', 'machado@gmail.com', '111222 SSP-MT', '12345678901', '2020-03-01');

-- Atualização de funcionário
UPDATE funcionario 
SET endereco = 'Av. das Palmeiras'
WHERE cod_func = 1;

-- Inserção de mais funcionários
INSERT INTO funcionario 
(cod_func, nome_func, numero_matricula, email, dt_nasc, rg, sexo, dt_admissao, telefone, endereco) 
VALUES
(2, 'Paulo', 'MAT002', 'paulo@gmail.com', '1989-10-12', '333344 SSP-MT', 'M', '2020-05-01', '65 99239080', 'Av. das Orquídeas'),
(3, 'Pereira', 'MAT003', 'pereira@gmail.com', '1960-07-27', '111444 SSP-MT', 'M', '2019-01-01', '65 992567895', 'Av. Via Palácio Residencial'),
(4, 'Ronaldo', 'MAT004', 'ronaldo@gmail.com', '1945-08-27', '111333 SSP-MT', 'M', '2003-01-01', '65 992389171', 'Av. Polícia Federal'),
(5, 'Wagner', 'MAT005', 'wagner@gmail.com', '1947-12-14', '111555 SSP-MT', 'F', '2011-01-01', '65 992385959', 'Av. Isaac Póvoas');

-- Inserção de Departamentos
INSERT INTO departamento (cod_dep, cod_func, responsavel_dep, sigla_dep, nome_dep, ramal, endereco)  
VALUES 
(1, 1, 'Prof. André', 'NTI', 'Núcleo de Tecnologia da Informação', '3613-2323', 'Av. Beira Mar'), 
(2, 2, 'Airton Sena', 'PR', 'Presidência', '6543-2543', 'Av. Beira Mar'), 
(3, 3, 'Pelé', 'PR', 'Presidência', '6538-2323', 'Brasília'), 
(4, 4, 'Elizabeth', 'NTI', 'Núcleo de Tecnologia da Informação', '3613-2323', 'CPA-04'), 
(5, 5, 'Pereira', 'NTI', 'Núcleo de Desenvolvimento do Brasil', '3613-2323', 'Paraná');

-- Atualizar sigla
UPDATE departamento  
SET sigla_dep = 'MdF'   
WHERE cod_dep = 5;

-- Consultas
SELECT cod_func, nome_func, email, dt_nasc, rg, sexo, dt_admissao, telefone, endereco 
FROM funcionario;

SELECT cod_dep, cod_func, responsavel_dep, sigla_dep, nome_dep, ramal, endereco
FROM departamento;

SELECT nome_func, dt_admissao, responsavel_dep, nome_dep 
FROM funcionario
JOIN departamento ON funcionario.cod_func = departamento.cod_func;
