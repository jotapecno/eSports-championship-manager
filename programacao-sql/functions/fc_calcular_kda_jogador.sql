-- Function: fc_calcular_kda_jogador
-- Retorna o KDA acumulado do jogador: (Kills + Assists) / Deaths.
-- Filtros opcionais por campeonato e/ou modalidade.
-- Uso: SELECT fc_calcular_kda_jogador(1);                        -- geral
--      SELECT fc_calcular_kda_jogador(1, 2);                     -- campeonato 2
--      SELECT fc_calcular_kda_jogador(1, p_modalidade_id => 3);  -- modalidade 3

CREATE OR REPLACE FUNCTION fc_calcular_kda_jogador(
    p_jogador_id    INT,
    p_campeonato_id INT DEFAULT NULL,
    p_modalidade_id INT DEFAULT NULL
)
RETURNS NUMERIC(10,2)
LANGUAGE plpgsql
AS $$
DECLARE
    v_kills   NUMERIC;
    v_assists NUMERIC;
    v_deaths  NUMERIC;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM jogador WHERE id = p_jogador_id) THEN
        RAISE EXCEPTION 'Jogador % não encontrado.', p_jogador_id;
    END IF;

    -- Os nomes das métricas devem bater com os usados nos INSERTs de estatistica
    SELECT
        COALESCE(SUM(e.valor) FILTER (
            WHERE LOWER(e.nome_metrica) IN ('kills', 'eliminacoes', 'eliminações', 'abates')), 0),
        COALESCE(SUM(e.valor) FILTER (
            WHERE LOWER(e.nome_metrica) IN ('assists', 'assistencias', 'assistências')), 0),
        COALESCE(SUM(e.valor) FILTER (
            WHERE LOWER(e.nome_metrica) IN ('deaths', 'mortes')), 0)
      INTO v_kills, v_assists, v_deaths
      FROM estatistica e
      JOIN partida p    ON p.id = e.partida_id
      JOIN campeonato c ON c.id = p.campeonato_id
     WHERE e.jogador_id = p_jogador_id
       AND (p_campeonato_id IS NULL OR c.id = p_campeonato_id)
       AND (p_modalidade_id IS NULL OR c.modalidade_id = p_modalidade_id);

    -- Sem mortes, retorna kills + assists (evita divisão por zero)
    IF v_deaths = 0 THEN
        RETURN ROUND(v_kills + v_assists, 2);
    END IF;

    RETURN ROUND((v_kills + v_assists) / v_deaths, 2);
END;
$$;
