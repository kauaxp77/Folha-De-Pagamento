CREATE DATABASE gestao_estoque;


CREATE TABLE Usuario (
    idUsuario INT NOT NULL,
    emailUsuario VARCHAR(45),
    nomeUsuario VARCHAR(45),
    senhaUsuario VARCHAR(45),
    telefoneUsuario VARCHAR(45)
);

CREATE TABLE almoxarifado (
    idAlmoxarifado INT NOT NULL,
    nome VARCHAR(45),
    endereco VARCHAR(45),
    capacidade INT
);

CREATE TABLE categoria (
    idCategoria INT NOT NULL,
    nomeCategoria VARCHAR(45) -- Adicionado para funcionalidade
);

CREATE TABLE Produto (
    idProduto INT NOT NULL,
    nomeProduto VARCHAR(45),
    estoqueMaximo INT,
    estoqueMinimo INT,
    categoria_idCategoria INT NOT NULL -- FK de 'categoria'
);

CREATE TABLE lote (
    idLote INT NOT NULL,
    dataFabricacao DATE,
    Produto_idProduto INT NOT NULL, -- FK de 'Produto'
    almoxarifado_idAlmoxarifado INT NOT NULL -- FK de 'almoxarifado'
);

CREATE TABLE verificacaoEstoque (
    id_verificacaoEstoque INT NOT NULL,
    Usuario_idUsuario INT NOT NULL, -- FK de 'Usuario'
    Produto_idProduto INT NOT NULL, -- FK de 'Produto'
    lote_idLote INT NOT NULL, -- FK de 'lote' (corrigido de lote_idProduto)
    almoxarifado_idAlmoxarifado INT NOT NULL, -- FK de 'almoxarifado'
    quantidadeAtual INT,
    dataVerificacao DATE,
    situacao VARCHAR(50),
    verificacaoEstoque VARCHAR(45)
);


-- =============================================
-- PARTE 2: CRIAÇÃO DAS PKS (Primary Keys)
-- =============================================

ALTER TABLE Usuario ADD PRIMARY KEY (idUsuario);
ALTER TABLE almoxarifado ADD PRIMARY KEY (idAlmoxarifado);
ALTER TABLE categoria ADD PRIMARY KEY (idCategoria);
ALTER TABLE Produto ADD PRIMARY KEY (idProduto);
ALTER TABLE lote ADD PRIMARY KEY (idLote);
ALTER TABLE verificacaoEstoque ADD PRIMARY KEY (id_verificacaoEstoque);

-- Adicionando AUTO_INCREMENT para facilitar as inserções
ALTER TABLE Usuario MODIFY idUsuario INT NOT NULL AUTO_INCREMENT;
ALTER TABLE almoxarifado MODIFY idAlmoxarifado INT NOT NULL AUTO_INCREMENT;
ALTER TABLE categoria MODIFY idCategoria INT NOT NULL AUTO_INCREMENT;
ALTER TABLE Produto MODIFY idProduto INT NOT NULL AUTO_INCREMENT;
ALTER TABLE lote MODIFY idLote INT NOT NULL AUTO_INCREMENT;
ALTER TABLE verificacaoEstoque MODIFY id_verificacaoEstoque INT NOT NULL AUTO_INCREMENT;


-- =============================================
-- PARTE 3: CRIAÇÃO DAS FKS (Foreign Keys)
-- =============================================
-- (Implementando os relacionamentos 1:N do diagrama)

-- Produto (N) PERTENCE (1) Categoria
ALTER TABLE Produto 
ADD CONSTRAINT fk_Produto_categoria
    FOREIGN KEY (categoria_idCategoria) 
    REFERENCES categoria (idCategoria);

-- Lote (N) CONTEM (1) Produto
-- Lote (N) ARMAZENADO (1) Almoxarifado
ALTER TABLE lote 
ADD CONSTRAINT fk_lote_Produto
    FOREIGN KEY (Produto_idProduto) 
    REFERENCES Produto (idProduto),
ADD CONSTRAINT fk_lote_almoxarifado
    FOREIGN KEY (almoxarifado_idAlmoxarifado) 
    REFERENCES almoxarifado (idAlmoxarifado);

-- verificacaoEstoque (N) FAZ (1) Usuario
-- verificacaoEstoque (N) VERIFICADO (1) Produto
-- verificacaoEstoque (N) ENVOLVIDO (1) Almoxarifado
-- (E o relacionamento implícito com Lote)
ALTER TABLE verificacaoEstoque 
ADD CONSTRAINT fk_verificacao_Usuario
    FOREIGN KEY (Usuario_idUsuario) 
    REFERENCES Usuario (idUsuario),
