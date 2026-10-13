WITH jogadores AS (
    SELECT 1 AS id, 'Jogador Alpha' AS nome UNION ALL
    SELECT 2, 'Jogador Bravo' UNION ALL
    SELECT 3, 'Jogador Charlie' UNION ALL
    SELECT 4, 'Jogador Delta'
),
campeonatos AS (
    SELECT 101 AS id, 'Global Championship 2026' AS nome, 'Tier 1' AS tier UNION ALL
    SELECT 102, 'Major League Spring', 'Tier 1' UNION ALL
    SELECT 103, 'Challenger Series', 'Tier 2' UNION ALL
    SELECT 104, 'Open Amateur Cup', 'Tier 3'
),
participacoes AS (
    SELECT 1 AS jogador_id, 101 AS campeonato_id UNION ALL
    SELECT 1, 103 UNION ALL
    SELECT 2, 103 UNION ALL
    SELECT 2, 104 UNION ALL
    SELECT 3, 102
)
SELECT 
    j.id AS jogador_id,
    j.nome AS nome_jogador
FROM 
    jogadores j
WHERE 
    j.id NOT IN (
        SELECT DISTINCT p.jogador_id
        FROM participacoes p
        JOIN campeonatos c ON p.campeonato_id = c.id
        WHERE c.tier = 'Tier 1'
    )
ORDER BY 
    j.nome;
