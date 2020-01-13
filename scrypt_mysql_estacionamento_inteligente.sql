CREATE DATABASE estacionamento_inteligente;

USE estacionamento_inteligente;


CREATE TABLE status_sensor(
id_status_sensor INT,
status VARCHAR(45) NOT NULL,
PRIMARY KEY(id_status_sensor)
);


CREATE TABLE sensor(
id_sensor INT,
numero INT NOT NULL,
modelo VARCHAR(45) NOT NULL,
fabricante VARCHAR(45) NOT NULL,
id_status_sensor INT,
PRIMARY KEY(id_sensor),
FOREIGN KEY (id_status_sensor) REFERENCES status_sensor (id_status_sensor)
);



CREATE TABLE estado(
id_estado INT,
sigla_estado VARCHAR(2) NOT NULL,
PRIMARY KEY(id_estado)
);

CREATE TABLE endereco(
id_endereco INT,
rua VARCHAR(45) NOT NULL,
numero VARCHAR(45) NOT NULL,
bairo VARCHAR(45) NOT NULL,
cidade VARCHAR(45) NOT NULL,
id_estado INT,
PRIMARY KEY(id_endereco),
FOREIGN KEY (id_estado) REFERENCES estado (id_estado)
);


CREATE TABLE estacionamento(
id_estacionamento INT,
quantidade_vagas INT NOT NULL,
quantidade_controladores INT NOT NULL,
id_endereco INT,
PRIMARY KEY(id_estacionamento),
FOREIGN KEY (id_endereco) REFERENCES endereco (id_endereco)
);


CREATE TABLE controlador(
id_controlador INT,
numero INT NOT NULL,
modelo VARCHAR(45) NOT NULL,
fabricante VARCHAR(45) NOT NULL,
id_estacionamento INT,
PRIMARY KEY(id_controlador),
FOREIGN KEY (id_estacionamento) REFERENCES estacionamento (id_estacionamento)
);


CREATE TABLE vaga(
id_vaga INT,
letra VARCHAR(8) NOT NULL,
numero INT NOT NULL,
id_controlador INT,
id_sensor INT,
PRIMARY KEY(id_vaga),
FOREIGN KEY (id_controlador) REFERENCES controlador (id_controlador),
FOREIGN KEY (id_sensor) REFERENCES sensor (id_sensor)
);