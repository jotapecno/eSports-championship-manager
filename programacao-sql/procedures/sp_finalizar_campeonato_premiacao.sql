CREATE OR REPLACE PROCEDURE sp_finalizar_campeonato_premiacao(p_campeonato_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_premiacao NUMERIC(12,2);
BEGIN
    UPDATE campeonato 
    SET status = 'Encerrado' 
    WHERE id = p_campeonato_id;
    
    SELECT premiacao INTO v_premiacao 
    FROM campeonato 
    WHERE id = p_campeonato_id;

    WITH ranking AS (
        SELECT 
            equipe_id,
            ROW_NUMBER() OVER(ORDER BY pontos DESC, vitorias DESC, derrotas ASC) as pos
        FROM classificacao_campeonato
        WHERE campeonato_id = p_campeonato_id
    )
    UPDATE equipe_campeonato ec
    SET posicao_ranking = r.pos
    FROM ranking r
    WHERE ec.equipe_id = r.equipe_id 
      AND ec.campeonato_id = p_campeonato_id;
    /*
    SELECT 
        ec.equipe_id, 
        ec.posicao_ranking,
        CASE 
            WHEN ec.posicao_ranking = 1 THEN v_premiacao * 0.50
            WHEN ec.posicao_ranking = 2 THEN v_premiacao * 0.30
            WHEN ec.posicao_ranking = 3 THEN v_premiacao * 0.20
            ELSE 0 
        END as valor_premiacao
    FROM equipe_campeonato ec
    WHERE ec.campeonato_id = p_campeonato_id;
    */
END;
$$;
