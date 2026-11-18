DROP FUNCTION public.fn_inserir_auditoria()

  --Criação da Trigger Function

CREATE OR REPLACE FUNCTION public.fn_inserir_auditoria()
	RETURNS TRIGGER
	LANGUAGE plpgsql
AS $function$
DECLARE
	vv_equipe_id INT;
	vv_data_transferencia DATE;
BEGIN
	IF NEW.status = 'finalizado' AND OLD.status IS DISTINCT FROM 'finalizado' THEN
		vv_data_transferencia := (NEW.data_fim + INTERVAL '2 months')::DATE;
				
		SELECT equipe_id INTO vv_equipe_id FROM equipe_campeonato
		WHERE campeonato_id = NEW.id AND posicao_ranking = 1;
		
		IF vv_equipe_id IS NULL THEN
			RAISE EXCEPTION 'Não foi encontrada uma equipe vencedora';
		ELSE
			INSERT INTO auditoria_campeoes
				(equipe_id, data_liberacao_premiacao, status_liberacao, valor_transferencia)
			VALUES
				(vv_equipe_id, vv_data_transferencia,'em andamento', NEW.premiacao);
		END IF;
	END IF;
			
	RETURN NEW;
END;
$function$
;

DROP TRIGGER IF EXISTS tg_auditoria_distribuicao_premiacao ON campeonato

  --Criação da Trigger

CREATE TRIGGER tg_auditoria_distribuicao_premiacao
AFTER UPDATE ON campeonato
FOR EACH ROW
EXECUTE FUNCTION fn_inserir_auditoria();
