-- 1. Partidas com equipes, campeonato e fase
SELECT
    p.id AS partida_id,
    e1.nome AS equipe1,
    e2.nome AS equipe2,
    c.nome AS campeonato,
    f.nome AS fase
FROM partida p
INNER JOIN equipe e1 ON p.equipe1_id = e1.id
INNER JOIN equipe e2 ON p.equipe2_id = e2.id
INNER JOIN campeonato c ON p.campeonato_id = c.id
INNER JOIN fase f ON p.fase_id = f.id;

-- 2. Fases e suas partidas
SELECT
    f.nome AS fase,
    c.nome AS campeonato,
    p.id AS partida_id
FROM fase f
INNER JOIN campeonato c ON f.campeonato_id = c.id
INNER JOIN partida p ON p.fase_id = f.id;

-- 3. Resultado de cada partida
SELECT
    p.id AS partida_id,
    e1.nome AS equipe1,
    e2.nome AS equipe2,
    ev.nome AS equipe_vencedora
FROM resultado r
INNER JOIN partida p ON r.partida_id = p.id
INNER JOIN equipe e1 ON p.equipe1_id = e1.id
INNER JOIN equipe e2 ON p.equipe2_id = e2.id
INNER JOIN equipe ev ON r.equipe_vencedora_id = ev.id;

-- 4. Resultados por campeonato
SELECT
    c.nome AS campeonato,
    p.id AS partida_id,
    e.nome AS equipe_vencedora
FROM resultado r
INNER JOIN partida p ON r.partida_id = p.id
INNER JOIN campeonato c ON p.campeonato_id = c.id
INNER JOIN equipe e ON r.equipe_vencedora_id = e.id;

-- 5. Jogadores e suas equipes
SELECT
    j.nome AS jogador,
    e.nome AS equipe
FROM jogador j
INNER JOIN equipe e ON j.equipe_id = e.id;

-- 6. Quantidade de jogadores por equipe
SELECT
    e.nome AS equipe,
    COUNT(j.id) AS quantidade_jogadores
FROM equipe e
INNER JOIN jogador j ON j.equipe_id = e.id
GROUP BY e.nome
ORDER BY quantidade_jogadores DESC;

--7. Campeonatos e suas equipes
select 
	ec.id,
	c.nome as campeonato,
	e.nome as equipe,
	ec.status_participacao 
from
	equipe_campeonato ec
inner join campeonato c on ec.campeonato_id = c.id
inner join equipe e on e.id = ec.equipe_id ;

-- 9. Campeonatos e modalidades
SELECT
    c.nome AS campeonato,
    m.nome AS modalidade
FROM campeonato c
INNER JOIN modalidade m ON c.modalidade_id = m.id;

-- 10. Campeonatos e organizações
SELECT
    c.nome AS campeonato,
    o.nome AS organizacao
FROM campeonato c
INNER JOIN organizacao o ON c.organizacao_id = o.id;

-- 11. Equipes inscritas nos campeonatos
SELECT
    c.nome AS campeonato,
    e.nome AS equipe
FROM equipe_campeonato ec
INNER JOIN campeonato c ON ec.campeonato_id = c.id
INNER JOIN equipe e ON ec.equipe_id = e.id;

-- 12. Equipes e status de participação
SELECT
    c.nome AS campeonato,
    e.nome AS equipe,
    ec.status_participacao
FROM equipe_campeonato ec
INNER JOIN campeonato c ON ec.campeonato_id = c.id
INNER JOIN equipe e ON ec.equipe_id = e.id;
