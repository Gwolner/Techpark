# Estacionamento Inteligente <img src="img/mysql.png" width="80" height="40" align="right">

Atividade da disciplina Análise e Projeto de Sistemas em que  foi proposto pela profª [Aida Araújo Ferreira](http://buscatextual.cnpq.br/buscatextual/visualizacv.do?id=K4776702E0) uma situação-problema, bem como sua solução, afim de que sejam elaborados o diagrama UML de Caso de Uso, o Modelo Relacional e o BD MySQL.

## As ferramentas 

Para geração do diagrama UML foi utilziado o [Astah UML](http://astah.net/) e para o Modelo Relacional e código do BD foram utilizados o [Workbenck 8.0 CE](https://dev.mysql.com/downloads/workbench/).

## O problema dos estacionamentos

Atualmente, encontrar uma vaga de estacionamento em centros urbanos é um grande problema devido a aglomeração humana e, consequentemente, a quantidade de automóveis em circulação. Mesmo em grandes centros, onde existem bolsões de estacionamento, não existe sinalização clara e eficaz dos locais onde se encontram as vagas fisicamente disponíveis em muitos estacionamentos. A solução atual são luzes indicativas (verdes/vermelhas) que, internas ao estacionamento, caracterizam respectivamente, os locais das vagas de estacionamento livres ou ocupadas. Esse modelo não permite que os usuários tenham noção antecipada das vagas disponíveis antes de entrarem fisicamente com seus automóveis nos mesmos. Também não existem sistemas para o auxílio na busca por vagas disponíveis. Um motorista pode chegar a gastar vários minutos no esforço de encontrar um local para estacionar seu automóvel.

## A solução - Sistema de Estacionamento Inteligente

Para resolver este problema, surgiu a ideia de criar-se um sistema que possa facilitar a vida dos motoristas: As informações sobre o estado da vaga serão enviadas através de uma rede sem fio a um servidor, que faz o processamento das informações e armazena as mesmas em um banco de dados para disponibilização aos usuários através de um sistema de informação geográfica (SIG). O SIG será responsável pelo gerenciamento da rede de sensores de vagas disponíveis para visualização na WEB ou em dispositivos móveis da configuração espacial da disponibilidade de vagas no estacionamento.

<img src="fig/figura_estacionamento.JPG" width="800" height="400" align="center">

## Diagrama de Caso de Uso

### Atores

* Usuário 
* Sistema 
* GPS

### Casos de uso

* Realizar cadastro
* Realizar login
* Selecionar estacionamento
* Localizar vaga
* Consultar horário de funcionamento
* Reservar vaga
* Realizar pagamento
* Gerenciar controlador
* Registrar movimentação


<img src="diagrama_uml/uc_diagram.JPG" width="795" height="458" align="center">

## Modelo Relacional

<img src="modelo_relacional/estacionamento_inteligente.png" width="795" height="458" align="center">

## Script MySQL

Criação do BD.
```mysql
CREATE DATABASE estacionamento_inteligente;
```

Declaração de uso do BD a ser manipulado.

```mysql
USE estacionamento_inteligente;
/*Ou clique duas vezes sobre o nome do BD.*/
```

Criação das tabelas com seus respectivos campos.

```mysql
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
```

Exclusão do BD
```mysql
DROP DATABASE estacionamento_inteligente;
```
