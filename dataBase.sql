-- =============================================
-- PARTE 1: CRIAÇÃO DO BANCO E TABELAS (Corrigido)
-- =============================================
CREATE DATABASE IF NOT EXISTS gestao_estoque;
USE gestao_estoque;

-- Limpando tabelas se existirem para re-execução
DROP TABLE IF EXISTS verificacaoEstoque, lote, Produto, categoria, almoxarifado, Usuario;

CREATE TABLE Usuario (
    idUsuario INT NOT NULL AUTO_INCREMENT,
    emailUsuario VARCHAR(45),
    nomeUsuario VARCHAR(45),
    senhaUsuario VARCHAR(45),
    telefoneUsuario VARCHAR(45),
    PRIMARY KEY (idUsuario)
);

CREATE TABLE almoxarifado (
    idAlmoxarifado INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45),
    endereco VARCHAR(45),
    capacidade INT,
    PRIMARY KEY (idAlmoxarifado)
);

CREATE TABLE categoria (
    idCategoria INT NOT NULL AUTO_INCREMENT,
    nomeCategoria VARCHAR(45),
    PRIMARY KEY (idCategoria)
);

CREATE TABLE Produto (
    idProduto INT NOT NULL AUTO_INCREMENT,
    nomeProduto VARCHAR(45),
    estoqueMaximo INT,
    estoqueMinimo INT,
    categoria_idCategoria INT NOT NULL,
    PRIMARY KEY (idProduto),
    CONSTRAINT fk_Produto_categoria
        FOREIGN KEY (categoria_idCategoria) 
        REFERENCES categoria (idCategoria)
);

CREATE TABLE lote (
    idLote INT NOT NULL AUTO_INCREMENT,
    dataFabricacao DATE,
    Produto_idProduto INT NOT NULL,
    almoxarifado_idAlmoxarifado INT NOT NULL,
    PRIMARY KEY (idLote),
    CONSTRAINT fk_lote_Produto
        FOREIGN KEY (Produto_idProduto) 
        REFERENCES Produto (idProduto),
    CONSTRAINT fk_lote_almoxarifado
        FOREIGN KEY (almoxarifado_idAlmoxarifado) 
        REFERENCES almoxarifado (idAlmoxarifado)
);

-- CORRIGIDO: Tabela 'verificacaoEstoque' normalizada
CREATE TABLE verificacaoEstoque (
    id_verificacaoEstoque INT NOT NULL AUTO_INCREMENT,
    Usuario_idUsuario INT NOT NULL,
    lote_idLote INT NOT NULL, -- Apenas a FK do lote é necessária
    quantidadeAtual INT,
    dataVerificacao DATE,
    situacao VARCHAR(50),
    observacao VARCHAR(45), -- CORRIGIDO: Coluna renomeada
    PRIMARY KEY (id_verificacaoEstoque),
    CONSTRAINT fk_verificacao_Usuario
        FOREIGN KEY (Usuario_idUsuario) 
        REFERENCES Usuario (idUsuario),
    CONSTRAINT fk_verificacao_lote
        FOREIGN KEY (lote_idLote) 
        REFERENCES lote (idLote)
    -- REMOVIDO: FKs redundantes para Produto e Almoxarifado
);


-- =============================================
-- PARTE 4: COMANDOS PARA INSERIR 10 REGISTROS (Corrigido)
-- =============================================

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

INSERT INTO categoria (nomeCategoria) VALUES
('Descartáveis'),
('Instrumental Cirúrgico'),
('Resinas e Restauradores'),
('Endodontia'),
('Ortodontia'),
('Implantodontia'),
('Anestésicos'),
('Cimentos Odontológicos'),
('Equipamentos Periféricos'),
('Radiologia');

