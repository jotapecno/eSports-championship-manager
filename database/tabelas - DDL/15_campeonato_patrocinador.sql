DROP TABLE IF EXISTS campeonato_patrocinador;
-- ============================================================
-- 12ª TABELA: campeonato_patrocinador
-- Descrição: Associação entre campeonatos e seus patrocinadores, cotas e valores.
-- Dependências: campeonato, patrocinador.
-- ============================================================

CREATE TABLE campeonato_patrocinador (
    campeonato_id INT NOT NULL,
    patrocinador_id INT NOT NULL,
    cota VARCHAR(100),
    valor_investido DECIMAL(12, 2),

    PRIMARY KEY (campeonato_id, patrocinador_id),

    CONSTRAINT fk_camp_patroc_campeonato
        FOREIGN KEY (campeonato_id)
        REFERENCES campeonato(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_camp_patroc_patrocinador
        FOREIGN KEY (patrocinador_id)
        REFERENCES patrocinador(id)
        ON DELETE CASCADE
);
