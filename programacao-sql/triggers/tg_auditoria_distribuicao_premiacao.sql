-- ============================================================
-- TRIGGER: tg_auditoria_distribuicao_premiacao
-- Descrição: Registra automaticamente o pagamento da premiação e a data prevista de liberação para a equipe campeã assim que o status do campeonato muda para 'Finalizado'.
-- Dependências de dados: Tabelas campeonato, equipe_campeonato e auditoria_campeoes (executa fn_inserir_auditoria).
-- ============================================================

CREATE OR REPLACE FUNCTION public.fn_inserir_auditoria()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $function$
DECLARE
    v_equipe_id         INT;
    v_data_transferencia DATE;
BEGIN
    -- so age quando o campeonato PASSA a Finalizado
    IF NEW.status = 'Finalizado' AND OLD.status IS DISTINCT FROM 'Finalizado' THEN

        v_data_transferencia := (COALESCE(NEW.data_fim, CURRENT_DATE) + INTERVAL '2 months')::DATE;

        SELECT equipe_id INTO v_equipe_id
          FROM equipe_campeonato
         WHERE campeonato_id = NEW.id AND posicao_ranking = 1;

        IF v_equipe_id IS NULL THEN
            RAISE EXCEPTION 'Nao foi encontrada uma equipe campea para o campeonato %', NEW.id;
        END IF;

        INSERT INTO auditoria_campeoes
            (equipe_id, campeonato_id, colocacao,
             data_liberacao_premiacao, status_liberacao, valor_transferencia)
        VALUES
            (v_equipe_id, NEW.id, 1,
             v_data_transferencia, 'em andamento', COALESCE(NEW.premiacao, 0));
    END IF;

    RETURN NEW;
END;
$function$;

DROP TRIGGER IF EXISTS tg_auditoria_distribuicao_premiacao ON campeonato;

CREATE TRIGGER tg_auditoria_distribuicao_premiacao
AFTER UPDATE ON campeonato
FOR EACH ROW
EXECUTE FUNCTION fn_inserir_auditoria();
