DROP PROCEDURE public.sp_transferir_jogador_equipe(int4, int4, int4, date, date);

CREATE OR REPLACE PROCEDURE public.sp_transferir_jogador_equipe(
IN p_id_jogador integer,
IN p_id_equipe_atual integer,
IN p_id_equipe_nova integer,
IN p_data_saida date,
IN p_data_entrada date)
 LANGUAGE plpgsql
AS $procedure$
	BEGIN
	-- Coloca a data de saída do jogador na atual equipe
		UPDATE jogador_equipe SET data_saida = p_data_saida
		WHERE jogador_id = p_id_jogador AND equipe_id = p_id_equipe_atual;
	-- Insere na tabela o novo registro do jogador com a nova equipe e a data de entrada
		INSERT INTO jogador_equipe (jogador_id, equipe_id, data_entrada)
		VALUES (p_id_jogador, p_id_equipe_nova, p_data_entrada);
	END;
$procedure$
;
