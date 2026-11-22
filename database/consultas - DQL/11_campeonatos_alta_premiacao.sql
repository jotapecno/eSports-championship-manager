-- ============================================================
-- CONSULTA 11: Campeonatos com premiação acima de 100.000
-- Descrição: Filtra e ordena de forma decrescente os campeonatos cuja premiação ultrapassa 100.000.
-- Dependências de dados: Tabela campeonato.
-- ============================================================

SELECT id, nome,premiacao
FROM campeonato
WHERE premiacao > 100000
ORDER BY premiacao DESC;
