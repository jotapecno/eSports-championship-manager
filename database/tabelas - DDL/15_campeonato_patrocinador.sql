DROP TABLE IF EXISTS campeonato_patrocinador;
-- ============================================================
-- 15ª TABELA: campeonato_patrocinador
-- Descrição: Associação entre campeonatos e seus patrocinadores, cotas e valores.
-- Dependências: campeonato, patrocinador.
-- ============================================================

CREATE TABLE campeonato_patrocinador (
    id SERIAL PRIMARY KEY,
    campeonato_id INT NOT NULL,
    patrocinador_id INT NOT NULL,
    valor NUMERIC(12,2) NOT NULL CHECK (valor >= 0),
    CONSTRAINT uk_campeonato_patrocinador UNIQUE (campeonato_id, patrocinador_id),
    CONSTRAINT fk_cp_campeonato
        FOREIGN KEY (campeonato_id) REFERENCES campeonato(id) ON DELETE CASCADE,
    CONSTRAINT fk_cp_patrocinador
        FOREIGN KEY (patrocinador_id) REFERENCES patrocinador(id) ON DELETE RESTRICT
);
