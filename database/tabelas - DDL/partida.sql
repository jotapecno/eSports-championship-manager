DROP TABLE IF EXISTS partida;

CREATE TABLE partida (
    id SERIAL PRIMARY KEY,
    campeonato_id INT NOT NULL,
    fase_id INT NOT NULL,
    equipe1_id INT NOT NULL,
    equipe2_id INT NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    local_partida VARCHAR(255) DEFAULT 'Online',

    CONSTRAINT fk_partida_campeonato
        FOREIGN KEY (campeonato_id)
        REFERENCES campeonato(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_partida_fase
        FOREIGN KEY (fase_id)
        REFERENCES fase(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_partida_equipe1
        FOREIGN KEY (equipe1_id)
        REFERENCES equipe(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_partida_equipe2
        FOREIGN KEY (equipe2_id)
        REFERENCES equipe(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_partida_equipes_diferentes
        CHECK (equipe1_id <> equipe2_id)
);
