DROP TABLE IF EXISTS classificacao_campeonato;
-- ============================================================
-- 14ª TABELA: classificacao_campeonato
-- Descrição: Tabela de classificação geral das equipes por campeonato (pontos, vitórias e derrotas).
-- Dependências: campeonato, equipe.
-- ============================================================

CREATE TABLE classificacao_campeonato (
    campeonato_id INT NOT NULL,
    equipe_id INT NOT NULL,
    pontos INT NOT NULL DEFAULT 0,
    vitorias INT NOT NULL DEFAULT 0,
    derrotas INT NOT NULL DEFAULT 0,

    PRIMARY KEY (campeonato_id, equipe_id),

    CONSTRAINT fk_classificacao_campeonato 
        FOREIGN KEY (campeonato_id) 
        REFERENCES campeonato(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_classificacao_equipe
        FOREIGN KEY (equipe_id) 
        REFERENCES equipe(id)
        ON DELETE RESTRICT 
);
