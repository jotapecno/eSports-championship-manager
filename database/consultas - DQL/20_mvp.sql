-- ============================================================
-- CONSULTA 20: Campeão e MVP de cada campeonato finalizado
-- Descrição: Exibe a equipe campeã (1º lugar) e o jogador com maior 'MVP Score' em cada torneio finalizado.
-- Dependências de dados: Tabelas campeonato, modalidade, equipe_campeonato, equipe, estatistica, partida e jogador.
-- ============================================================

SELECT c.nome AS campeonato,
       m.nome AS modalidade,
       eq.nome AS equipe_campea,
       mvp.jogador AS mvp
FROM campeonato c
JOIN modalidade m ON m.id = c.modalidade_id
LEFT JOIN equipe_campeonato ec ON ec.campeonato_id = c.id AND ec.posicao_ranking = 1
LEFT JOIN equipe eq ON eq.id = ec.equipe_id
LEFT JOIN LATERAL (
    SELECT j.nome AS jogador
    FROM estatistica s
    JOIN partida p ON p.id = s.partida_id
    JOIN jogador j ON j.id = s.jogador_id
    WHERE p.campeonato_id = c.id AND s.nome_metrica = 'MVP Score'
    ORDER BY s.valor DESC
    LIMIT 1
) mvp ON TRUE
WHERE c.status = 'Finalizado'
ORDER BY c.nome;
