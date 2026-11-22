-- ============================================================
-- VIEW: vw_estatisticas_gerais_jogadores
-- Descrição: Consolida o desempenho individual dos atletas por modalidade, calculando médias de abates, mortes, assistências e a taxa de KDA.
-- Dependências de dados: Tabelas jogador, estatistica, partida, campeonato e modalidade.
-- ============================================================

CREATE OR REPLACE VIEW vw_estatisticas_gerais_jogadores AS
SELECT 
    j.id AS jogador_id,
    j.nome AS nome_jogador,
    m.nome AS modalidade,
    COALESCE(ROUND(AVG(CASE WHEN LOWER(est.nome_metrica) IN ('kills', 'eliminacoes', 'eliminações') THEN est.valor END), 2), 0) AS media_kills,
    COALESCE(ROUND(AVG(CASE WHEN LOWER(est.nome_metrica) IN ('deaths', 'mortes') THEN est.valor END), 2), 0) AS media_deaths,
    COALESCE(ROUND(AVG(CASE WHEN LOWER(est.nome_metrica) IN ('assists', 'assistencias', 'assistências') THEN est.valor END), 2), 0) AS media_assists,
    ROUND(
        (
            COALESCE(SUM(CASE WHEN LOWER(est.nome_metrica) IN ('kills', 'eliminacoes', 'eliminações') THEN est.valor END), 0) +
            COALESCE(SUM(CASE WHEN LOWER(est.nome_metrica) IN ('assists', 'assistencias', 'assistências') THEN est.valor END), 0)
        ) / COALESCE(NULLIF(SUM(CASE WHEN LOWER(est.nome_metrica) IN ('deaths', 'mortes') THEN est.valor END), 0), 1),
        2
    ) AS taxa_kda
FROM jogador j
INNER JOIN estatistica est ON j.id = est.jogador_id
INNER JOIN partida p ON est.partida_id = p.id
INNER JOIN campeonato c ON p.campeonato_id = c.id
INNER JOIN modalidade m ON c.modalidade_id = m.id
GROUP BY j.id, j.nome, m.id, m.nome;
