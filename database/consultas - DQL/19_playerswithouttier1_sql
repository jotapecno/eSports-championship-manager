
CREATE TABLE jogadores (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);


CREATE TABLE campeonatos (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tier VARCHAR(20) NOT NULL 
);

CREATE TABLE participacoes (
    jogador_id INT,
    campeonato_id INT,
    PRIMARY KEY (jogador_id, campeonato_id),
    CONSTRAINT fk_jogador FOREIGN KEY (jogador_id) REFERENCES jogadores(id),
    CONSTRAINT fk_campeonato FOREIGN KEY (campeonato_id) REFERENCES campeonatos(id)
);


INSERT INTO jogadores (id, nome) VALUES 
(1, 'Jogador Alpha'),
(2, 'Jogador Bravo'),
(3, 'Jogador Charlie'),
(4, 'Jogador Delta');

INSERT INTO campeonatos (id, nome, tier) VALUES 
(101, 'Global Championship 2026', 'Tier 1'),
(102, 'Major League Spring', 'Tier 1'),
(103, 'Challenger Series', 'Tier 2'),
(104, 'Open Amateur Cup', 'Tier 3');

INSERT INTO participacoes (jogador_id, campeonato_id) VALUES (1, 101);
INSERT INTO participacoes (jogador_id, campeonato_id) VALUES (1, 103);

-- Jogador Bravo participou apenas de Tier 2 e Tier 3 (NÃO jogou Tier 1)
INSERT INTO participacoes (jogador_id, campeonato_id) VALUES (2, 103);
INSERT INTO participacoes (jogador_id, campeonato_id) VALUES (2, 104);

-- Jogador Charlie participou de Tier 1 (102)
INSERT INTO participacoes (jogador_id, campeonato_id) VALUES (3, 102);


SELECT 
    j.id AS jogador_id,
    j.nome AS nome_jogador
FROM 
    jogadores j
WHERE 
    j.id NOT IN (
        SELECT DISTINCT p.jogador_id
        FROM participacoes p
        JOIN campeonatos c ON p.campeonato_id = c.id
        WHERE c.tier = 'Tier 1'
    )
ORDER BY 
    j.nome;
