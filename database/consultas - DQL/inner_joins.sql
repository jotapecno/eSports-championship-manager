-- 1. Partidas com equipes, campeonato e fase
SELECT
    p.id AS partida_id,
    e1.nome AS equipe1,
    e2.nome AS equipe2,
    c.nome AS campeonato,
    f.nome AS fase
FROM partida p
INNER JOIN equipe e1 ON p.equipe1_id = e1.id
INNER JOIN equipe e2 ON p.equipe2_id = e2.id
INNER JOIN campeonato c ON p.campeonato_id = c.id
INNER JOIN fase f ON p.fase_id = f.id;

-- 2. Fases e suas partidas
SELECT
    f.nome AS fase,
    c.nome AS campeonato,
    p.id AS partida_id
FROM fase f
INNER JOIN campeonato c ON f.campeonato_id = c.id
INNER JOIN partida p ON p.fase_id = f.id;

-- 5. Jogadores e suas equipes
SELECT
    j.nome AS jogador,
    e.nome AS equipe
FROM jogador j
INNER JOIN equipe e ON j.equipe_id = e.id;

-- 6. Quantidade de jogadores por equipe
SELECT
    e.nome AS equipe,
    COUNT(j.id) AS quantidade_jogadores
FROM equipe e
INNER JOIN jogador j ON j.equipe_id = e.id
GROUP BY e.nome
ORDER BY quantidade_jogadores DESC;
