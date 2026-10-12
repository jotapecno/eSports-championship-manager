
CREATE TABLE modalidades (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);


CREATE TABLE equipes (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);


CREATE TABLE jogadores (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    equipe_id INT,
    CONSTRAINT fk_equipe_jogador FOREIGN KEY (equipe_id) REFERENCES equipes(id)
);


CREATE TABLE campeonatos (
    id INT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    modalidade_id INT,
    equipe_vencedora_id INT,
    mvp_id INT,
    CONSTRAINT fk_modalidade FOREIGN KEY (modalidade_id) REFERENCES modalidades(id),
    CONSTRAINT fk_equipe_vencedora FOREIGN KEY (equipe_vencedora_id) REFERENCES equipes(id),
    CONSTRAINT fk_mvp FOREIGN KEY (mvp_id) REFERENCES jogadores(id)
);


INSERT INTO modalidades (id, nome) VALUES 
(1, 'Counter-Strike 2'),
(2, 'Valorant');

INSERT INTO equipes (id, nome) VALUES 
(10, 'Alpha Esports'),
(20, 'Beta Gaming'),
(30, 'Gamma Team');

INSERT INTO jogadores (id, nome, equipe_id) VALUES 
(100, 'Jogador S1mple', 10),
(200, 'Jogador TenZ', 20),
(300, 'Jogador Niko', 30);

INSERT INTO campeonatos (id, nome, modalidade_id, equipe_vencedora_id, mvp_id) VALUES 
(1, 'Major Championship 2026', 1, 10, 100),
(2, 'Masters Invitational', 2, 20, 200);


SELECT 
    c.nome AS campeonato,
    m.nome AS modalidade,
    e.nome AS equipe_vencedora,
    j.nome AS mvp
FROM 
    campeonatos c
INNER JOIN 
    modalidades m ON c.modalidade_id = m.id
INNER JOIN 
    equipes e ON c.equipe_vencedora_id = e.id
INNER JOIN 
    jogadores j ON c.mvp_id = j.id
ORDER BY 
    c.nome;
