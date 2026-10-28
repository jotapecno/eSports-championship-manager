SELECT m.nome,
ROUND(AVG(r.duracao_segundos)) AS media_duracao,
COUNT(p.id) AS partidas_por_modalidade
FROM partida p
INNER JOIN resultado r ON p.id = r.partida_id
INNER JOIN campeonato c ON p.campeonato_id = c.id
INNER JOIN modalidade m ON m.id = c.modalidade_id
GROUP BY
m.nome;
