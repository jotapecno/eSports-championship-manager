-- ============================================================
-- CONSULTA 15: Total de objetivos capturados por equipe
-- Descrição: Soma a quantidade total de 'Objetivos Capturados' por cada equipe nas partidas.
-- Dependências de dados: Tabelas equipe e estatistica.
-- ============================================================

SELECT e.id AS equipe_id, e.nome AS nome_equipe,
       COALESCE(SUM(est.valor), 0) AS total_objetivos
FROM equipe e
LEFT JOIN estatistica est ON est.equipe_id = e.id AND est.nome_metrica = 'Objetivos Capturados'
GROUP BY e.id, e.nome
ORDER BY total_objetivos DESC, e.nome;
