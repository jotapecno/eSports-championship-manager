-- DROP PROCEDURE public.proc_registrar_resultado_partidas();

--insere na tabela resulta e insere ou atualizar a tabela classificacao_campeonato
--para proc_registrar_resultado_partidas( partida, equipeVencedora, pontuacaoEquipeA, pontuacaoEquipeB, duracaoSegundos, observacoes)
--Use: call proc_registrar_resultado_partidas(32,4,6,0,null,'');

CREATE OR REPLACE PROCEDURE public.proc_registrar_resultado_partidas(
p_partida_id int,
p_equipe_vencedora_id int,
p_pontuacao_equipe_a int,
p_pontuacao_equipe_b int,
p_duracao_segundos int default null,
p_observacoes text default null)
	LANGUAGE plpgsql
AS $procedure$
DECLARE 
	v_equipe1_id int;
	v_equipe2_id int;
	v_equipe_perdedora_id int;
	v_campeonato_id int;
	v_pontos_por_vitoria int := 3;
	BEGIN
	--pegas as equipe da partida e o campeonato
		select 
			equipe1_id, 
			equipe2_id,
			campeonato_id
		into
			v_equipe1_id,
			v_equipe2_id,
			v_campeonato_id
		from partida
		where id = p_partida_id;
		
		if v_campeonato_id is null then
			raise exception 'Partida com ID % não foi encontrada.',p_partida_id;
		end if;
		
		--inserir o resultado da partida na tabela resultado.
		insert into resultado (
		partida_id, equipe_vencedora_id, pontuacao_equipe_a, 
		pontuacao_equipe_b, duracao_segundos, observacoes) values (
		p_partida_id, p_equipe_vencedora_id,p_pontuacao_equipe_a, 
		p_pontuacao_equipe_b, p_duracao_segundos, p_observacoes);
		
		--verifica a equipe que perdeu 
		v_equipe_perdedora_id := case --é um 'Se/senão'.
			when v_equipe1_id = p_equipe_vencedora_id then v_equipe2_id
							else v_equipe1_id end;
		
		if p_equipe_vencedora_id is not null then 
		-- atualiza os dados da equipe vencedora
			insert into classificacao_campeonato (campeonato_id, equipe_id, pontos, vitorias, derrotas)
			values (v_campeonato_id, p_equipe_vencedora_id, v_pontos_por_vitoria, 1, 0)
			on conflict (campeonato_id, equipe_id)
			 do update set 
			 	vitorias = classificacao_campeonato.vitorias + 1,
				pontos = classificacao_campeonato.pontos + v_pontos_por_vitoria;
			
			-- atualiza os dados da equipe derrotada
			insert into classificacao_campeonato (campeonato_id, equipe_id, pontos, vitorias, derrotas)
			values (v_campeonato_id, v_equipe_perdedora_id, 0, 0, 1)
			on conflict (campeonato_id, equipe_id)
			do update set derrotas = classificacao_campeonato.derrotas + 1;
							
		end if;
	END;
$procedure$
;
