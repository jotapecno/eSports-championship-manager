CREATE TABLE Resultado (
    id_resultado INT AUTO_INCREMENT PRIMARY KEY,
    id_partida INT NOT NULL UNIQUE, 
    id_equipe_vencedora INT,
    pontuacao_equipe_A INT DEFAULT 0,
    pontuacao_equipe_B INT DEFAULT 0,
    duracao_segundos INT,
    observacoes TEXT,
    CONSTRAINT fk_resultado_partida FOREIGN KEY (id_partida) REFERENCES Partida(id_partida),
    CONSTRAINT fk_resultado_equipe_vencedora FOREIGN KEY (id_equipe_vencedora) REFERENCES Equipe(id_equipe)
);
