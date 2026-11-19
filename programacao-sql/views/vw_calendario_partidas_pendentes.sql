CREATE OR REPLACE VIEW vw_calendario_partidas_pendentes AS
SELECT
    p.id AS partida_id,
    c.id AS campeonato_id,
    c.nome AS campeonato,
    p.data_hora::DATE AS data_partida,
    TO_CHAR(p.data_hora, 'HH24:MI') AS horario,
    m.nome AS modalidade,
    e1.nome AS equipe_1,
    e2.nome AS equipe_2,
    (e1.nome || ' vs ' || e2.nome) AS confronto,
    f.nome_fase AS fase_competicao,
    p.local_partida
FROM partida p
INNER JOIN campeonato c ON p.campeonato_id = c.id
INNER JOIN modalidade m ON c.modalidade_id = m.id
INNER JOIN equipe e1 ON p.equipe1_id = e1.id
INNER JOIN equipe e2 ON p.equipe2_id = e2.id
INNER JOIN fase f ON p.fase_id = f.id
LEFT JOIN resultado r ON r.partida_id = p.id
WHERE r.id IS NULL
ORDER BY p.data_hora ASC, p.id ASC;
