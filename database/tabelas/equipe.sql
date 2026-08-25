CREATE TABLE equipe(
  id_equipe SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  quantidade_membros INTEGER,
  ativo BOOLEAN NOT NULL,
  vitorias INTEGER NOT NULL,
  derrotas INTEGER NOT NULL,
  historico_partidas TEXT
);
