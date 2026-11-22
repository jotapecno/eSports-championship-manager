-- ============================================================
-- PROCEDURE: sp_inscrever_equipe_campeonato
-- Descrição: Inscreve uma equipe em um campeonato após validar vagas disponíveis, status do torneio, atividade da equipe e limites mínimo/máximo de jogadores no elenco.
-- Dependências de dados: Tabelas campeonato, modalidade, equipe, jogador_equipe, equipe_campeonato e classificacao_campeonato.
-- ============================================================

CREATE OR REPLACE PROCEDURE sp_inscrever_equipe_campeonato(
    p_campeonato_id INT,
    p_equipe_id     INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_max_equipes    INT;
    v_status         VARCHAR(30);
    v_min_jogadores  INT;
    v_max_jogadores  INT;
    v_equipe_ativa   BOOLEAN;
    v_qtd_jogadores  INT;
    v_qtd_inscritas  INT;
    v_reservas       CONSTANT INT := 2;
BEGIN
    SELECT c.max_equipes, c.status, m.numero_jogadores
      INTO v_max_equipes, v_status, v_min_jogadores
      FROM campeonato c
      JOIN modalidade m ON m.id = c.modalidade_id
     WHERE c.id = p_campeonato_id
       FOR UPDATE OF c;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Campeonato % nao encontrado.', p_campeonato_id;
    END IF;

    IF LOWER(v_status) IN ('finalizado', 'cancelado') THEN
        RAISE EXCEPTION 'Campeonato % nao aceita inscricoes (status: %).',
            p_campeonato_id, v_status;
    END IF;

    IF v_min_jogadores IS NULL THEN
        RAISE EXCEPTION 'A modalidade do campeonato % nao define numero_jogadores.',
            p_campeonato_id;
    END IF;

    SELECT ativo INTO v_equipe_ativa FROM equipe WHERE id = p_equipe_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Equipe % nao encontrada.', p_equipe_id;
    END IF;
    IF NOT v_equipe_ativa THEN
        RAISE EXCEPTION 'Equipe % esta inativa.', p_equipe_id;
    END IF;

    IF EXISTS (SELECT 1 FROM equipe_campeonato
                WHERE campeonato_id = p_campeonato_id AND equipe_id = p_equipe_id) THEN
        RAISE EXCEPTION 'Equipe % ja esta inscrita no campeonato %.',
            p_equipe_id, p_campeonato_id;
    END IF;

    v_max_jogadores := v_min_jogadores + v_reservas;

    SELECT COUNT(*) INTO v_qtd_jogadores
      FROM jogador_equipe
     WHERE equipe_id = p_equipe_id AND data_saida IS NULL;

    IF v_qtd_jogadores < v_min_jogadores THEN
        RAISE EXCEPTION 'Equipe % tem % jogador(es); minimo exigido: %.',
            p_equipe_id, v_qtd_jogadores, v_min_jogadores;
    END IF;
    IF v_qtd_jogadores > v_max_jogadores THEN
        RAISE EXCEPTION 'Equipe % tem % jogadores; maximo permitido: %.',
            p_equipe_id, v_qtd_jogadores, v_max_jogadores;
    END IF;

    SELECT COUNT(*) INTO v_qtd_inscritas
      FROM equipe_campeonato
     WHERE campeonato_id = p_campeonato_id AND status_participacao <> 'Desistente';

    IF v_qtd_inscritas >= v_max_equipes THEN
        RAISE EXCEPTION 'Campeonato % sem vagas (% de % ocupadas).',
            p_campeonato_id, v_qtd_inscritas, v_max_equipes;
    END IF;

    INSERT INTO equipe_campeonato (campeonato_id, equipe_id)
    VALUES (p_campeonato_id, p_equipe_id);

    INSERT INTO classificacao_campeonato (campeonato_id, equipe_id)
    VALUES (p_campeonato_id, p_equipe_id);

    RAISE NOTICE 'Equipe % inscrita no campeonato %.', p_equipe_id, p_campeonato_id;
END;
$$;
