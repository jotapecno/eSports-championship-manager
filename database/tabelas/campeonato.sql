CREATE TABLE campeonato (
    id_campeonato SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    local VARCHAR(150),
    premiacao NUMERIC(12,2),
    status VARCHAR(30) NOT NULL
);
