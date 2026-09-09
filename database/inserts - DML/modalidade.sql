INSERT INTO modalidade
(id, nome, genero, numero_jogadores, descricao, ativo)
VALUES
(1, 'League of Legends', 'MOBA', 5, 'Jogo competitivo de estratégia em equipes.', TRUE),
(2, 'Valorant', 'FPS', 5, 'Jogo de tiro tático competitivo.', TRUE),
(3, 'Counter-Strike 2', 'FPS', 5, 'Jogo de tiro tático em equipes.', TRUE),
(4, 'Dota 2', 'MOBA', 5, 'Jogo de estratégia e batalha em equipes.', TRUE),
(5, 'Rocket League', 'Esporte Eletrônico', 3, 'Competição de futebol utilizando veículos.', TRUE),
(6, 'Rainbow Six Siege', 'FPS', 5, 'Jogo de tiro tático focado em operações de equipes.', TRUE);

ALTER SEQUENCE modalidade_id_seq RESTART WITH 7;
