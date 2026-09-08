DROP TABLE IF EXISTS resultado;
 
CREATE TABLE resultado (
    id SERIAL PRIMARY KEY,
    partida_id INT NOT NULL UNIQUE,
    equipe_vencedora_id INT,
    pontuacao_equipe_a INT DEFAULT 0,
    pontuacao_equipe_b INT DEFAULT 0,
    duracao_segundos INT,
    observacoes TEXT,
    CONSTRAINT fk_resultado_partida
        FOREIGN KEY (partida_id)
        REFERENCES partida(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_resultado_equipe_vencedora
        FOREIGN KEY (equipe_vencedora_id)
        REFERENCES equipe(id)
        ON DELETE RESTRICT
);
