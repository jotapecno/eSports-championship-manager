DROP FUNCTION public.fc_ranking_atual_equipe(int4, int4);

CREATE OR REPLACE FUNCTION public.fc_ranking_atual_equipe(
p_id_equipe integer,
p_id_campeonato integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
	BEGIN
	RETURN(
	-- Retorna a posição no ranking da equipe em determinado campeonato
		SELECT posicao_ranking
		FROM equipe_campeonato ec
		WHERE ec.equipe_id = p_id_equipe AND ec.campeonato_id = p_id_campeonato
	);
	END;
$function$
;
