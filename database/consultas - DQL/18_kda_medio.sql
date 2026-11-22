-- ============================================================
-- CONSULTA 18: Média de mortes por jogador em cada equipe
-- Descrição: Exibe a quantidade de atletas avaliados e a média de 'Mortes' registradas por equipe.
-- Dependências de dados: Tabelas equipe e estatistica.
-- ============================================================

SELECT e.id AS equipe_id, e.nome AS nome_equipe,
       COUNT(DISTINCT s.jogador_id) AS jogadores_com_estatistica,
       ROUND(AVG(s.valor), 2)       AS media_mortes
FROM equipe e
LEFT JOIN estatistica s ON s.equipe_id = e.id AND s.nome_metrica = 'Mortes'
GROUP BY e.id, e.nome
ORDER BY media_mortes DESC NULLS LAST;
