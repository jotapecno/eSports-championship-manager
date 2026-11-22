-- ============================================================
-- CONSULTA 06: Total de kills por jogador
-- Descrição: Calcula o acumulado total de abates ('Kills') de cada atleta em todas as partidas disputadas.
-- Dependências de dados: Tabelas estatistica e jogador.
-- ============================================================

SELECT j.nome AS jogador, SUM(e.valor) AS total_kills
FROM estatistica e
JOIN jogador j ON j.id = e.jogador_id
WHERE e.nome_metrica = 'Kills'
GROUP BY j.id, j.nome
ORDER BY total_kills DESC;
