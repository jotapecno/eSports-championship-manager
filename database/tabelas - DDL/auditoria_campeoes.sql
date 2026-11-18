DROP TABLE IF EXISTS auditoria_campeoes;

CREATE TABLE auditoria_campeoes(
	id SERIAL PRIMARY KEY,
	equipe_id INT NOT NULL,
	data_liberacao_premiacao DATE NOT NULL,
	status_liberacao VARCHAR(30) NOT NULL,
	valor_transferencia NUMERIC(12,2) NOT NULL,
	
	CONSTRAINT fk_equipe_id
	FOREIGN KEY (equipe_id)
	REFERENCES equipe(id)
);
