drop table if exists classificacao_campeonato;

create table classificacao_campeonato (
campeonato_id int not null,
equipe_id int not null,
pontos int not null default 0,
vitorias int not null default 0,
derrotas int not null default 0,
primary key(campeonato_id, equipe_id),
constraint fk_classificacao_campeonato 
foreign key (campeonato_id) references campeonato(id)
on delete restrict,
constraint fk_classificacao_equipe
foreign key (equipe_id) references equipe(id)
on delete restrict 
);
