CREATE TABLE jogador(
  id_jogador SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  data_nascimento DATE NOT NULL,
  endereco VARCHAR(100) NOT NULL,
  numero_mpvs INTEGER,
  posicao_ranking INTEGER
);
