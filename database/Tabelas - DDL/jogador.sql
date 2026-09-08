CREATE TABLE jogador(
  id SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  data_nascimento DATE NOT NULL,
  endereco VARCHAR(100) NOT NULL,
  numero_mpvs INT,
  posicao_ranking INT
);
