CREATE OR REPLACE VIEW vw_tabela_classificacao_campeonato AS
WITH jogos AS (
    SELECT p.id_campeonato, p.id_equipe_a AS id_equipe,
           r.placar_a AS pro, r.placar_b AS contra
      FROM partida p
      JOIN resultado r ON r.id_partida = p.id_partida
    UNION ALL
    SELECT p.id_campeonato, p.id_equipe_b AS id_equipe,
           r.placar_b AS pro, r.placar_a AS contra
      FROM partida p
      JOIN resultado r ON r.id_partida = p.id_partida
)
SELECT
    c.id_campeonato,
    c.nome                                         AS campeonato,
    e.id_equipe,
    e.nome                                         AS equipe,
    COUNT(j.id_equipe)                             AS jogos,
    COUNT(*) FILTER (WHERE j.pro > j.contra)       AS vitorias,
    COUNT(*) FILTER (WHERE j.pro = j.contra)       AS empates,
    COUNT(*) FILTER (WHERE j.pro < j.contra)       AS derrotas,
    COALESCE(SUM(j.pro), 0)                        AS pontos_pro,
    COALESCE(SUM(j.contra), 0)                     AS pontos_contra,
    COALESCE(SUM(j.pro - j.contra), 0)             AS saldo,
    COUNT(*) FILTER (WHERE j.pro > j.contra) * 3
      + COUNT(*) FILTER (WHERE j.pro = j.contra)   AS pontos
FROM equipe_campeonato ec
JOIN campeonato c ON c.id_campeonato = ec.id_campeonato
JOIN equipe e     ON e.id_equipe     = ec.id_equipe
LEFT JOIN jogos j ON j.id_campeonato = ec.id_campeonato
                 AND j.id_equipe     = ec.id_equipe
GROUP BY c.id_campeonato, c.nome, e.id_equipe, e.nome
ORDER BY c.id_campeonato, pontos DESC, vitorias DESC, saldo DESC;
