CREATE TABLE organizacao (
    id_organizacao SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE,
    email_contato VARCHAR(100),
    data_fundacao DATE
);
