-- ============================================================
-- CONSULTA 09: Jogadores com múltiplas equipes (transferências)
-- Descrição: Lista os atletas que já encerraram vínculos anteriores com equipes (data de saída preenchida) e o total de transferências.
-- Dependências de dados: Tabelas jogador_equipe e jogador.
-- ============================================================

SELECT j.nome,je.jogador_id,
COUNT(je.jogador_id) AS numero_de_transferencias
FROM jogador_equipe AS je
INNER JOIN jogador AS j ON je.jogador_id = j.id
WHERE data_saida IS NOT NULL
GROUP BY j.nome, je.jogador_id;
