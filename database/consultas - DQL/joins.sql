-- 1) Partidas com nomes das equipes, campeonato e fase
SELECT 
    p.id AS partida_id,
    c.nome AS campeonato,
    f.nome_fase,
    e1.nome AS equipe1,
    e2.nome AS equipe2,
    p.data_hora,
    p.local_partida
FROM partida p
INNER JOIN campeonato c ON p.campeonato_id = c.id
INNER JOIN fase f ON p.fase_id = f.id
INNER JOIN equipe e1 ON p.equipe1_id = e1.id
INNER JOIN equipe e2 ON p.equipe2_id = e2.id
ORDER BY p.data_hora;


-- 2) Resultados das partidas com nome da equipe vencedora
SELECT 
    r.id AS resultado_id,
    p.id AS partida_id,
    c.nome AS campeonato,
    ev.nome AS equipe_vencedora,
    r.pontuacao_equipe_a,
    r.pontuacao_equipe_b,
    r.duracao_segundos
FROM resultado r
INNER JOIN partida p ON r.partida_id = p.id
INNER JOIN campeonato c ON p.campeonato_id = c.id
INNER JOIN equipe ev ON r.equipe_vencedora_id = ev.id;


-- 3) Jogadores com o nome da equipe
SELECT 
    j.nome AS jogador,
    j.posicao_ranking,
    e.nome AS equipe
FROM jogador j
INNER JOIN equipe e ON j.equipe_id = e.id
ORDER BY e.nome, j.posicao_ranking;


-- 4) Estatísticas detalhadas: jogador, equipe e partida
SELECT 
    est.nome_metrica,
    est.valor,
    j.nome AS jogador,
    eq.nome AS equipe,
    p.id AS partida_id,
    p.data_hora
FROM estatistica est
INNER JOIN partida p ON est.partida_id = p.id
INNER JOIN equipe eq ON est.equipe_id = eq.id
INNER JOIN jogador j ON est.jogador_id = j.id;


-- 5) Equipes inscritas em campeonatos (com status de participação)
SELECT 
    c.nome AS campeonato,
    e.nome AS equipe,
    ec.status_participacao
FROM equipe_campeonato ec
INNER JOIN campeonato c ON ec.campeonato_id = c.id
INNER JOIN equipe e ON ec.equipe_id = e.id
ORDER BY c.nome;


-- 6) Campeonatos com modalidade e organização responsável
SELECT 
    c.nome AS campeonato,
    m.nome AS modalidade,
    o.nome AS organizacao,
    c.status,
    c.premiacao
FROM campeonato c
INNER JOIN modalidade m ON c.modalidade_id = m.id
INNER JOIN organizacao o ON c.organizacao_id = o.id
ORDER BY c.data_inicio;


-- 7) Join "grande": partida + campeonato + fase + equipes + resultado
SELECT 
    c.nome AS campeonato,
    f.nome_fase,
    e1.nome AS equipe1,
    e2.nome AS equipe2,
    ev.nome AS vencedora,
    r.pontuacao_equipe_a,
    r.pontuacao_equipe_b
FROM partida p
INNER JOIN campeonato c ON p.campeonato_id = c.id
INNER JOIN fase f ON p.fase_id = f.id
INNER JOIN equipe e1 ON p.equipe1_id = e1.id
INNER JOIN equipe e2 ON p.equipe2_id = e2.id
INNER JOIN resultado r ON r.partida_id = p.id
INNER JOIN equipe ev ON r.equipe_vencedora_id = ev.id
ORDER BY c.nome, f.nome_fase;


-- 8) Fases de cada campeonato com quantidade de partidas
SELECT 
    c.nome AS campeonato,
    f.nome_fase,
    f.formato_disputa,
    COUNT(p.id) AS total_partidas
FROM fase f
INNER JOIN campeonato c ON f.campeonato_id = c.id
INNER JOIN partida p ON p.fase_id = f.id
GROUP BY c.nome, f.nome_fase, f.formato_disputa
ORDER BY c.nome;


