CREATE TABLE organizacao (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE,
    email_contato VARCHAR(100),
    data_fundacao DATE
);
