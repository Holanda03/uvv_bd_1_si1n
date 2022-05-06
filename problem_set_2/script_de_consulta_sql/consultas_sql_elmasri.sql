-- ------------------------------------------------------------------------------------------------------------------------------------------------------------- --
-- PT-BR Esse script foi testado no MySQL 8.0 Command Line. Caso encontre algum erro testando em outro sistema, por favor, teste novamente no MySQL. Obrigado!   --
-- EN    This script was tested on MySQL 8.0 Command Line. If you find any error while executing it on another data base, please, try again on MySQL. Thank you! --
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------- --

/* Questão 1 */
 select AVG(salario) as mediaSalarial, nome_departamento as departamento
    from funcionario as f
    inner join departamento as d on (f.numero_departamento = d.numero_departamento)
    group by nome_departamento;


/* Questão 2 */
select AVG(salario) as mediaSalarial, sexo
    from funcionario
    group by sexo;


/* Questão 3 */
select CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_completo, f.data_nascimento, curdate() as dataAtual, timestampdiff(year, data_nascimento, curdate()) as idade, 
    f.salario, d.nome_departamento
    from funcionario as f
    inner join departamento as d on (f.numero_departamento = d.numero_departamento);


/* Questão 4 */
select CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_completo, f.data_nascimento, curdate() as dataAtual, 
    timestampdiff(year, data_nascimento, curdate()) as idade, f.salario as salario_atual, case
    when f.salario < 35.000 then f.salario + (f.salario * 0.2)
    when f.salario >= 35.000 then f.salario + (f.salario * 0.15)
    end as novo_salario
    from funcionario as f;


/* Questão 5 */    
select d.nome_departamento, case 
    when d.cpf_gerente = 33344555587 then "Fernando"
    when d.cpf_gerente = 88866555576 then "Jorge"
    when d.cpf_gerente = 98765432168 then "Jennifer"
    end as nome_gerente,
    CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_completo, f.salario
    from funcionario as f
    inner join departamento as d on (f.numero_departamento = d.numero_departamento)
    order by d.nome_departamento asc, f.salario desc;


/* Questão 6 */
select CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_completo, dp.nome_departamento, d.nome_dependente, d.parentesco, d.data_nascimento, 
    curdate() as dataAtual, timestampdiff(year, d.data_nascimento, curdate()) as idade_dependente, case
    when d.sexo = "M" then "Masculino"
    when d.sexo = "F" then "Feminino"
    end as sexo
    from funcionario as f
    inner join departamento as dp on (f.numero_departamento = dp.numero_departamento)
    inner join dependente as d on (f.cpf = d.cpf_funcionario);


/* Questão 7 */
select CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_completo, salario, numero_departamento
    from funcionario
    where not exists (
    select *
    from dependente
    where cpf = cpf_funcionario);


/*Questão 8 */
select d.nome_departamento, p.nome_projeto, CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_completo, t.horas
    from funcionario as f
    inner join departamento as d on (f.numero_departamento = d.numero_departamento)
    inner join  projeto as p on (d.numero_departamento = p.numero_departamento)
    inner join trabalha_em as t on (f.cpf = t.cpf_funcionario and t.numero_projeto = p.numero_projeto)
    group by nome_projeto, primeiro_nome, horas
    order by nome_projeto;


/* Questão 9 */
select d.nome_departamento, p.nome_projeto, SUM(t.horas) as horas
    from departamento as d
    inner join projeto as p on (p.numero_departamento = d.numero_departamento)
    inner join trabalha_em as t on (p.numero_projeto = t.numero_projeto)
    group by nome_departamento, nome_projeto;


/* Questão 10 */
 select AVG(salario) as mediaSalarial, nome_departamento as departamento
    from funcionario as f
    inner join departamento as d on (f.numero_departamento = d.numero_departamento)
    group by nome_departamento;


/* Questão 11 */
select CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_completo, p.nome_projeto, t.horas * 50 as valorRecebido
    from funcionario as f
    inner join departamento as d on (f.numero_departamento = d.numero_departamento)
    inner join projeto as p on (p.numero_departamento = d.numero_departamento)
    inner join trabalha_em as t on (f.cpf = t.cpf_funcionario and t.numero_projeto = p.numero_projeto)
    group by primeiro_nome, nome_projeto;


/* Questão 12 */
select CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_completo, d.nome_departamento, p.nome_projeto, t.horas
    from funcionario as f
    inner join departamento as d on (f.numero_departamento = d.numero_departamento)
    inner join projeto as p on (p.numero_departamento = d.numero_departamento)
    inner join trabalha_em as t on (f.cpf = t.cpf_funcionario)
    where t.horas is null or t.horas = 0;


/* Questão 13 */
select CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_completo_func, CONCAT(d.nome_dependente, ' ', f.ultimo_nome) as nome_completo_dep, f.sexo as sexo_func, d.sexo as sexo_dep, curdate() as dataAtual,
    timestampdiff(year, f.data_nascimento, curdate()) as idade_func, timestampdiff(year, d.data_nascimento, curdate()) as idade_dep
    from funcionario as f
    left outer join dependente as d on (f.cpf = d.cpf_funcionario)
    group by nome_completo_func, nome_completo_dep
    order by idade_func desc, idade_func desc;


/* Questão 14 */
select d.nome_departamento, COUNT(*) as total_funcionarios
    from funcionario as f
    inner join departamento as d on (f.numero_departamento = d.numero_departamento)
    group by nome_departamento;


/* Questão 15 */ 
select CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_completo, d.nome_departamento, p.nome_projeto
    from funcionario as f
    inner join departamento as d on (f.numero_departamento = d.numero_departamento)
    inner join projeto as p on (p.numero_departamento = d.numero_departamento)
    left outer join trabalha_em as t on (p.numero_projeto = t.numero_projeto and f.cpf = t.cpf_funcionario)
    group by primeiro_nome, nome_projeto
    order by nome_projeto;