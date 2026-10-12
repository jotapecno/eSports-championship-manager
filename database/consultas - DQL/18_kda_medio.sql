
CREATE TABLE equipes (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE jogadores (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    equipe_id INT,
    mortes INT DEFAULT 0,
    CONSTRAINT fk_equipe FOREIGN KEY (equipe_id) REFERENCES equipes(id)
);

INSERT INTO equipes (id, nome) VALUES 
(1, 'Alpha Gaming'),
(2, 'Beta Esports'),
(3, 'Gamma Warriors');

INSERT INTO jogadores (id, nome, equipe_id, mortes) VALUES 
(1, 'Jogador A1', 1, 12),
(2, 'Jogador A2', 1, 18),
(3, 'Jogador B1', 2, 5),
(4, 'Jogador B2', 2, 9),
(5, 'Jogador B3', 2, 14),
(6, 'Jogador C1', 3, 25);

SELECT 
    e.id AS equipe_id,
    e.nome AS nome_equipe,
    COUNT(j.id) AS total_jogadores,
    ROUND(AVG(j.mortes), 2) AS media_mortes
FROM 
    equipes e
LEFT JOIN 
    jogadores j ON e.id = j.equipe_id
GROUP BY 
    e.id, 
    e.nome
ORDER BY 
    media_mortes DESC;
