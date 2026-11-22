-- ============================================================
-- 7ª INSERTS: jogador
-- Descrição: Cadastro dos atletas do campeonato.
-- Dependências de dados: IDs válidos de equipe.
-- ============================================================
INSERT INTO jogador (id, nome, cpf, email, data_nascimento, pais, cidade, funcao_preferida, numero_mpvs, posicao_ranking, suspenso) VALUES
(7, 'Guilherme Costa', '78901234567', 'guilherme.costa@email.com', '2000-12-25', 'Portugal', 'Lisboa', 'Atirador/ADC', 1, 67, false),
(8, 'Gustavo Rodrigues', '89012345678', 'gustavo.rodrigues@email.com', '1997-02-18', 'Alemanha', 'Berlim', 'Defensor', 3, 34, false),
(9, 'Felipe Almeida', '90123456789', 'felipe.almeida@email.com', '2002-06-08', 'Brasil', 'Salvador', 'Entry Fragger', 0, 120, true),
(10, 'Vitor Nascimento', '01234567890', 'vitor.nascimento@email.com', '1996-08-24', 'Itália', 'Roma', 'Mid Laner', 7, 9, false),
(11, 'Rafael Ribeiro', '11234567891', 'rafael.ribeiro@email.com', '2001-04-03', 'Chile', 'Santiago', 'Meio-campo', 2, 50, false),
(12, 'Bruno Carvalho', '22345678912', 'bruno.carvalho@email.com', '1994-10-10', 'Espanha', 'Madrid', 'Suporte', 6, 15, false),
(19, 'Caio Pinheiro', '99012345678', 'caio.pinheiro@email.com', '2002-03-27', 'Itália', 'Milão', 'Suporte', 2, 58, false),
(20, 'Daniel Fonseca', '00123456789', 'daniel.fonseca@email.com', '1996-12-02', 'Peru', 'Lima', 'IGL', 6, 18, false),
(21, 'Matheus Ramos', '12435678901', 'matheus.ramos@email.com', '2004-06-14', 'Brasil', 'São Paulo', 'Mid Laner', 0, 95, true),
(22, 'Eduardo Vieira', '23546789012', 'eduardo.vieira@email.com', '2001-08-09', 'Alemanha', 'Munique', 'Meio-campo', 1, 80, false),
(23, 'Diego Marques', '34657890123', 'diego.marques@email.com', '1995-04-16', 'Espanha', 'Barcelona', 'Entry Fragger', 4, 31, false),
(24, 'Samuel Santana', '45768901234', 'samuel.santana@email.com', '1993-10-20', 'Canadá', 'Toronto', 'Atirador/ADC', 15, 2, false),
(25, 'Otavio Teixeira', '56879012345', 'otavio.teixeira@email.com', '2002-11-11', 'Portugal', 'Lisboa', 'Atacante', 2, 62, false),
(29, 'Alexandre Franco', '90213456789', 'alexandre.franco@email.com', '1999-01-01', 'Itália', 'Roma', 'Defensor', 5, 25, false),
(4, 'Pedro Souza', '45678901234', 'pedro.souza@email.com', '2003-01-30', 'Brasil', 'São Paulo', 'Atacante', 0, 89, false),
(30, 'Douglas Souza', '01324567890', 'douglas.souza@email.com', '1997-04-30', 'França', 'Paris', 'Lurker', 4, 33, false),
(14, 'Thiago Melo', '44567891234', 'thiago.melo@email.com', '1998-11-15', 'França', 'Paris', 'Sniper', 5, 28, false),
(3, 'Mateus Oliveira', '34567890123', 'mateus.oliveira@email.com', '1995-11-05', 'Espanha', 'Madrid', 'Jungler', 8, 3, false),
(17, 'Rodrigo Rocha', '77891234567', 'rodrigo.rocha@email.com', '2000-05-22', 'Argentina', 'Buenos Aires', 'Lurker', 3, 42, false),
(28, 'Igor Guimarães', '89102345678', 'igor.guimaraes@email.com', '1998-07-25', 'Chile', 'Santiago', 'Suporte', 3, 40, false),
(13, 'Arthur Araujo', '33456789123', 'arthur.araujo@email.com', '2005-02-28', 'Uruguai', 'Montevidéu', 'Top Laner', 1, 75, false),
(1, 'Gabriel Silva', '12345678901', 'gabriel.silva@email.com', '1998-03-14', 'Brasil', 'São Paulo', 'Entry Fragger', 5, 12, false),
(5, 'João Pereira', '56789012345', 'joao.pereira@email.com', '1999-05-17', 'Argentina', 'Buenos Aires', 'Suporte', 4, 21, false),
(18, 'Murilo Barbosa', '88912345678', 'murilo.barbosa@email.com', '1997-01-11', 'Portugal', 'Porto', 'Defensor', 9, 6, false),
(2, 'Lucas Santos', '23456789012', 'lucas.santos@email.com', '2001-07-22', 'Portugal', 'Lisboa', 'Sniper', 2, 45, false),
(16, 'Leonardo Martins', '66789123456', 'leonardo.martins@email.com', '1999-09-19', 'Canadá', 'Toronto', 'Jungler', 4, 39, false),
(15, 'Nicolas Gomes', '55678912345', 'nicolas.gomes@email.com', '2003-07-07', 'Brasil', 'Rio de Janeiro', 'Atacante', 0, 112, false),
(6, 'Enzo Lima', '67890123456', 'enzo.lima@email.com', '2004-09-12', 'França', 'Paris', 'IGL', 12, 1, false),
(26, 'Yago Machado', '67980123456', 'yago.machado@email.com', '2000-02-05', 'Colômbia', 'Bogotá', 'Sniper', 8, 5, false),
(27, 'Danilo Medeiros', '78091234567', 'danilo.medeiros@email.com', '2005-05-19', 'Brasil', 'Rio de Janeiro', 'Top Laner', 0, 105, false);
