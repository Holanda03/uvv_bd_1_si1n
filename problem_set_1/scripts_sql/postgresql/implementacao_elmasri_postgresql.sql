/* CRIANDO MEU USUÁRIO */
CREATE USER carlos_abraao WITH 
 password '123456'
 login
 createdb;

 
/* FAZER LOGIN COM O NOVO USUÁRIO, DEPOIS EXECUTE OS COMANDOS ABAIXO */

/* criando o banco de dados */
CREATE DATABASE uvv WITH
 OWNER = carlos_abraao
 TEMPLATE = template0
 ENCODING = 'utf8'
 LC_COLLATE = 'pt_BR.UTF-8'
 LC_CTYPE = 'pt_BR.UTF-8'
 ALLOW_CONNECTIONS = true;


/* FAZER LOGIN OUTRA VEZ, ALTERANDO A DATABASE ATIVA, DEPOIS EXECUTE OS COMANDOS ABAIXO */

/* criação do schema */
CREATE SCHEMA elmasri
 AUTHORIZATION carlos_abraao;

/* alterando o schema */
SET SEARCH_PATH TO elmasri, "$user", public;

/* alterando o schema PERMANENTEMENTE */
ALTER USER carlos_abraao
 SET SEARCH_PATH TO elmasri, "$user", public;


/* CRIANDO AS TABELAS DO PROJETO */

/* tabela referente aos funcionarios */
CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(30),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT funcionario_pk PRIMARY KEY (cpf)
);

/* comentários da tabela funcionario */
COMMENT ON TABLE elmasri.funcionario IS 'Tabela que armazena as informações dos funcionários.';

COMMENT ON COLUMN elmasri.funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';

COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';

COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'Inicial do nome do meio.';

COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'Sobrenome do funcionário.';

COMMENT ON COLUMN elmasri.funcionario.endereco IS 'Endereço do funcionário.';

COMMENT ON COLUMN elmasri.funcionario.sexo IS 'Sexo do funcionário.';

COMMENT ON COLUMN elmasri.funcionario.salario IS 'Salário do funcionário.';

COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).';

COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'Número do departamento do funcionário.';

/* tabela referente aos dependentes dos funcionarios */
CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT dependente_pk PRIMARY KEY (cpf_funcionario, nome_dependente)
);

/* comentários da tabela dependente */
COMMENT ON TABLE elmasri.dependente IS 'Tabela que armazena as informações dos dependentes dos funcionários.';

COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';

COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';

COMMENT ON COLUMN elmasri.dependente.sexo IS 'Sexo do dependente.';

COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';

COMMENT ON COLUMN elmasri.dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';

/* tabela dos departamentos onde os funcionarios trabalham */
CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT departamento_pk PRIMARY KEY (numero_departamento)
);

/* comentários da tabela departamento */
COMMENT ON TABLE elmasri.departamento IS 'Tabela que armazena as informações dos departamentos.';

COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'Numero do departamento. É a PK desta tabela.';

COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';

COMMENT ON COLUMN elmasri.departamento.cpf_gerente IS 'CPF do gerente do departamento. E uma FK para a tabela funcionários.';

COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'Data do início do gerente no departamento.';

/* criando a AK referente a tabela de departamentos */
CREATE UNIQUE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento );

/* tabela dos projetos */
 CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT projeto_pk PRIMARY KEY (numero_projeto)
);

/* comentários da tabela projeto */
COMMENT ON TABLE elmasri.projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';

COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'Número do projeto. É a PK desta tabela.';

COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';

COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'Localização do projeto.';

COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'Número do departamento. É uma FK para a tabela departamento.';

/* criando a AK referente a tabela de projetos */
CREATE UNIQUE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto );

/* tabela referente onde cada funcionario trabalha */
CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) NOT NULL,
                CONSTRAINT trabalha_em_pk PRIMARY KEY (cpf_funcionario, numero_projeto)
);

/* comentários da tabela trabalha_em */
COMMENT ON TABLE elmasri.trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';

COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';

COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';

COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';

/* tabela das localizacoes dos departamentos */
CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT localizacoes_departamento_pk PRIMARY KEY (numero_departamento, local)
);

/* comentários da tabela localizacoes_departamento */
COMMENT ON TABLE elmasri.localizacoes_departamento IS 'Tabela que armazena as possíveis localizações dos departamentos.';

COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';

COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'Localização do departamento. Faz parte da PK desta tabela.';


/* CRIANDO AS CHAVES ESTRANGEIRAS DAS TABELAS */

ALTER TABLE elmasri.departamento
 ADD FOREIGN KEY (cpf_gerente)
 REFERENCES elmasri.funcionario (cpf);

ALTER TABLE elmasri.funcionario
 ADD FOREIGN KEY (cpf_supervisor)
 REFERENCES elmasri.funcionario (cpf);

ALTER TABLE elmasri.dependente
 ADD FOREIGN KEY (cpf_funcionario)
 REFERENCES elmasri.funcionario (cpf);

ALTER TABLE elmasri.trabalha_em
 ADD FOREIGN KEY (cpf_funcionario)
 REFERENCES elmasri.funcionario (cpf);
 
ALTER TABLE elmasri.localizacoes_departamento
 ADD FOREIGN KEY (numero_departamento)
 REFERENCES elmasri.departamento (numero_departamento);

ALTER TABLE elmasri.projeto
 ADD FOREIGN KEY (numero_departamento)
 REFERENCES elmasri.departamento (numero_departamento);

ALTER TABLE elmasri.trabalha_em
 ADD FOREIGN KEY (numero_projeto)
 REFERENCES elmasri.projeto (numero_projeto);


/* ADICIONANDO CONSTRAINTS EXTRAS */
ALTER TABLE elmasri.funcionario
 ADD CONSTRAINT salario_check CHECK (salario >= 0);

ALTER TABLE elmasri.funcionario
 ADD CONSTRAINT sexo_check CHECK (sexo LIKE 'M' or sexo LIKE 'F');

ALTER TABLE elmasri.dependente
 ADD CONSTRAINT sexo2_check CHECK (sexo LIKE 'M' or sexo LIKE 'F');

ALTER TABLE elmasri.trabalha_em
 ADD CONSTRAINT horas_check CHECK (horas >= 0);