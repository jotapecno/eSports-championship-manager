CREATE OR REPLACE FUNCTION fc_verificar_elegibilidade_jogador(p_jogador_id INT)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_idade INT;
    v_vinculo_ativo BOOLEAN;
    v_suspenso BOOLEAN;
BEGIN
    -- 1. Obtém a idade atual e o estado de suspensão do jogador
    SELECT 
        EXTRACT(YEAR FROM age(CURRENT_DATE, data_nascimento)), 
        suspenso
    INTO v_idade, v_suspenso
    FROM jogador 
    WHERE id = p_jogador_id;

    -- Se o jogador não existir na base de dados
    IF v_idade IS NULL THEN
        RETURN FALSE;
    END IF;

    -- 2. Verifica se possui vínculo ativo com alguma equipa (data_saida é NULA)
    SELECT EXISTS (
        SELECT 1 
        FROM jogador_equipe 
        WHERE jogador_id = p_jogador_id 
          AND data_saida IS NULL
    ) INTO v_vinculo_ativo;

    -- 3. Validação final: Idade mínima (18), vínculo ativo e ausência de suspensão
    IF v_idade >= 18 AND v_vinculo_ativo = TRUE AND v_suspenso = FALSE THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$;
