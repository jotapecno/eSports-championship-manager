CREATE TABLE partida (
    id SERIAL PRIMARY KEY,
    campeonato_id INT NOT NULL,
    fase_id INT NOT NULL,
    equipe1_id INT NOT NULL,
    equipe2_id INT NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    local_partida VARCHAR(255) DEFAULT 'Online',
);
