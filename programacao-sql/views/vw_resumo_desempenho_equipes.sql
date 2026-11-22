-- ============================================================
-- VIEW: vw_resumo_desempenho_equipes
-- Descrição: Apresenta o histórico geral de cada equipe, incluindo partidas disputadas, vitórias, percentual de aproveitamento (win rate), títulos conquistados e premiação acumulada.
-- Dependências de dados: Tabelas equipe, partida, resultado, equipe_campeonato, campeonato e auditoria_campeoes.
-- ============================================================

CREATE OR REPLACE VIEW vw_resumo_desempenho_equipes AS
SELECT
    e.id   AS equipe_id,
    e.nome AS equipe,
    COUNT(r.id) AS partidas_disputadas,
    COUNT(r.id) FILTER (WHERE r.equipe_vencedora_id = e.id) AS vitorias,
    ROUND(100.0 * COUNT(r.id) FILTER (WHERE r.equipe_vencedora_id = e.id)
          / NULLIF(COUNT(r.id), 0), 2) AS win_rate_pct,
    (SELECT COUNT(*)
       FROM equipe_campeonato ec
       JOIN campeonato c ON c.id = ec.campeonato_id
      WHERE ec.equipe_id = e.id AND ec.posicao_ranking = 1
        AND c.status = 'Finalizado') AS titulos,
    (SELECT COALESCE(SUM(a.valor_transferencia), 0)
       FROM auditoria_campeoes a
      WHERE a.equipe_id = e.id) AS premiacao_total
FROM equipe e
LEFT JOIN partida p   ON e.id IN (p.equipe1_id, p.equipe2_id)
LEFT JOIN resultado r ON r.partida_id = p.id
GROUP BY e.id, e.nome;
