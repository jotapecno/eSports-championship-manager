DROP TABLE IF EXISTS equipe_campeonato;
DROP TYPE IF EXISTS status_participacao_enum;
 
-- ENUM para o status de participação, evitando erros de digitação
CREATE TYPE status_participacao_enum AS ENUM ('Inscrita', 'Ativa', 'Eliminada', 'Desistente');
 
CREATE TABLE equipe_campeonato (
    id SERIAL PRIMARY KEY,
    campeonato_id INT NOT NULL,
    equipe_id INT NOT NULL,
    data_inscricao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_participacao status_participacao_enum DEFAULT 'Inscrita',
 
    -- Restrição para evitar que a mesma equipe seja cadastrada duas vezes no mesmo campeonato
    CONSTRAINT uk_equipe_campeonato UNIQUE (campeonato_id, equipe_id),
 
    CONSTRAINT fk_equipe_campeonato_campeonato
        FOREIGN KEY (campeonato_id)
        REFERENCES campeonato(id)
        ON DELETE CASCADE,
 
    CONSTRAINT fk_equipe_campeonato_equipe
        FOREIGN KEY (equipe_id)
        REFERENCES equipe(id)
        ON DELETE RESTRICT
);
