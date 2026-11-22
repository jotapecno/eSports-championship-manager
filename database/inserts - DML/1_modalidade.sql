-- ============================================================
-- 1ª INSERTS: modalidade
-- Descrição: Carga inicial dos esportes disponíveis na plataforma.
-- Dependências de dados: Nenhuma.
-- ============================================================
INSERT INTO modalidade (id, nome, genero, numero_jogadores, descricao, ativo) VALUES
(1, 'League of Legends', 'MOBA', 5, 'Jogo competitivo de estratégia em equipes.', true),
(2, 'Valorant', 'FPS', 5, 'Jogo de tiro tático competitivo.', true),
(3, 'Counter-Strike 2', 'FPS', 5, 'Jogo de tiro tático em equipes.', true),
(4, 'Dota 2', 'MOBA', 5, 'Jogo de estratégia e batalha em equipes.', true),
(5, 'Rocket League', 'Esporte Eletrônico', 3, 'Competição de futebol utilizando veículos.', true),
(6, 'Rainbow Six Siege', 'FPS', 5, 'Jogo de tiro tático focado em operações de equipes.', true);
