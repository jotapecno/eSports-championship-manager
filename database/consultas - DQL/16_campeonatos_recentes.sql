-- ============================================================
-- CONSULTA 16: Campeonatos recentes (últimos 6 meses)
-- Descrição: Lista os torneios com data de início ou término nos últimos 6 meses, detalhando status, modalidade e organização.
-- Dependências de dados: Tabelas campeonato, modalidade e organizacao.
-- ============================================================

SELECT
c.id AS campeonato_id,
c.nome AS nome_campeonato,
c.data_inicio,
c.data_fim,
c.status,
m.nome AS modalidade,
o.nome AS organizacao
FROM
campeonato c
JOIN
modalidade m ON c.modalidade_id = m.id
JOIN
organizacao o ON c.organizacao_id = o.id
WHERE
c.data_inicio >= CURRENT_DATE - INTERVAL '6 months'
OR c.data_fim >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY
c.data_inicio DESC;
