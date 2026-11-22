-- ============================================================
-- PROCEDURE: sp_finalizar_campeonato_premiacao
-- Descrição: Calcula e grava a classificação final das equipes participantes e altera o status do campeonato para 'Finalizado', acionando a auditoria de premiação.
-- Dependências de dados: Tabelas campeonato, classificacao_campeonato e equipe_campeonato.
-- ============================================================

CREATE OR REPLACE PROCEDURE sp_finalizar_campeonato_premiacao(p_campeonato_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM campeonato WHERE id = p_campeonato_id) THEN
        RAISE EXCEPTION 'Campeonato % nao encontrado.', p_campeonato_id;
    END IF;

    WITH ranking AS (
        SELECT cc.equipe_id,
               ROW_NUMBER() OVER (ORDER BY cc.pontos DESC, cc.vitorias DESC, cc.derrotas ASC) AS pos
        FROM classificacao_campeonato cc
        JOIN equipe_campeonato ec
          ON ec.campeonato_id = cc.campeonato_id AND ec.equipe_id = cc.equipe_id
        WHERE cc.campeonato_id = p_campeonato_id
    )
    UPDATE equipe_campeonato ec
       SET posicao_ranking = r.pos
      FROM ranking r
     WHERE ec.equipe_id = r.equipe_id
       AND ec.campeonato_id = p_campeonato_id;

    UPDATE campeonato SET status = 'Finalizado' WHERE id = p_campeonato_id;
END;
$$;
