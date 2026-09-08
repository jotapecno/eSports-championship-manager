DROP TABLE IF EXISTS estatistica;
 
CREATE TABLE estatistica (
    id SERIAL PRIMARY KEY,
    partida_id INT NOT NULL,
    equipe_id INT NOT NULL,
    jogador_id INT,
    nome_metrica VARCHAR(100) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_estatistica_partida
        FOREIGN KEY (partida_id)
        REFERENCES partida(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_estatistica_equipe
        FOREIGN KEY (equipe_id)
        REFERENCES equipe(id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_estatistica_jogador
        FOREIGN KEY (jogador_id)
        REFERENCES jogador(id)
        ON DELETE RESTRICT
);