ADD CONSTRAINT fk_verificacao_Produto
    FOREIGN KEY (Produto_idProduto) 
    REFERENCES Produto (idProduto),
ADD CONSTRAINT fk_verificacao_lote
    FOREIGN KEY (lote_idLote) 
    REFERENCES lote (idLote),
ADD CONSTRAINT fk_verificacao_almoxarifado
    FOREIGN KEY (almoxarifado_idAlmoxarifado) 
    REFERENCES almoxarifado (idAlmoxarifado);


-- =============================================
-- PARTE 4: COMANDOS PARA INSERIR 10 REGISTROS
-- =============================================
-- (Ordem de inserção: tabelas independentes primeiro)

-- 10 Registros em 'Usuario' (com DDD 61)
INSERT INTO Usuario (emailUsuario, nomeUsuario, senhaUsuario, telefoneUsuario) VALUES
('joao.silva@email.com', 'João Silva', 'senha123', '61987654321'),
('maria.santos@email.com', 'Maria Santos', 'senha123', '61987654322'),
('pedro.almeida@email.com', 'Pedro Almeida', 'senha123', '61987654323'),
('ana.oliveira@email.com', 'Ana Oliveira', 'senha123', '61987654324'),
('carlos.pereira@email.com', 'Carlos Pereira', 'senha123', '61987654325'),
('lucia.ferreira@email.com', 'Lúcia Ferreira', 'senha123', '61987654326'),
('marcos.rodrigues@email.com', 'Marcos Rodrigues', 'senha123', '61987654327'),
('beatriz.lima@email.com', 'Beatriz Lima', 'senha123', '61987654328'),
('rafael.gomes@email.com', 'Rafael Gomes', 'senha123', '61987654329'),
('fernanda.costa@email.com', 'Fernanda Costa', 'senha123', '61987654330');

-- 10 Registros em 'almoxarifado'
INSERT INTO almoxarifado (nome, endereco, capacidade) VALUES
('Principal - Brasília', 'SIA Trecho 10', 1000),
('Secundário - Taguatinga', 'Pistão Sul', 500),
('Refrigerados - Ceilândia', 'QNN 14', 200),
('Inflamáveis - Gama', 'Setor Industrial', 100),
('Matéria-Prima - Sobradinho', 'BR-020', 800),
('Produto Acabado - Guará', 'QI 20', 1200),
('Devoluções - Samambaia', 'QN 300', 150),
('Expedição - Valparaíso', 'BR-040', 300),
('Almoxarifado 09 - Luziânia', 'Centro', 100),
('Almoxarifado 10 - Formosa', 'Setor Leste', 100);

-- 10 Registros em 'categoria'
INSERT INTO categoria (nomeCategoria) VALUES
('Eletrônicos'),
('Parafusos'),
('Matéria-Prima'),
('Limpeza'),
('Escritório'),
('Hardware'),
('Software'),
('Alimentos'),
('Bebidas'),
('Ferramentas');

-- 10 Registros em 'Produto'
-- (IDs das categorias de 1 a 10)
INSERT INTO Produto (nomeProduto, estoqueMaximo, estoqueMinimo, categoria_idCategoria) VALUES
('Notebook Gamer', 50, 10, 1),
('Mouse Sem Fio', 200, 30, 1),
('Parafuso Sextavado M8', 5000, 500, 2),
('Resma A4', 1000, 100, 5),
('Água Sanitária 5L', 300, 50, 4),
('Trigo (Saca 50kg)', 100, 20, 3),
('Monitor 24"', 80, 15, 6),
('Café em Grão 1kg', 400, 40, 8),
('Martelo', 150, 20, 10),
('Licença Antivírus', 999, 10, 7);

-- 10 Registros em 'lote'
-- (IDs dos Produtos de 1 a 10, IDs dos Almoxarifados de 1 a 10)
INSERT INTO lote (dataFabricacao, Produto_idProduto, almoxarifado_idAlmoxarifado) VALUES
('2025-01-10', 1, 6), -- Notebook no Almox. Produto Acabado
('2025-02-15', 2, 6), -- Mouse no Almox. Produto Acabado
('2025-03-20', 3, 5), -- Parafuso no Almox. Matéria-Prima
('2025-04-01', 4, 1), -- Resma A4 no Almox. Principal
('2025-05-05', 5, 1), -- Água Sanitária no Almox. Principal
('2025-06-10', 6, 5), -- Trigo no Almox. Matéria-Prima
('2025-07-12', 7, 8), -- Monitor na Expedição
('2025-08-15', 8, 1), -- Café no Almox. Principal
('2025-09-01', 9, 10), -- Martelo no Almox. 10
('2025-10-20', 1, 6); -- Outro lote de Notebook no Almox. Produto Acabado

