CREATE TABLE jogador(
  id_jogador SERIAL PRIMARY KEY,
  nome NOT NULL VARCHAR(50),
  data_nascimento NOT NULL DATE,
  endereco NOT NULL VARCHAR(100),
  numero_mpvs INTEGER,
  posicao_ranking INTEGER
);
