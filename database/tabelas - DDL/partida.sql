DROP TABLE IF EXISTS partida;

CREATE TABLE partida (
    id SERIAL PRIMARY KEY,
    campeonato_id INT NOT NULL,
    fase_id INT NOT NULL,
    equipe1_id INT NOT NULL,
    equipe2_id INT NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    local_partida VARCHAR(255) DEFAULT 'Online',

FOREIGN KEY (campeonato_id) REFERENCES campeonato(id),
    FOREIGN KEY (fase_id) REFERENCES fase(id),
    FOREIGN KEY (equipe1_id) REFERENCES equipe(id),
    FOREIGN KEY (equipe2_id) REFERENCES equipe(id)
);
