DROP TABLE IF EXISTS jogador;

CREATE TABLE jogador(
  id SERIAL PRIMARY KEY,
  equipe_id INT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  cpf VARCHAR(11) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  data_nascimento DATE NOT NULL,
  endereco VARCHAR(255) NOT NULL,
  numero_mpvs INT,
  posicao_ranking INT,

  CONSTRAINT fk_jogador_equipe FOREIGN KEY (equipe_id) REFERENCES equipe(id)
);
