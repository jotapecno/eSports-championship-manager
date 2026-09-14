DROP TABLE IF EXISTS equipe;
-- ============================================================
-- 4ª TABELA: equipe
-- Descrição: Times, clubes ou agremiações esportivas.
-- Dependências: Nenhuma (tabela base).
-- ============================================================
CREATE TABLE equipe(
  id SERIAL PRIMARY KEY,
  nome VARCHAR(50) UNIQUE NOT NULL,
  quantidade_membros INT NOT NULL CHECK (quantidade_membros BETWEEN 5 AND 7),
  ativo BOOLEAN NOT NULL,
  vitorias INT NOT NULL,
  derrotas INT NOT NULL
);
