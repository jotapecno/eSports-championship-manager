-- ============================================================
-- VIEW: vw_tabela_classificacao_campeonato
-- Descrição: Gera dinamicamente o ranking de classificação de cada campeonato com posição, jogos, vitórias, empates, derrotas, saldo de rounds e pontuação.
-- Dependências de dados: Tabelas equipe_campeonato, campeonato, equipe, partida e resultado.
-- ============================================================

CREATE OR REPLACE VIEW vw_tabela_classificacao_campeonato AS
WITH jogos AS (
    -- cada partida vira DUAS linhas: uma para cada equipe (pro = pontos a favor)
    SELECT p.campeonato_id, p.equipe1_id AS equipe_id,
           r.pontuacao_equipe_a AS pro, r.pontuacao_equipe_b AS contra
      FROM partida p
      JOIN resultado r ON r.partida_id = p.id
    UNION ALL
    SELECT p.campeonato_id, p.equipe2_id AS equipe_id,
           r.pontuacao_equipe_b AS pro, r.pontuacao_equipe_a AS contra
      FROM partida p
      JOIN resultado r ON r.partida_id = p.id
),
tabela AS (
    SELECT
        c.id                                          AS campeonato_id,
        c.nome                                        AS campeonato,
        e.id                                          AS equipe_id,
        e.nome                                        AS equipe,
        COUNT(j.equipe_id)                            AS jogos,
        COUNT(*) FILTER (WHERE j.pro > j.contra)      AS vitorias,
        COUNT(*) FILTER (WHERE j.pro = j.contra)      AS empates,
        COUNT(*) FILTER (WHERE j.pro < j.contra)      AS derrotas,
        COALESCE(SUM(j.pro), 0)                       AS rounds_pro,
        COALESCE(SUM(j.contra), 0)                    AS rounds_contra,
        COALESCE(SUM(j.pro - j.contra), 0)            AS saldo_rounds,
        COUNT(*) FILTER (WHERE j.pro > j.contra) * 3
          + COUNT(*) FILTER (WHERE j.pro = j.contra)  AS pontos
    FROM equipe_campeonato ec
    JOIN campeonato c ON c.id = ec.campeonato_id
    JOIN equipe e     ON e.id = ec.equipe_id
    LEFT JOIN jogos j ON j.campeonato_id = ec.campeonato_id
                     AND j.equipe_id     = ec.equipe_id
    GROUP BY c.id, c.nome, e.id, e.nome
)
SELECT
    ROW_NUMBER() OVER (PARTITION BY campeonato_id
                       ORDER BY pontos DESC, vitorias DESC, saldo_rounds DESC, equipe) AS posicao,
    t.*
FROM tabela t
ORDER BY campeonato_id, posicao;
