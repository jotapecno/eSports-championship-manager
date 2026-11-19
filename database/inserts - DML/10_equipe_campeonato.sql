-- ============================================================
-- 9ª INSERTS: equipe_campeonato
-- Descrição: Registro de confirmação de times inscritos nos torneios.
-- Dependências de dados: IDs válidos de equipe e campeonato.
-- ============================================================
INSERT INTO equipe_campeonato (id, campeonato_id, equipe_id, status_participacao, posicao_ranking) VALUES
(1, 1, 5, 'Ativa', 8),
(2, 1, 20, 'Ativa', 9),
(3, 1, 12, 'Eliminada', 4),
(4, 2, 26, 'Ativa', 4),
(5, 2, 11, 'Ativa', 7),
(6, 2, 3, 'Eliminada', 5),
(7, 3, 17, 'Ativa', 9),
(8, 3, 2, 'Ativa', 3),
(9, 3, 24, 'Eliminada', 8),
(10, 4, 8, 'Ativa', 10),
(11, 4, 23, 'Ativa', 9),
(12, 4, 15, 'Eliminada', 2),
(13, 5, 29, 'Ativa', 9),
(14, 5, 14, 'Ativa', 4),
(15, 5, 6, 'Eliminada', 6),
(16, 6, 20, 'Ativa', 7),
(17, 6, 5, 'Ativa', 10),
(18, 6, 27, 'Eliminada', 3),
(19, 7, 11, 'Ativa', 4),
(20, 7, 26, 'Ativa', 5),
(21, 7, 18, 'Eliminada', 1),
(22, 8, 2, 'Ativa', 5),
(23, 8, 17, 'Ativa', 3),
(24, 8, 9, 'Eliminada', 6),
(25, 9, 23, 'Ativa', 8),
(26, 9, 8, 'Ativa', 7),
(27, 9, 30, 'Eliminada', 9),
(28, 10, 14, 'Ativa', 3),
(29, 10, 29, 'Ativa', 10),
(30, 10, 21, 'Desistente',9);
