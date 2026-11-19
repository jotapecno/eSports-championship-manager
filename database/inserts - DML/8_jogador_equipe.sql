INSERT INTO jogador_equipe (jogador_id, equipe_id, data_entrada) VALUES
-- Equipe 1 (Alpha Wolves)
(1, 1, '2023-02-10'),
(2, 1, '2023-05-18'),
(3, 1, '2022-11-03'),
(4, 1, '2024-01-15'),
(5, 1, '2023-08-22'),
(6, 1, '2024-03-09'),

-- Equipe 2 (Beta Bears)
(7, 2, '2023-01-20'),
(8, 2, '2022-09-14'),
(9, 2, '2024-02-05'),
(10, 2, '2022-06-30'),
(11, 2, '2023-07-11'),
(12, 2, '2022-10-25'),

-- Equipe 3 (Gamma Hawks)
(13, 3, '2024-04-18'),
(14, 3, '2023-03-07'),
(15, 3, '2024-06-12'),
(16, 3, '2023-09-29'),
(17, 3, '2023-12-01'),
(18, 3, '2022-08-16'),

-- Equipe 4 (Delta Foxes)
(19, 4, '2023-04-21'),
(20, 4, '2022-12-09'),
(21, 4, '2024-05-27'),
(22, 4, '2023-10-13'),
(23, 4, '2022-07-05'),
(24, 4, '2022-03-19'),

-- Equipe 5 (Epsilon Eagles)
(25, 5, '2024-01-30'),
(26, 5, '2023-02-24'),
(27, 5, '2024-07-08'),
(28, 5, '2023-06-15'),
(29, 5, '2022-11-22'),
(30, 5, '2023-09-04');

  INSERT INTO jogador_equipe (jogador_id, equipe_id, data_entrada,data_saida) VALUES
-- Jogadores com uma transferência
(1,  8,  '2021-06-01', '2023-02-09'),  -- Theta Tigers -> Alpha Wolves
(3,  12, '2020-09-15', '2022-11-02'),  -- Mu Dolphins -> Alpha Wolves
(5,  6,  '2022-01-10', '2023-08-21'),  -- Zeta Zebras -> Alpha Wolves
(7,  15, '2021-03-20', '2023-01-19'),  -- Omicron Rhinos -> Beta Bears
(12, 20, '2020-02-18', '2022-10-24'),  -- Upsilon Vipers -> Beta Bears
(14, 9,  '2021-08-12', '2023-03-06'),  -- Iota Sharks -> Gamma Hawks
(16, 22, '2022-02-01', '2023-09-28'),  -- Chi Coyotes -> Gamma Hawks
(20, 25, '2020-05-30', '2022-12-08'),  -- Cyber Knights -> Delta Foxes
(23, 11, '2019-07-14', '2022-07-04'),  -- Lambda Cobras -> Delta Foxes
(26, 18, '2021-10-09', '2023-02-23'),  -- Sigma Bulls -> Epsilon Eagles
(29, 24, '2021-04-25', '2022-11-21'),  -- Omega Dragons -> Epsilon Eagles

-- Jogador com duas transferências (Vitor Nascimento, id 10)
(10, 17, '2019-11-05', '2021-05-31'),  -- Rho Ravens
(10, 21, '2021-06-01', '2022-06-29');  -- Phi Jaguars -> depois Beta Bears (2022-06-30)
