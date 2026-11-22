-- ============================================================
-- 1ª INSERTS: modalidade
-- Descrição: Carga inicial dos esportes disponíveis na plataforma.
-- Dependências de dados: Nenhuma.
-- ============================================================
INSERT INTO public.modalidade (id, nome, genero, numero_jogadores, descricao, ativo) VALUES (1, 'League of Legends', 'MOBA', 5, 'Jogo competitivo de estratégia em equipes.', true);
INSERT INTO public.modalidade (id, nome, genero, numero_jogadores, descricao, ativo) VALUES (2, 'Valorant', 'FPS', 5, 'Jogo de tiro tático competitivo.', true);
INSERT INTO public.modalidade (id, nome, genero, numero_jogadores, descricao, ativo) VALUES (3, 'Counter-Strike 2', 'FPS', 5, 'Jogo de tiro tático em equipes.', true);
INSERT INTO public.modalidade (id, nome, genero, numero_jogadores, descricao, ativo) VALUES (4, 'Dota 2', 'MOBA', 5, 'Jogo de estratégia e batalha em equipes.', true);
INSERT INTO public.modalidade (id, nome, genero, numero_jogadores, descricao, ativo) VALUES (5, 'Rocket League', 'Esporte Eletrônico', 3, 'Competição de futebol utilizando veículos.', true);
INSERT INTO public.modalidade (id, nome, genero, numero_jogadores, descricao, ativo) VALUES (6, 'Rainbow Six Siege', 'FPS', 5, 'Jogo de tiro tático focado em operações de equipes.', true);
