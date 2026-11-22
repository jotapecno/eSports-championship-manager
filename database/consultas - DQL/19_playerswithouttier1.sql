-- ============================================================
-- CONSULTA 19: Jogadores sem estatísticas registradas
-- Descrição: Lista os atletas cadastrados que ainda não possuem nenhuma métrica lançada em partidas.
-- Dependências de dados: Tabelas jogador e estatistica.
-- ============================================================

SELECT j.id AS jogador_id, j.nome AS nome_jogador
FROM jogador j
WHERE NOT EXISTS (SELECT 1 FROM estatistica s WHERE s.jogador_id = j.id)
ORDER BY j.nome;
