CREATE TABLE estatistica (
    id_estatistica INT AUTO_INCREMENT PRIMARY KEY,
    id_partida INT NOT NULL,
    id_equipe INT NOT NULL,
    id_jogador INT,
    nome_metrica VARCHAR(100) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_estatistica_partida FOREIGN KEY (id_partida) REFERENCES Partida(id_partida),
    CONSTRAINT fk_estatistica_equipe FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe),
    CONSTRAINT fk_estatistica_jogador FOREIGN KEY (id_jogador) REFERENCES Jogador(id_jogador)
);
