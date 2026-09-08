INSERT INTO jogador (id, equipe_id, nome, cpf, email, data_nascimento, endereco, numero_mpvs, posicao_ranking) VALUES
-- Jogadores da Equipe 1 (Alpha Wolves)
(1, 1, 'Gabriel Silva', '12345678901', 'gabriel.silva@email.com', '1998-03-14', 'Rua das Flores, 123 - SP', 5, 12),
(2, 1, 'Lucas Santos', '23456789012', 'lucas.santos@email.com', '2001-07-22', 'Av. Central, 456 - RJ', 2, 45),
(3, 1, 'Mateus Oliveira', '34567890123', 'mateus.oliveira@email.com', '1995-11-05', 'Rua Bahia, 789 - MG', 8, 3),
(4, 1, 'Pedro Souza', '45678901234', 'pedro.souza@email.com', '2003-01-30', 'Alameda dos Anjos, 12 - RS', 0, 89),
(5, 1, 'João Pereira', '56789012345', 'joao.pereira@email.com', '1999-05-17', 'Rua do Comércio, 34 - PR', 4, 21),
(6, 1, 'Enzo Lima', '67890123456', 'enzo.lima@email.com', '2004-09-12', 'Av. Brasil, 1010 - SC', 12, 1),

-- Jogadores da Equipe 2 (Beta Bears)
(7, 2, 'Guilherme Costa', '78901234567', 'guilherme.costa@email.com', '2000-12-25', 'Rua Amazonas, 55 - GO', 1, 67),
(8, 2, 'Gustavo Rodrigues', '89012345678', 'gustavo.rodrigues@email.com', '1997-02-18', 'Travessa da Paz, 88 - DF', 3, 34),
(9, 2, 'Felipe Almeida', '90123456789', 'felipe.almeida@email.com', '2002-06-08', 'Rua das Palmeiras, 77 - BA', 0, 120),
(10, 2, 'Vitor Nascimento', '01234567890', 'vitor.nascimento@email.com', '1996-08-24', 'Av. Paulista, 1500 - SP', 7, 9),
(11, 2, 'Rafael Ribeiro', '11234567891', 'rafael.ribeiro@email.com', '2001-04-03', 'Rua Sergipe, 404 - SE', 2, 50),
(12, 2, 'Bruno Carvalho', '22345678912', 'bruno.carvalho@email.com', '1994-10-10', 'Rua Ceará, 303 - CE', 6, 15),

-- Jogadores da Equipe 3 (Gamma Hawks)
(13, 3, 'Arthur Araujo', '33456789123', 'arthur.araujo@email.com', '2005-02-28', 'Av. Beira Mar, 99 - PE', 1, 75),
(14, 3, 'Thiago Melo', '44567891234', 'thiago.melo@email.com', '1998-11-15', 'Rua Piauí, 122 - PI', 5, 28),
(15, 3, 'Nicolas Gomes', '55678912345', 'nicolas.gomes@email.com', '2003-07-07', 'Rua das Acácias, 90 - MA', 0, 112),
(16, 3, 'Leonardo Martins', '66789123456', 'leonardo.martins@email.com', '1999-09-19', 'Av. Goiás, 450 - TO', 4, 39),
(17, 3, 'Rodrigo Rocha', '77891234567', 'rodrigo.rocha@email.com', '2000-05-22', 'Rua Acre, 15 - AC', 3, 42),
(18, 3, 'Murilo Barbosa', '88912345678', 'murilo.barbosa@email.com', '1997-01-11', 'Av. Getúlio Vargas, 60 - AM', 9, 6),

-- Jogadores da Equipe 4 (Delta Foxes)
(19, 4, 'Caio Pinheiro', '99012345678', 'caio.pinheiro@email.com', '2002-03-27', 'Rua Pará, 715 - PA', 2, 58),
(20, 4, 'Daniel Fonseca', '00123456789', 'daniel.fonseca@email.com', '1996-12-02', 'Rua Chile, 88 - RN', 6, 18),
(21, 4, 'Matheus Ramos', '12435678901', 'matheus.ramos@email.com', '2004-06-14', 'Av. Rio Branco, 200 - RJ', 0, 95),
(22, 4, 'Eduardo Vieira', '23546789012', 'eduardo.vieira@email.com', '2001-08-09', 'Rua Tiradentes, 44 - MG', 1, 80),
(23, 4, 'Diego Marques', '34657890123', 'diego.marques@email.com', '1995-04-16', 'Rua da Aurora, 310 - PE', 4, 31),
(24, 4, 'Samuel Santana', '45768901234', 'samuel.santana@email.com', '1993-10-20', 'Av. Paralela, 500 - BA', 15, 2),

-- Jogadores da Equipe 5 (Epsilon Eagles)
(25, 5, 'Otavio Teixeira', '56879012345', 'otavio.teixeira@email.com', '2002-11-11', 'Rua das Oliveiras, 19 - ES', 2, 62),
(26, 5, 'Yago Machado', '67980123456', 'yago.machado@email.com', '2000-02-05', 'Av. Bento Gonçalves, 80 - RS', 8, 5),
(27, 5, 'Danilo Medeiros', '78091234567', 'danilo.medeiros@email.com', '2005-05-19', 'Rua Natal, 23 - RN', 0, 105),
(28, 5, 'Igor Guimarães', '89102345678', 'igor.guimaraes@email.com', '1998-07-25', 'Rua Curitiba, 77 - PR', 3, 40),
(29, 5, 'Alexandre Franco', '90213456789', 'alexandre.franco@email.com', '1999-01-01', 'Av. Afonso Pena, 120 - MS', 5, 25),
(30, 5, 'Douglas Souza', '01324567890', 'douglas.souza@email.com', '1997-04-30', 'Rua Cuiabá, 88 - MT', 4, 33);

-- Sincroniza a sequência automática com o número do próximo ID livre
ALTER SEQUENCE jogador_id_seq RESTART WITH 31;