INSERT INTO Produto (nomeProduto, estoqueMaximo, estoqueMinimo, categoria_idCategoria) VALUES
('Caixa de Luvas Nitrílicas (100un)', 500, 50, 1),
('Máscara Cirúrgica Descartável (50un)', 1000, 100, 1),
('Fórceps nº 150 (Adulto)', 20, 5, 2),
('Kit Bráquetes Metálicos (Slot 22)', 150, 30, 5),
('Lima Manual K-File #25 (Caixa c/ 6)', 300, 40, 4),
('Resina Composta A3 (Seringa 4g)', 400, 50, 3),
('Implante Titânio Cone Morse 3.5x10mm', 80, 10, 6),
('Cimento de Ionômero de Vidro (Pó/Líquido)', 100, 20, 8),
('Sensor Digital Radiográfico', 10, 2, 10),
('Lidocaína 2% c/ Vaso (Caixa 50 tubetes)', 200, 40, 7);

INSERT INTO lote (dataFabricacao, Produto_idProduto, almoxarifado_idAlmoxarifado) VALUES
('2025-01-10', 1, 6), -- Lote 1
('2025-02-15', 2, 6), -- Lote 2
('2025-03-20', 3, 5), -- Lote 3
('2025-04-01', 4, 1), -- Lote 4
('2025-05-05', 5, 1), -- Lote 5
('2025-06-10', 6, 5), -- Lote 6
('2025-07-12', 7, 8), -- Lote 7
('2025-08-15', 8, 1), -- Lote 8
('2025-09-01', 9, 10), -- Lote 9
('2025-10-20', 1, 6); -- Lote 10 (outro lote de Luvas)

-- CORRIGIDO: INSERTs ajustados para a nova estrutura (sem IDs redundantes)
INSERT INTO verificacaoEstoque (Usuario_idUsuario, lote_idLote, quantidadeAtual, dataVerificacao, situacao, observacao) VALUES
(1, 1, 450, '2025-11-01', 'OK', 'Contagem inicial'),
(2, 2, 900, '2025-11-01', 'OK', 'Contagem inicial'),
(1, 3, 18, '2025-11-02', 'OK', 'Contagem inicial'),
(3, 4, 25, '2025-11-02', 'Abaixo', 'Repor estoque'),
(4, 5, 280, '2025-11-03', 'OK', 'Contagem inicial'),
(5, 6, 390, '2025-11-03', 'OK', 'Contagem inicial'),
(1, 7, 80, '2025-11-04', 'OK', 'Contagem inicial'),
(2, 8, 90, '2025-11-04', 'OK', 'Contagem inicial'),
(3, 9, 10, '2025-11-05', 'Excesso', 'Verificar máximo'),
(1, 10, 50, '2025-11-05', 'OK', 'Novo lote');


-- =============================================
-- PARTE 5: COMANDOS SELECTS (3 RELATÓRIOS) (Corrigido)
-- =============================================

-- Relatório 1: 
SELECT 
    p.nomeProduto AS Produto,
    c.nomeCategoria AS Categoria,
    p.estoqueMinimo AS 'Estoque Mínimo',
    p.estoqueMaximo AS 'Estoque Máximo'
FROM Produto p
JOIN categoria c ON p.categoria_idCategoria = c.idCategoria
ORDER BY c.nomeCategoria, p.nomeProduto;

-- Relatório 2: 
SELECT 
    v.dataVerificacao AS 'Data',
    u.nomeUsuario AS 'Usuário',
    p.nomeProduto AS 'Produto Verificado',
    v.quantidadeAtual AS 'Quantidade',
    v.situacao AS 'Situação',
    v.observacao AS 'Observação'
FROM verificacaoEstoque v
JOIN Usuario u ON v.Usuario_idUsuario = u.idUsuario
JOIN lote l ON v.lote_idLote = l.idLote
JOIN Produto p ON l.Produto_idProduto = p.idProduto
ORDER BY v.dataVerificacao DESC;

-- Relatório 3: (Sem alterações, estava correto)
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
-- PARTE 6: COMANDOS SELECTS (3 INDICADORES) (Corrigido)
-- =============================================

-- Indicador 1: (Sem alterações, estava correto)
SELECT 
    c.nomeCategoria AS Categoria,
    COUNT(p.idProduto) AS 'Quantidade de Produtos'
