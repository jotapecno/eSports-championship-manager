-- ============================================================
-- CONSULTA 14: Média de assistências dos jogadores com função Suporte
-- Descrição: Calcula a média da métrica 'Assistencias' exclusivamente para atletas cuja função preferida é 'Suporte'.
-- Dependências de dados: Tabelas jogador e estatistica.
-- ============================================================

SELECT j.nome AS nome_jogador, ROUND(AVG(est.valor), 2) AS media_assistencias
FROM jogador j
JOIN estatistica est ON est.jogador_id = j.id
WHERE j.funcao_preferida = 'Suporte'
  AND est.nome_metrica = 'Assistencias'
GROUP BY j.id, j.nome;
