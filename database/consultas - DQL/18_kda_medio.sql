WITH equipes AS (
    SELECT 1 AS id, 'Alpha Gaming' AS nome UNION ALL
    SELECT 2, 'Beta Esports' UNION ALL
    SELECT 3, 'Gamma Warriors'
),
jogadores AS (
    SELECT 1 AS id, 'Jogador A1' AS nome, 1 AS equipe_id, 12 AS mortes UNION ALL
    SELECT 2, 'Jogador A2', 1, 18 UNION ALL
    SELECT 3, 'Jogador B1', 2, 5 UNION ALL
    SELECT 4, 'Jogador B2', 2, 9 UNION ALL
    SELECT 5, 'Jogador B3', 2, 14 UNION ALL
    SELECT 6, 'Jogador C1', 3, 25
)
SELECT 
    e.id AS equipe_id,
    e.nome AS nome_equipe,
    COUNT(j.id) AS total_jogadores,
    ROUND(AVG(j.mortes), 2) AS media_mortes
FROM 
    equipes e
LEFT JOIN 
    jogadores j ON e.id = j.equipe_id
GROUP BY 
    e.id, 
    e.nome
ORDER BY 
    media_mortes DESC;
