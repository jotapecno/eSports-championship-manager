-- ============================================================
-- PROCEDURE: sp_transferir_jogador_equipe
-- Descrição: Encerra o vínculo ativo de um atleta com sua equipe atual e registra a entrada na nova equipe, respeitando bloqueios de janela de transferência.
-- Dependências de dados: Tabela jogador_equipe.
-- ============================================================

CREATE OR REPLACE PROCEDURE public.sp_transferir_jogador_equipe(
    IN p_id_jogador integer,
    IN p_id_equipe_atual integer,
    IN p_id_equipe_nova integer,
    IN p_data_saida date,
    IN p_data_entrada date)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    UPDATE jogador_equipe SET data_saida = p_data_saida
     WHERE jogador_id = p_id_jogador AND equipe_id = p_id_equipe_atual
       AND data_saida IS NULL;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Jogador % nao tem vinculo ativo com a equipe %.',
            p_id_jogador, p_id_equipe_atual;
    END IF;

    INSERT INTO jogador_equipe (jogador_id, equipe_id, data_entrada)
    VALUES (p_id_jogador, p_id_equipe_nova, p_data_entrada);
END;
$procedure$;
