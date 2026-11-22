-- ============================================================
-- TRIGGER: tg_atualizar_classificacao_pos_partida
-- Descrição: Acionado após a inserção de um resultado, atualiza automaticamente os pontos (+3 vitória, +1 empate), vitórias e derrotas das equipes na tabela de classificação.
-- Dependências de dados: Tabelas resultado, partida e classificacao_campeonato (executa fn_atualizar_classificacao_pos_partida).
-- ============================================================

CREATE OR REPLACE FUNCTION public.fn_atualizar_classificacao_pos_partida()
	RETURNS trigger
	LANGUAGE plpgsql
AS $function$
DECLARE
	v_campeonato_id         INT;
    v_equipe1_id            INT;
    v_equipe2_id            INT;
    v_vencedor_id           INT;
    v_equipe_perdedora_id  INT;
    
	BEGIN
	-- equipe vencedora, new pega a equipe atual
    v_vencedor_id := NEW.equipe_vencedora_id;

    -- Busca o campeonato e as duas equipes envolvidas na partida
    SELECT campeonato_id, equipe1_id, equipe2_id
      INTO v_campeonato_id, v_equipe1_id, v_equipe2_id
      FROM partida
     WHERE id = NEW.partida_id;

    -- caso haja um vencedor definido, sem empate
    IF v_vencedor_id IS NOT NULL THEN
        -- Identifica qual das duas equipes perdeu usando a nova variável
        IF v_vencedor_id = v_equipe1_id THEN
            v_equipe_perdedora_id := v_equipe2_id;
        ELSIF v_vencedor_id = v_equipe2_id THEN
            v_equipe_perdedora_id := v_equipe1_id;
        ELSE
            RAISE EXCEPTION 'A equipe vencedora (%) não pertence à partida (%).', 
                v_vencedor_id, NEW.partida_id;
        END IF;

        -- Atualiza ou insere a classificação do VENCEDOR, +3 pontos, +1 vitória
        INSERT INTO classificacao_campeonato (campeonato_id, equipe_id, pontos, vitorias, derrotas)
        VALUES (v_campeonato_id, v_vencedor_id, 3, 1, 0)
        ON CONFLICT (campeonato_id, equipe_id)
        DO UPDATE SET
            pontos   = classificacao_campeonato.pontos + 3,
            vitorias = classificacao_campeonato.vitorias + 1;

        -- atualiza ou insere a classificação do PERDEDOR, +0 pontos, +1 derrota
        INSERT INTO classificacao_campeonato (campeonato_id, equipe_id, pontos, vitorias, derrotas)
        VALUES (v_campeonato_id, v_equipe_perdedora_id, 0, 0, 1)
        ON CONFLICT (campeonato_id, equipe_id)
        DO UPDATE SET
            derrotas = classificacao_campeonato.derrotas + 1;

    -- Caso de empate (v_vencedor_id IS NULL): +1 ponto para cada equipe
    ELSE
        INSERT INTO classificacao_campeonato (campeonato_id, equipe_id, pontos, vitorias, derrotas)
        VALUES 
            (v_campeonato_id, v_equipe1_id, 1, 0, 0),
            (v_campeonato_id, v_equipe2_id, 1, 0, 0)
        ON CONFLICT (campeonato_id, equipe_id)
        DO UPDATE SET
            pontos = classificacao_campeonato.pontos + 1;
    END IF;

    RETURN NEW;
    
	END;
$function$
;

DROP TRIGGER IF EXISTS tg_atualizar_classificacao_pos_partida ON resultado;

CREATE TRIGGER tg_atualizar_classificacao_pos_partida
AFTER INSERT ON resultado
FOR EACH ROW
EXECUTE FUNCTION fn_atualizar_classificacao_pos_partida();
