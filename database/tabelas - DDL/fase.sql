DROP TABLE IF EXISTS fase;

CREATE TABLE fase (
    id SERIAL PRIMARY KEY,
    campeonato_id INT NOT NULL,
    nome_fase VARCHAR(50) NOT NULL,
    formato_disputa VARCHAR(50),
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT fk_fase_campeonato FOREIGN KEY (campeonato_id) REFERENCES campeonato(id) ON DELETE CASCADE
);
