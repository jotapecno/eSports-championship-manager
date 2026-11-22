-- ============================================================
-- PROCEDURE: sp_atualizar_estatisticas_jogador_partida
-- Descrição: Valida se o atleta pertence a uma das equipes da partida e insere ou sobrescreve suas métricas de abates, mortes, assistências e dano total.
-- Dependências de dados: Tabelas partida, jogador_equipe e estatistica.
-- ============================================================

CREATE OR REPLACE PROCEDURE sp_atualizar_estatisticas_jogador_partida(
    p_jogador_id   INT,
    p_partida_id   INT,
    p_eliminacoes  INT,
    p_mortes       INT,
    p_assistencias INT,
    p_dano         NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_equipe_id INT;
BEGIN
    -- equipe do jogador que de fato disputa esta partida
    SELECT je.equipe_id INTO v_equipe_id
      FROM partida p
      JOIN jogador_equipe je ON je.equipe_id IN (p.equipe1_id, p.equipe2_id)
     WHERE p.id = p_partida_id
       AND je.jogador_id = p_jogador_id
       AND je.data_saida IS NULL;

    IF v_equipe_id IS NULL THEN
        RAISE EXCEPTION 'Jogador % nao pertence a nenhuma das equipes da partida %.',
            p_jogador_id, p_partida_id;
    END IF;

    -- "upsert": apaga as metricas antigas deste jogador nesta partida e regrava
    DELETE FROM estatistica
     WHERE partida_id = p_partida_id AND jogador_id = p_jogador_id
       AND nome_metrica IN ('Kills', 'Mortes', 'Assistencias', 'Dano Total');

    INSERT INTO estatistica (partida_id, equipe_id, jogador_id, nome_metrica, valor) VALUES
        (p_partida_id, v_equipe_id, p_jogador_id, 'Kills',        p_eliminacoes),
        (p_partida_id, v_equipe_id, p_jogador_id, 'Mortes',       p_mortes),
        (p_partida_id, v_equipe_id, p_jogador_id, 'Assistencias', p_assistencias),
        (p_partida_id, v_equipe_id, p_jogador_id, 'Dano Total',   p_dano);
END;
$$;
