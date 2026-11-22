-- ============================================================
-- TRIGGER: tg_impedir_inscricao_equipe_limite_excedido
-- Descrição: Impede a inscrição de novas equipes quando o campeonato já atingiu o limite máximo de vagas definido em max_equipes.
-- Dependências de dados: Tabelas equipe_campeonato e campeonato (executa fn_impedir_inscricao_equipe_limite_excedido).
-- ============================================================

CREATE OR REPLACE FUNCTION fn_impedir_inscricao_equipe_limite_excedido()
RETURNS TRIGGER AS $$
DECLARE
    v_limite     INT;
    v_inscritas  INT;
BEGIN
    SELECT max_equipes
      INTO v_limite
      FROM campeonato
     WHERE id = NEW.campeonato_id;

    IF v_limite IS NULL THEN
        RETURN NEW;
    END IF;

    SELECT COUNT(*)
      INTO v_inscritas
      FROM equipe_campeonato
     WHERE campeonato_id = NEW.campeonato_id
       AND status_participacao <> 'Desistente';

    IF v_inscritas >= v_limite THEN
        RAISE EXCEPTION
          'Inscricao negada: o campeonato % ja atingiu o limite de % equipes.',
          NEW.campeonato_id, v_limite;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tg_impedir_inscricao_equipe_limite_excedido ON equipe_campeonato;

CREATE TRIGGER tg_impedir_inscricao_equipe_limite_excedido
BEFORE INSERT ON equipe_campeonato
FOR EACH ROW
EXECUTE FUNCTION fn_impedir_inscricao_equipe_limite_excedido();
