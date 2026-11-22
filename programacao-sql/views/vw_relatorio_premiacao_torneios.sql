-- ============================================================
-- VIEW: vw_relatorio_premiacao_torneios
-- Descrição: Exibe o balanço financeiro dos campeonatos encerrados, comparando o total arrecadado em patrocínios com a premiação distribuída ao pódio (1º, 2º e 3º lugares).
-- Dependências de dados: Tabelas campeonato, modalidade, campeonato_patrocinador, equipe_campeonato, equipe, classificacao_campeonato e auditoria_campeoes.
-- ============================================================

CREATE OR REPLACE VIEW vw_relatorio_premiacao_torneios AS
WITH ranking_campeonato AS (
    SELECT
        ec.campeonato_id,
        ec.equipe_id,
        e.nome AS nome_equipe,
        ROW_NUMBER() OVER (
            PARTITION BY ec.campeonato_id
            ORDER BY
                ec.posicao_ranking ASC NULLS LAST,
                COALESCE(cc.pontos, 0) DESC,
                COALESCE(cc.vitorias, 0) DESC,
                COALESCE(cc.derrotas, 0) ASC,
                ec.id ASC
        ) AS colocacao
    FROM equipe_campeonato ec
    INNER JOIN equipe e ON e.id = ec.equipe_id
    LEFT JOIN classificacao_campeonato cc
        ON cc.campeonato_id = ec.campeonato_id
       AND cc.equipe_id = ec.equipe_id
)
SELECT
    c.id AS campeonato_id,
    c.nome AS campeonato,
    m.nome AS modalidade,
    c.status,
    (SELECT COALESCE(SUM(cp.valor), 0)
       FROM campeonato_patrocinador cp
      WHERE cp.campeonato_id = c.id)::NUMERIC(12,2) AS total_arrecadado,
    COALESCE(c.premiacao, 0)::NUMERIC(12,2) AS valor_distribuido_premios,
    MAX(CASE WHEN rc.colocacao = 1 THEN rc.nome_equipe END) AS equipe_1_lugar,
    ROUND(COALESCE(c.premiacao, 0) * 0.50, 2)::NUMERIC(12,2) AS premio_1_lugar,
    MAX(CASE WHEN rc.colocacao = 2 THEN rc.nome_equipe END) AS equipe_2_lugar,
    ROUND(COALESCE(c.premiacao, 0) * 0.30, 2)::NUMERIC(12,2) AS premio_2_lugar,
    MAX(CASE WHEN rc.colocacao = 3 THEN rc.nome_equipe END) AS equipe_3_lugar,
    ROUND(COALESCE(c.premiacao, 0) * 0.20, 2)::NUMERIC(12,2) AS premio_3_lugar
FROM campeonato c
INNER JOIN modalidade m ON m.id = c.modalidade_id
LEFT JOIN ranking_campeonato rc
    ON rc.campeonato_id = c.id
   AND rc.colocacao IN (1, 2, 3)
WHERE LOWER(c.status) IN ('finalizado', 'encerrado')
GROUP BY c.id, c.nome, m.nome, c.status, c.premiacao
ORDER BY c.data_fim DESC NULLS LAST, c.id DESC;
