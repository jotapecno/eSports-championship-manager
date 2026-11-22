-- ============================================================
-- PROCEDURE: sp_registrar_resultado_partida
-- Descrição: Valida a existência da partida e registra o placar e a equipe vencedora, delegando a atualização da tabela de classificação para a trigger correspondente.
-- Dependências de dados: Tabelas partida e resultado.
-- ============================================================

CREATE OR REPLACE PROCEDURE public.sp_registrar_resultado_partida(
    p_partida_id int,
    p_equipe_vencedora_id int,
    p_pontuacao_equipe_a int,
    p_pontuacao_equipe_b int,
    p_duracao_segundos int DEFAULT NULL,
    p_observacoes text DEFAULT NULL)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM partida WHERE id = p_partida_id) THEN
        RAISE EXCEPTION 'Partida com ID % nao foi encontrada.', p_partida_id;
    END IF;

    -- A classificacao e atualizada pelo trigger (AFTER INSERT em resultado)
    INSERT INTO resultado (partida_id, equipe_vencedora_id, pontuacao_equipe_a,
                           pontuacao_equipe_b, duracao_segundos, observacoes)
    VALUES (p_partida_id, p_equipe_vencedora_id, p_pontuacao_equipe_a,
            p_pontuacao_equipe_b, p_duracao_segundos, p_observacoes);
END;
$procedure$;
