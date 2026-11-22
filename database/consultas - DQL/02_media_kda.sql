-- ============================================================
-- CONSULTA 02: Média de KDA dos jogadores de uma modalidade
-- Descrição: Calcula a taxa de KDA ((Kills + Assistências) / Mortes) por jogador e modalidade com base nas métricas registradas.
-- Dependências de dados: Tabelas estatistica, jogador, partida, campeonato e modalidade.
-- ============================================================

SELECT j.nome AS jogador,
       ROUND((SUM(es.valor) FILTER (WHERE es.nome_metrica = 'Kills')
            + COALESCE(SUM(es.valor) FILTER (WHERE es.nome_metrica = 'Assistencias'), 0))
            / GREATEST(COALESCE(SUM(es.valor) FILTER (WHERE es.nome_metrica = 'Mortes'), 0), 1), 2) AS kda
FROM estatistica es
JOIN jogador j     ON j.id = es.jogador_id
JOIN partida p     ON p.id = es.partida_id
JOIN campeonato c  ON c.id = p.campeonato_id
JOIN modalidade m  ON m.id = c.modalidade_id
GROUP BY j.id, j.nome, m.nome
HAVING SUM(es.valor) FILTER (WHERE es.nome_metrica = 'Kills') IS NOT NULL
ORDER BY kda DESC;
