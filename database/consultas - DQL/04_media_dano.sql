-- ============================================================
-- CONSULTA 04: Jogador com a maior média de dano causado
-- Descrição: Identifica o(s) jogador(es) com a maior média na métrica 'Dano Total', incluindo empates no topo.
-- Dependências de dados: Tabelas estatistica e jogador.
-- ============================================================

SELECT j.nome AS jogador, ROUND(AVG(es.valor), 2) AS media_dano
FROM estatistica es
JOIN jogador j ON j.id = es.jogador_id
WHERE es.nome_metrica = 'Dano Total'
GROUP BY j.id, j.nome
ORDER BY media_dano DESC
FETCH FIRST 1 ROW WITH TIES;
