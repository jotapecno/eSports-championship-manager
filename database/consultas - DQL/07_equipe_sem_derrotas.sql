-- ============================================================
-- CONSULTA 07: Equipes invictas por campeonato
-- Descrição: Lista as equipes que possuem ao menos uma vitória e nenhuma derrota registrada na tabela de classificação.
-- Dependências de dados: Tabelas classificacao_campeonato, equipe e campeonato.
-- ============================================================

SELECT c.nome AS campeonato,
       e.nome AS equipe,
       cc.vitorias,
       cc.derrotas
FROM classificacao_campeonato cc
JOIN equipe e     ON e.id = cc.equipe_id
JOIN campeonato c ON c.id = cc.campeonato_id
WHERE cc.derrotas = 0
  AND cc.vitorias > 0
ORDER BY c.nome, cc.vitorias DESC;
