-- ============================================================
-- TRIGGER: tg_bloquear_transferencia_jogador_em_campeonato
-- Descrição: Bloqueia o encerramento do vínculo de um jogador caso sua equipe esteja ativa disputando uma fase de um campeonato em andamento.
-- Dependências de dados: Tabelas jogador_equipe, equipe_campeonato, campeonato e fase (executa fn_bloquear_transferencia_jogador_em_campeonato).
-- ============================================================

CREATE OR REPLACE FUNCTION fn_bloquear_transferencia_jogador_em_campeonato()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_campeonato VARCHAR(100);
    v_fase       VARCHAR(50);
BEGIN
    -- so interessa quando o jogador esta SAINDO da equipe agora
    IF OLD.data_saida IS NULL AND NEW.data_saida IS NOT NULL THEN

        SELECT c.nome, f.nome_fase
          INTO v_campeonato, v_fase
          FROM equipe_campeonato ec
          JOIN campeonato c ON c.id = ec.campeonato_id
          JOIN fase f       ON f.campeonato_id = c.id
         WHERE ec.equipe_id = OLD.equipe_id
           AND ec.status_participacao NOT IN ('Eliminada', 'Desistente')
           AND c.status = 'Em andamento'
           AND NEW.data_saida BETWEEN f.data_inicio AND COALESCE(f.data_fim, NEW.data_saida)
         LIMIT 1;

        IF FOUND THEN
            RAISE EXCEPTION
              'Transferencia bloqueada: a equipe % esta disputando a fase "%" do campeonato "%".',
              OLD.equipe_id, v_fase, v_campeonato;
        END IF;
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS tg_bloquear_transferencia_jogador_em_campeonato ON jogador_equipe;

CREATE TRIGGER tg_bloquear_transferencia_jogador_em_campeonato
BEFORE UPDATE OF data_saida ON jogador_equipe
FOR EACH ROW
EXECUTE FUNCTION fn_bloquear_transferencia_jogador_em_campeonato();