FROM categoria c
LEFT JOIN Produto p ON c.idCategoria = p.categoria_idCategoria
GROUP BY c.nomeCategoria
ORDER BY COUNT(p.idProduto) DESC;


-- Indicador 2: Quantidade total de itens em cada almoxarifado
WITH UltimaVerificacao AS (
    SELECT 
        v.quantidadeAtual,
        l.almoxarifado_idAlmoxarifado,
        ROW_NUMBER() OVER(PARTITION BY v.lote_idLote ORDER BY v.dataVerificacao DESC, v.id_verificacaoEstoque DESC) AS rn
    FROM verificacaoEstoque v
    JOIN lote l ON v.lote_idLote = l.idLote
)
SELECT 
    a.nome AS Almoxarifado,
    SUM(uv.quantidadeAtual) AS 'Total de Itens Atuais'
FROM UltimaVerificacao uv
JOIN almoxarifado a ON uv.almoxarifado_idAlmoxarifado = a.idAlmoxarifado
WHERE uv.rn = 1 -- Filtra apenas a verificação mais recente de cada lote
GROUP BY a.nome
ORDER BY SUM(uv.quantidadeAtual) DESC;


-- Indicador 3: Produtos que precisam de reposição (situação 'Abaixo')
WITH UltimaVerificacao AS (
    SELECT 
        v.quantidadeAtual,
        v.situacao,
        l.Produto_idProduto,
        ROW_NUMBER() OVER(PARTITION BY v.lote_idLote ORDER BY v.dataVerificacao DESC, v.id_verificacaoEstoque DESC) AS rn
    FROM verificacaoEstoque v
    JOIN lote l ON v.lote_idLote = l.idLote
)
SELECT 
    p.nomeProduto AS Produto,
    uv.quantidadeAtual AS 'Quantidade Atual',
    p.estoqueMinimo AS 'Mínimo Necessário'
FROM UltimaVerificacao uv
JOIN Produto p ON uv.Produto_idProduto = p.idProduto
WHERE uv.situacao = 'Abaixo' 
  AND uv.rn = 1; -- Filtra apenas a verificação mais recente


-- =============================================
-- PARTE 7 - Comandos UPDATEs para alterar 3 registros
-- =============================================

-- UPDATE 1: Corrigir o estoque mínimo de um produto.
-- (Altera o estoque mínimo do 'Kit Bráquetes' de 30 para 35)
UPDATE Produto
SET estoqueMinimo = 35
WHERE nomeProduto = 'Kit Bráquetes Metálicos (Slot 22)';

-- UPDATE 2: Alterar o telefone de um usuário.
-- (Altera o telefone da usuária 'Maria Santos')
UPDATE Usuario
SET telefoneUsuario = '6199999-1234'
WHERE emailUsuario = 'maria.santos@email.com';

-- UPDATE 3: Corrigir uma verificação de estoque.
-- (Muda a situação da verificação ID 9, que estava em 'Excesso', para 'OK')
UPDATE verificacaoEstoque
SET situacao = 'OK', observacao = 'Contagem de excesso corrigida'
WHERE id_verificacaoEstoque = 9;


-- =============================================
-- PARTE 8 - Comandos DELETE para excluir 3 registros
-- =============================================

-- DELETE 1: Excluir um almoxarifado que não está sendo usado.
-- (O almoxarifado 'Secundário - Taguatinga', ID 2, não possui lotes)
DELETE FROM almoxarifado
WHERE nome = 'Secundário - Taguatinga';

-- DELETE 2: Excluir uma categoria que não possui produtos.
-- (A categoria 'Equipamentos Periféricos', ID 9, não foi usada)
DELETE FROM categoria
WHERE nomeCategoria = 'Equipamentos Periféricos';

-- DELETE 3: Excluir um registro de verificação de estoque específico.
-- (Exclui a verificação ID 3, do 'Fórceps'. 
-- Isso é seguro pois nenhuma outra tabela depende da 'verificacaoEstoque')
DELETE FROM verificacaoEstoque
WHERE id_verificacaoEstoque = 3;