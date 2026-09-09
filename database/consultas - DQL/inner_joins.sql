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

