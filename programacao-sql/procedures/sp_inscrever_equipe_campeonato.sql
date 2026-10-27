-- Procedure: sp_inscrever_equipe_campeonato
-- Inscreve uma equipe em um campeonato, validando o número de jogadores e as vagas.
-- Uso: CALL sp_inscrever_equipe_campeonato(1, 3);

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
    -- FOR UPDATE evita que inscrições simultâneas estourem o limite de vagas
    SELECT c.max_equipes, c.status, m.numero_jogadores
      INTO v_max_equipes, v_status, v_min_jogadores
      FROM campeonato c
      JOIN modalidade m ON m.id = c.modalidade_id
     WHERE c.id = p_campeonato_id
       FOR UPDATE OF c;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Campeonato % não encontrado.', p_campeonato_id;
    END IF;

    IF LOWER(v_status) IN ('encerrado', 'cancelado') THEN
        RAISE EXCEPTION 'Campeonato % não aceita inscrições (status: %).',
            p_campeonato_id, v_status;
    END IF;

    IF v_min_jogadores IS NULL THEN
        RAISE EXCEPTION 'A modalidade do campeonato % não define numero_jogadores.',
            p_campeonato_id;
    END IF;

    SELECT ativo INTO v_equipe_ativa FROM equipe WHERE id = p_equipe_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Equipe % não encontrada.', p_equipe_id;
    END IF;

    IF NOT v_equipe_ativa THEN
        RAISE EXCEPTION 'Equipe % está inativa.', p_equipe_id;
    END IF;

    IF EXISTS (SELECT 1 FROM equipe_campeonato
                WHERE campeonato_id = p_campeonato_id
                  AND equipe_id = p_equipe_id) THEN
        RAISE EXCEPTION 'Equipe % já está inscrita no campeonato %.',
            p_equipe_id, p_campeonato_id;
    END IF;

    -- Jogadores com vínculo ativo (sem data de saída)
    v_max_jogadores := v_min_jogadores + v_reservas;

    SELECT COUNT(*) INTO v_qtd_jogadores
      FROM jogador_equipe
     WHERE equipe_id = p_equipe_id
       AND data_saida IS NULL;

    IF v_qtd_jogadores < v_min_jogadores THEN
        RAISE EXCEPTION 'Equipe % tem % jogador(es); mínimo exigido: %.',
            p_equipe_id, v_qtd_jogadores, v_min_jogadores;
    END IF;

    IF v_qtd_jogadores > v_max_jogadores THEN
        RAISE EXCEPTION 'Equipe % tem % jogadores; máximo permitido: %.',
            p_equipe_id, v_qtd_jogadores, v_max_jogadores;
    END IF;

    -- Equipes desistentes não ocupam vaga
    SELECT COUNT(*) INTO v_qtd_inscritas
      FROM equipe_campeonato
     WHERE campeonato_id = p_campeonato_id
       AND status_participacao <> 'Desistente';

    IF v_qtd_inscritas >= v_max_equipes THEN
        RAISE EXCEPTION 'Campeonato % sem vagas (% de % ocupadas).',
            p_campeonato_id, v_qtd_inscritas, v_max_equipes;
    END IF;

    INSERT INTO equipe_campeonato (campeonato_id, equipe_id)
    VALUES (p_campeonato_id, p_equipe_id);

    RAISE NOTICE 'Equipe % inscrita no campeonato %.', p_equipe_id, p_campeonato_id;
END;
$$;