-- 10 Registros em 'verificacaoEstoque'
-- (IDs de 1 a 10 para todas as FKs)
INSERT INTO verificacaoEstoque (Usuario_idUsuario, Produto_idProduto, lote_idLote, almoxarifado_idAlmoxarifado, quantidadeAtual, dataVerificacao, situacao, verificacaoEstoque) VALUES
(1, 1, 1, 6, 20, '2025-11-01', 'OK', 'Contagem inicial'),
(2, 2, 2, 6, 150, '2025-11-01', 'OK', 'Contagem inicial'),
(1, 3, 3, 5, 4800, '2025-11-02', 'OK', 'Contagem inicial'),
(3, 4, 4, 1, 950, '2025-11-02', 'Abaixo', 'Repor estoque'),
(4, 5, 5, 1, 300, '2025-11-03', 'OK', 'Contagem inicial'),
(5, 6, 6, 5, 100, '2025-11-03', 'OK', 'Contagem inicial'),
(1, 7, 7, 8, 75, '2025-11-04', 'OK', 'Contagem inicial'),
(2, 8, 8, 1, 380, '2025-11-04', 'OK', 'Contagem inicial'),
(3, 9, 9, 10, 150, '2025-11-05', 'Excesso', 'Verificar máximo'),
(1, 1, 10, 6, 30, '2025-11-05', 'OK', 'Novo lote');


-- =============================================
-- PARTE 5: COMANDOS SELECTS (3 RELATÓRIOS)
-- =============================================

-- Relatório 1: Lista de todos os produtos, sua categoria e limites de estoque
SELECT 
    p.nomeProduto AS Produto,
    c.nomeCategoria AS Categoria,
    p.estoqueMinimo AS 'Estoque Mínimo',
    p.estoqueMaximo AS 'Estoque Máximo'
FROM Produto p
JOIN categoria c ON p.categoria_idCategoria = c.idCategoria
ORDER BY c.nomeCategoria, p.nomeProduto;


-- Relatório 2: Histórico de verificações de estoque com nome do usuário e do produto
SELECT 
    v.dataVerificacao AS 'Data',
    u.nomeUsuario AS 'Usuário',
    p.nomeProduto AS 'Produto Verificado',
    v.quantidadeAtual AS 'Quantidade',
    v.situacao AS 'Situação'
FROM verificacaoEstoque v
JOIN Usuario u ON v.Usuario_idUsuario = u.idUsuario
JOIN Produto p ON v.Produto_idProduto = p.idProduto
ORDER BY v.dataVerificacao DESC;


-- Relatório 3: Lotes de produtos, sua data de fabricação e onde estão armazenados
SELECT 
    p.nomeProduto AS 'Produto',
    l.idLote AS 'Lote',
    l.dataFabricacao AS 'Data Fabricação',
    a.nome AS 'Local (Almoxarifado)'
FROM lote l
JOIN Produto p ON l.Produto_idProduto = p.idProduto
JOIN almoxarifado a ON l.almoxarifado_idAlmoxarifado = a.idAlmoxarifado
ORDER BY p.nomeProduto, l.dataFabricacao;


-- =============================================
-- PARTE 6: COMANDOS SELECTS (3 INDICADORES GERENCIAIS)
-- =============================================

-- Indicador 1: Número de produtos por categoria
SELECT 
    c.nomeCategoria AS Categoria,
    COUNT(p.idProduto) AS 'Quantidade de Produtos'
FROM categoria c
LEFT JOIN Produto p ON c.idCategoria = p.categoria_idCategoria
GROUP BY c.nomeCategoria
ORDER BY COUNT(p.idProduto) DESC;


-- Indicador 2: Quantidade total de itens em cada almoxarifado
-- (Baseado na última verificação de cada lote)
SELECT 
    a.nome AS Almoxarifado,
    SUM(v.quantidadeAtual) AS 'Total de Itens Verificados'
FROM verificacaoEstoque v
JOIN almoxarifado a ON v.almoxarifado_idAlmoxarifado = a.idAlmoxarifado
GROUP BY a.nome
ORDER BY SUM(v.quantidadeAtual) DESC;


-- Indicador 3: Produtos que precisam de reposição (situação 'Abaixo')
SELECT 
    p.nomeProduto AS Produto,
    v.quantidadeAtual AS 'Quantidade Atual',
    p.estoqueMinimo AS 'Mínimo Necessário'
FROM verificacaoEstoque v
JOIN Produto p ON v.Produto_idProduto = p.idProduto
WHERE v.situacao = 'Abaixo';

