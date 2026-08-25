CREATE TABLE modalidade (
    id_modalidade SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    genero VARCHAR(50),
    numero_jogadores INT,
    descricao TEXT,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);
