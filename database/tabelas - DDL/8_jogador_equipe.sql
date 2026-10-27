DROP TABLE IF EXISTS jogador_equipe;

CREATE TABLE jogador_equipe(
jogador_id INT not null,
equipe_id INT not null,
data_entrada DATE not null,
data_saida DATE,
PRIMARY KEY(jogador_id, equipe_id),
CONSTRAINT fk_ej_jogador
FOREIGN KEY(jogador_id) references jogador(id)
ON DELETE CASCADE,
CONSTRAINT fk_ej_equipe
FOREIGN KEY(equipe_id) references equipe(id)
ON DELETE RESTRICT

);
