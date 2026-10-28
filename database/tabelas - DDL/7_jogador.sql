DROP TABLE IF EXISTS jogador;
 -- ============================================================
-- 7ª TABELA: jogador
-- Descrição: Atletas vinculados a equipes.
-- Dependências: nenhuma.
-- ============================================================
CREATE TABLE jogador (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  cpf VARCHAR(11) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  data_nascimento DATE NOT NULL,
  pais VARCHAR(100) NOT NULL,
  cidade VARCHAR(100) NOT NULL,
  funcao_preferida VARCHAR(100),
  numero_mpvs INT,
  posicao_ranking INT,
  suspenso BOOLEAN DEFAULT FALSE
);
