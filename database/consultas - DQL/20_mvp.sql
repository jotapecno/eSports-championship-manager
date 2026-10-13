WITH modalidades AS (
    SELECT 1 AS id, 'Counter-Strike 2' AS nome UNION ALL
    SELECT 2, 'Valorant'
),
equipes AS (
    SELECT 10 AS id, 'Alpha Esports' AS nome UNION ALL
    SELECT 20, 'Beta Gaming' UNION ALL
    SELECT 30, 'Gamma Team'
),
jogadores AS (
    SELECT 100 AS id, 'Jogador S1mple' AS nome, 10 AS equipe_id UNION ALL
    SELECT 200, 'Jogador TenZ', 20 UNION ALL
    SELECT 300, 'Jogador Niko', 30
),
campeonatos AS (
    SELECT 1 AS id, 'Major Championship 2026' AS nome, 1 AS modalidade_id, 10 AS equipe_vencedora_id, 100 AS mvp_id UNION ALL
    SELECT 2, 'Masters Invitational', 2, 20, 200
)
SELECT 
    c.nome AS campeonato,
    m.nome AS modalidade,
    e.nome AS equipe_vencedora,
    j.nome AS mvp
FROM 
    campeonatos c
INNER JOIN 
    modalidades m ON c.modalidade_id = m.id
INNER JOIN <code>equipes</code> e ON c.equipe_vencedora_id = e.id
INNER JOIN 
    jogadores j ON c.mvp_id = j.id
ORDER BY 
    c.nome;
