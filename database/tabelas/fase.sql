CREATE TABLE fase (
    id_fase SERIAL PRIMARY KEY,
    id_campeonato INT NOT NULL,
    nome_fase VARCHAR(50) NOT NULL,
    formato_disputa VARCHAR(50),
    data_inicio DATE,
    data_fim DATE,
);
