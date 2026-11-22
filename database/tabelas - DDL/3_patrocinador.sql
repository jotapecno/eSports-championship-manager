DROP TABLE IF EXISTS patrocinador;
-- ============================================================
-- 3ª TABELA: patrocinador
-- Descrição: Empresas e marcas parceiras ou financiadoras dos eventos.
-- Dependências: Nenhuma (tabela base).
-- ============================================================
CREATE TABLE patrocinador (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE,
    categoria VARCHAR(50),
    contato_email VARCHAR(100)
);
