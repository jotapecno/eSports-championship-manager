CREATE OR REPLACE FUNCTION fn_validar_elenco_minimo_partida()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_qtd_equipe1 INT;
    v_qtd_equipe2 INT;
    v_minimo_jogadores INT;
BEGIN
    -- Obtém o número mínimo de jogadores da modalidade do campeonato (padrão 5 se nulo)
    SELECT COALESCE(m.numero_jogadores, 5)
    INTO v_minimo_jogadores
    FROM campeonato c
    INNER JOIN modalidade m ON c.modalidade_id = m.id
    WHERE c.id = NEW.campeonato_id;

    v_minimo_jogadores := COALESCE(v_minimo_jogadores, 5);

    -- Conta jogadores ativos e não suspensos da Equipe 1
    SELECT COUNT(*)
    INTO v_qtd_equipe1
    FROM jogador_equipe je
    INNER JOIN jogador j ON je.jogador_id = j.id
    WHERE je.equipe_id = NEW.equipe1_id
      AND je.data_saida IS NULL
      AND COALESCE(j.suspenso, FALSE) = FALSE;

    -- Conta jogadores ativos e não suspensos da Equipe 2
    SELECT COUNT(*)
    INTO v_qtd_equipe2
    FROM jogador_equipe je
    INNER JOIN jogador j ON je.jogador_id = j.id
    WHERE je.equipe_id = NEW.equipe2_id
      AND je.data_saida IS NULL
      AND COALESCE(j.suspenso, FALSE) = FALSE;

    IF v_qtd_equipe1 < v_minimo_jogadores THEN
        RAISE EXCEPTION 'A equipe 1 (ID %) não possui o mínimo legal de % jogadores ativos.', NEW.equipe1_id, v_minimo_jogadores;
    END IF;

    IF v_qtd_equipe2 < v_minimo_jogadores THEN
        RAISE EXCEPTION 'A equipe 2 (ID %) não possui o mínimo legal de % jogadores ativos.', NEW.equipe2_id, v_minimo_jogadores;
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS tg_validar_elenco_minimo_partida ON partida;

CREATE TRIGGER tg_validar_elenco_minimo_partida
BEFORE INSERT OR UPDATE ON partida
FOR EACH ROW
EXECUTE FUNCTION fn_validar_elenco_minimo_partida();
