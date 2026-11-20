DROP TABLE IF EXISTS auditoria_campeoes;
-- ============================================================
-- 16ª TABELA: auditoria_campeoes
-- Descrição: Histórico automático de auditoria da liberação de premiação dos campeões (preenchida via trigger).
-- Dependências: equipe, campeonato.
-- ============================================================

CREATE TABLE auditoria_campeoes (
    id SERIAL PRIMARY KEY,
    equipe_id INT NOT NULL,
    data_liberacao_premiacao DATE NOT NULL,
    status_liberacao VARCHAR(30) NOT NULL,
    valor_transferencia NUMERIC(12,2) NOT NULL,
    campeonato_id INT NOT NULL,
    colocacao INT NOT NULL CHECK (colocacao BETWEEN 1 AND 3),

    CONSTRAINT fk_equipe_id
        FOREIGN KEY (equipe_id) 
        REFERENCES equipe(id),

    CONSTRAINT fk_auditoria_campeonato
        FOREIGN KEY (campeonato_id) 
        REFERENCES campeonato(id)
);
