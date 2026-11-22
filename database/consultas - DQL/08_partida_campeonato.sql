-- ============================================================
-- CONSULTA 08: Total de partidas por campeonato
-- Descrição: Contabiliza a quantidade total de partidas vinculadas a cada campeonato.
-- Dependências de dados: Tabelas partida e campeonato.
-- ============================================================

select
	c.nome as campeonato,
	count(p.id) as total_de_partidas
from 
	partida p inner join campeonato c on c.id = p.campeonato_id
group by
	c.nome;