-- 9) Estatísticas de kills por jogador, com equipe e campeonato
SELECT 
    j.nome AS jogador,
    eq.nome AS equipe,
    c.nome AS campeonato,
    est.valor AS kills
FROM estatistica est
INNER JOIN jogador j ON est.jogador_id = j.id
INNER JOIN equipe eq ON est.equipe_id = eq.id
INNER JOIN partida p ON est.partida_id = p.id
INNER JOIN campeonato c ON p.campeonato_id = c.id
WHERE est.nome_metrica = 'Kills'
ORDER BY est.valor DESC;


-- 10) Ranking de vitórias por equipe dentro de cada campeonato
SELECT 
    c.nome AS campeonato,
    e.nome AS equipe,
    COUNT(r.id) AS vitorias_no_campeonato
FROM resultado r
INNER JOIN partida p ON r.partida_id = p.id
INNER JOIN campeonato c ON p.campeonato_id = c.id
INNER JOIN equipe e ON r.equipe_vencedora_id = e.id
GROUP BY c.nome, e.nome
ORDER BY c.nome, vitorias_no_campeonato DESC;


-- 11) Jogadores que participaram de partidas (via estatística), com data e local
SELECT DISTINCT
    j.nome AS jogador,
    eq.nome AS equipe,
    p.data_hora,
    p.local_partida
FROM jogador j
INNER JOIN estatistica est ON est.jogador_id = j.id
INNER JOIN equipe eq ON j.equipe_id = eq.id
INNER JOIN partida p ON est.partida_id = p.id
ORDER BY p.data_hora;


-- 12) Campeonatos com total de equipes com status 'Ativa'
SELECT 
    c.nome AS campeonato,
    m.nome AS modalidade,
    COUNT(ec.id) AS equipes_ativas
FROM campeonato c
INNER JOIN modalidade m ON c.modalidade_id = m.id
INNER JOIN equipe_campeonato ec ON ec.campeonato_id = c.id AND ec.status_participacao = 'Ativa'
GROUP BY c.nome, m.nome
ORDER BY equipes_ativas DESC;


-- 13) Comparativo: pontuação da partida x nome das equipes e vencedora
SELECT 
    e1.nome AS equipe1,
    e2.nome AS equipe2,
    r.pontuacao_equipe_a,
    r.pontuacao_equipe_b,
    ev.nome AS vencedora,
    r.observacoes
FROM partida p
INNER JOIN resultado r ON r.partida_id = p.id
INNER JOIN equipe e1 ON p.equipe1_id = e1.id
INNER JOIN equipe e2 ON p.equipe2_id = e2.id
INNER JOIN equipe ev ON r.equipe_vencedora_id = ev.id;


-- 14) Média de MVP Score por equipe, por campeonato
SELECT 
    c.nome AS campeonato,
    eq.nome AS equipe,
    ROUND(AVG(est.valor), 2) AS media_mvp_score
FROM estatistica est
INNER JOIN equipe eq ON est.equipe_id = eq.id
INNER JOIN partida p ON est.partida_id = p.id
INNER JOIN campeonato c ON p.campeonato_id = c.id
WHERE est.nome_metrica = 'MVP Score'
GROUP BY c.nome, eq.nome
ORDER BY media_mvp_score DESC;


-- 15) Join completo (5 tabelas): jogador -> equipe -> partida -> fase -> campeonato
SELECT 
    j.nome AS jogador,
    eq.nome AS equipe,
    f.nome_fase,
    c.nome AS campeonato,
    p.data_hora
FROM jogador j
INNER JOIN equipe eq ON j.equipe_id = eq.id
INNER JOIN estatistica est ON est.jogador_id = j.id
INNER JOIN partida p ON est.partida_id = p.id
INNER JOIN fase f ON p.fase_id = f.id
INNER JOIN campeonato c ON p.campeonato_id = c.id
ORDER BY c.nome, f.nome_fase;


-- =========================================================
-- OBSERVAÇÃO:
-- As tabelas 'arbitro' e 'patrocinador' não possuem FK
-- ligando-as ao restante do banco, portanto não é possível
-- fazer INNER JOIN delas com as demais tabelas neste esquema.
-- =========================================================
