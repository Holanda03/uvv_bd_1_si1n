/* INSENRINDO DADOS NAS TABELAS */

/* dados para tabela funcionario */
INSERT INTO
 funcionario (cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
 VALUES
	("88866555576", "Jorge", "E", "Brito", "1937-11-10", "RuaDoHorto,35,São Paulo,SP", "M", 55000.00, "88866555576", 1),
    ("33344555587", "Fernando", "T", "Wong", "1955-12-08", "RuaDaLapa,34,São Paulo,SP", "M", 40000.00, "88866555576", 5),
    ("98765432168", "Jennifer", "S", "Souza", "1941-06-20", "Av.ArthurDeLima,54,Santo André", "F", 43000.00, "88866555576", 4),
    ("99988777767", "Alice", "J", "Zelaya", "1968-01-19", "RuaSouzaLima,35,Curitiba,PR", "F", 25000.00, "98765432168", 4),
    ("98798798733", "André", "V", "Pereira", "1969-03-29", "RuaTimbira,35,São Paulo,SP", "M", 25000.00, "98765432168", 4),
    ("12345678966", "João", "B", "Silva", "1965-01-09", "RuaDasFlores,751,São Paulo,SP", "M", 30000.00, "33344555587", 5),
    ("66688444476", "Ronaldo", "K", "Lima", "1962-09-15", "RuaRebouças,65,Piracicaba,SP", "M", 38000.00, "33344555587", 5),
    ("45345345376", "Joice", "A", "Leite", "1972-07-31", "Av.LucasOber,74,São Paulo,SP", "F", 25000.00, "33344555587", 5);

/* dados para a tabela departamento */
INSERT INTO
 departamento (numero_departamento, nome_departamento, cpf_gerente, data_inicio_gerente)
 VALUES
	(5, "Pesquisa", "33344555587", "1988-05-22"),
	(4, "Administração", "98765432168", "1995-01-01"),
	(1, "Matriz", "88866555576", "1981-06-19");

/* dados para a tabela localizacoes_departamento */	
INSERT INTO
 localizacoes_departamento (numero_departamento, local)
 VALUES 
	(1, "São Paulo"),
    (4, "Mauá"),
    (5, "Santo André"),
    (5, "Itu"),
    (5, "São Paulo");

/* dados para tabela projeto */
INSERT INTO
 projeto (numero_projeto, nome_projeto, local_projeto, numero_departamento)
 VALUES 
	(1, "ProdutoX", "Santo André", 5),
    (2, "ProdutoY", "Itu", 5),
    (3, "ProdutoZ", "São Paulo", 5),
    (10, "Informatização", "Mauá", 4),
    (20, "Reorganização", "São Paulo", 1),
    (30, "Novosbenefícios", "Mauá", 4);

/* dados para tabela dependente */
INSERT INTO
 dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
 VALUES
	("33344555587", "Alicia", "F", "1986-04-05", "Filha"),
    ("33344555587", "Tiago", "M", "1983-10-25", "Filho"),
    ("33344555587", "Janaína", "F", "1958-05-03", "Esposa"),
    ("98765432168", "Antonio", "M", "1942-02-28", "Marido"),
    ("12345678966", "Michael", "M", "1988-01-04", "Filho"),
    ("12345678966", "Alicia", "F", "1988-12-30", "Filha"),
    ("12345678966", "Elizabeth", "F", "1967-05-05", "Esposa");

/* dados para tabela trabalha_em */
INSERT INTO
 trabalha_em (cpf_funcionario, numero_projeto, horas)
 VALUES
	("12345678966", 1, 32.5),
    ("12345678966", 2, 7.5),
    ("66688444476", 3, 40.0),
    ("45345345376", 1, 20.0),
    ("45345345376", 2, 20.0),
    ("33344555587", 2, 10.0),
    ("33344555587", 3, 10.0),
    ("33344555587", 10, 10.0),
    ("33344555587", 20, 10.0),
    ("99988777767", 30, 30.0),
    ("99988777767", 10, 10.0),
    ("98798798733", 10, 35.0),
    ("98798798733", 30, 5.0),
    ("98765432168", 30, 20.0),
    ("98765432168", 20, 15.0),
    ("88866555576", 20, 0);