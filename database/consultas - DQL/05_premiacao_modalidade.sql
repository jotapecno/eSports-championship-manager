-- ============================================================
-- CONSULTA 05: Premiação total por modalidade
-- Descrição: Soma o valor total de premiação distribuída em campeonatos agrupados por modalidade.
-- Dependências de dados: Tabelas modalidade e campeonato.
-- ============================================================

select 
	sum(c.premiacao) as premiação,
	m.nome as modalidade
from
	modalidade m inner join campeonato c on m.id = c.modalidade_id
group by 
	m.nome;
