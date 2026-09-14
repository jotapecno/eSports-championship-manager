DROP TABLE IF EXISTS arbitro;
-- ============================================================
-- 5ª TABELA: arbitro
-- Descrição: Profissionais responsáveis pela mediação das partidas.
-- Dependências: Nenhuma (tabela base).
-- ============================================================
CREATE TABLE arbitro (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE,
    nivel_experiencia VARCHAR(30),
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);
