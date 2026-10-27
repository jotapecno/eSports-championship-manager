--retorna a porcentagem de vitorias da equipe. 
--parametros fc_taxa_vitoria_equipe(equipe, campeonato);
--Use: select fc_taxa_vitoria_equipe(4,3);

CREATE OR REPLACE FUNCTION public.fc_taxa_vitoria_equipe(p_equipe_id integer, p_campeonato_id integer)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
declare 
	v_vitorias int;
	v_derrotas int;
	v_total_partidas int;
	v_taxa_vitoria numeric;
	BEGIN
		select vitorias, derrotas
		into v_vitorias, v_derrotas
		from classificacao_campeonato
		where campeonato_id = p_campeonato_id and equipe_id = p_equipe_id;
		
		--calcula o total de partidas
		v_total_partidas := coalesce(v_vitorias, 0) + coalesce(v_derrotas, 0);
		
		--evita dividir por 0 e da erro 
		if v_total_partidas = 0 then
			return 0.00;
		end if;
		--calcula a taxa de vitoria
		v_taxa_vitoria := (v_vitorias::numeric / v_total_partidas::numeric) * 100.0;
		
		--retorna o valor arredondado  em duas casas decimais 
		return round(v_taxa_vitoria, 2);
		
	END;
$function$
;
