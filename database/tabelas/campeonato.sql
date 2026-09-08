DROP TABLE IF EXISTS campeonato;

CREATE TABLE campeonato (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    local VARCHAR(150),
    premiacao NUMERIC(12,2),
    status VARCHAR(30) NOT NULL,
    modalidade_id INT NOT NULL,
    organizacao_id INT NOT NULL,
    CONSTRAINT fk_campeonato_modalidade
        FOREIGN KEY (modalidade_id)
        REFERENCES modalidade(id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_campeonato_organizacao
        FOREIGN KEY (organizacao_id)
        REFERENCES organizacao(id)
        ON DELETE RESTRICT
);
