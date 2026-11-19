
CREATE OR REPLACE FUNCTION fn_impedir_inscricao_equipe_limite_excedido()
RETURNS TRIGGER AS $$
DECLARE
    v_limite     INT;
    v_inscritas  INT;
BEGIN
    SELECT max_equipes                     
      INTO v_limite
      FROM campeonato
     WHERE id_campeonato = NEW.id_campeonato; 

    IF v_limite IS NULL THEN
        RETURN NEW;
    END IF;

    SELECT COUNT(*)
      INTO v_inscritas
      FROM equipe_campeonato
     WHERE id_campeonato = NEW.id_campeonato;
    IF v_inscritas >= v_limite THEN
        RAISE EXCEPTION
          'Inscrição negada: o campeonato % já atingiu o limite de % equipes.',
          NEW.id_campeonato, v_limite;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_impedir_inscricao_equipe_limite_excedido
BEFORE INSERT ON equipe_campeonato
FOR EACH ROW
EXECUTE FUNCTION fn_impedir_inscricao_equipe_limite_excedido();
