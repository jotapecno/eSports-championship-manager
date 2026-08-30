CREATE TABLE equipe(
  id SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  quantidade_membros INT NOT NULL,
  ativo BOOLEAN NOT NULL,
  vitorias INT NOT NULL,
  derrotas INT NOT NULL
);
