DROP TABLE IF EXISTS modalidade;
-- ============================================================
-- 1ª TABELA: modalidade
-- Descrição: Registra os tipos de esportes ou jogos disputados.
-- Dependências: Nenhuma (tabela base).
-- ============================================================
CREATE TABLE modalidade (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    genero VARCHAR(50),
    numero_jogadores INT,
    descricao TEXT,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);
