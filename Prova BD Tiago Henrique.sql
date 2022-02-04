/*Tiago Henrique Simionato Machado
RA:11201810899*/

/*Questão 1*/
/*Script para criação da base de dados (todas as tabelas)*/
create table tbl_departamento (
	idDepto smallint not null auto_increment primary key,
	nomeDep varchar(50) not null,
	andar smallint
);

create table tbl_funcionario(
	idFunc smallint not null auto_increment primary key,
	nomeF varchar(50) not null,
	emailF varchar(50),
	sexo ENUM('M','F'),
	dataAd DATE,
	salario float,
	idDepto smallint,
	idSuper smallint,
	constraint fk_depto foreign key (idDepto) references tbl_departamento(idDepto) 
		on delete set null,
	constraint fk_idsuper foreign key (idSuper) references tbl_funcionario(idFunc)
);

create table tbl_projeto(
	idProj smallint not null auto_increment primary key,
	descrP varchar(50) not null
);

create table tbl_projfunc(
	idProj smallint not null,
	idFunc smallint not null,
	dataI DATE,
	constraint pf_projfunc primary key (idProj, idFunc),
	constraint fk_idproj foreign key (idProj) references tbl_projeto(idProj)
		on delete cascade,
	constraint fk_idfunc foreign key (idFunc) references tbl_funcionario(idFunc)
		on delete cascade
);

create table tbl_evento(
	idEvento smallint not null auto_increment primary key,
	descrEvt varchar(50)
);

create table tbl_ocorrencia(
	instante timestamp not null,
	idEvento smallint not null,
	idFunc smallint not null,
	constraint pk_ocorrencia primary key (instante, idEvento, idFunc),
	constraint fk_idevento foreign key (idEvento) references tbl_evento(idEvento)
		on delete cascade,
	constraint fk_idfunc foreign key (idFunc) references tbl_funcionario(idFunc)
		on delete cascade
);

/*Questão 2*/
/*Script para inserção dos dados nas respectivas tabelas*/
insert into tbl_departamento values
(null, 'Engenharia', 1),
(null, 'Administrativo', 2),
(null, 'RH', 3),
(null, 'Logistica', 4),
(null, 'Diretoria', 5);

insert into tbl_funcionario values
(null, 'Adamastor Quaresma', 'ada@acme.org', 'M', '2010-01-01', 15000, 5, null),
(null, 'Querencia Nunes', 'que@acme.org', 'F', '2010-02-01', 5000, 3, 1),
(null, 'Sergio Patricio', 'ser@acme.org', 'M', '2010-02-10', 3500, 2, 1),
(null, 'Foster Felser', 'fos@acme.org', 'M', '2010-02-10', 2250, 4, 1),
(null, 'Terence Wallace', 'seila@acme.org', 'M', '2010-03-10', 4000, 3, 1),
(null, 'Deosdedite Paixao', 'deo@acme.org', 'F', '2010-04-01', 2100, 3, 5),
(null, 'Ricardo Neves', 'ric@acme.org', 'M', '2010-04-01', 2100, 3, 5),
(null, 'Felicio Ramos', 'fel@acme.org', 'M', '2010-04-01', 2100, 3, 5),
(null, 'Nilsonclecio Ferreira', 'nil@acme.org', 'M', '2010-04-01', 2100, 3, 5);

insert into tbl_projeto values
(null, 'Folha de Pagamento'),
(null, 'Trading System'),
(null, 'New Devices for Education'),
(null, 'Ideas for Life');

insert into tbl_projfunc values
(1, 5, '2010-03-10'),
(1, 6, '2010-04-10'),
(1, 7, '2010-04-10'),
(2, 5, '2010-04-10'),
(2, 8, '2010-04-10'),
(3, 9, '2010-04-10'),
(4, 6, '2010-04-10'),
(4, 7, '2010-04-10');

insert into tbl_evento values
(null, 'Entrada'),
(null, 'Saida'),
(null, 'Saida-Almoco'),
(null, 'Retorno-Almoco'),
(null, 'Entrada-ServicoExterno'),
(null, 'Saida-ServicoExterno');

insert into tbl_ocorrencia values
(timestamp '2010-05-01 08:00:00', 1, 6),
(timestamp '2010-05-01 08:00:00', 1, 7),
(timestamp '2010-05-01 08:00:00', 1, 8),
(timestamp '2010-05-02 00:00:00', 1, 5),
(timestamp '2010-05-01 17:00:00', 2, 6),
(timestamp '2010-05-01 17:00:00', 2, 7),
(timestamp '2010-05-01 17:00:00', 2, 8),
(timestamp '2010-05-02 00:00:00', 2, 5),
(timestamp '2010-05-01 12:00:00', 3, 6),
(timestamp '2010-05-01 12:00:00', 3, 7),
(timestamp '2010-05-01 12:00:00', 3, 8),
(timestamp '2010-05-02 00:00:00', 3, 5),
(timestamp '2010-05-01 13:00:00', 4, 6),
(timestamp '2010-05-01 13:00:00', 4, 7),
(timestamp '2010-05-01 13:00:00', 4, 8),
(timestamp '2010-05-02 00:00:00', 4, 5),
(timestamp '2010-05-01 08:00:00', 5, 9),
(timestamp '2010-05-01 13:00:00', 5, 9),
(timestamp '2010-05-01 12:00:00', 6, 9),
(timestamp '2010-05-01 17:00:00', 6, 9);

/*Questão 3*/
/*Informe consultas SQL para os seguintes casos:*/

/*Item 1*/
/*Mostrar todos os funcionários da empresa, ordenando por nome*/
select * from tbl_funcionario order by nomeF;

/*Item 2*/
/*Mostrar o funcionário mais antigo na empresa*/
select * from tbl_funcionario where dataAd in (select min(dataAd) from tbl_funcionario);

/*Item 3*/
/*Mostrar todos os departamentos que têm funcionários alocados*/
select dep.idDepto,nomeDep,count(idFunc) as funcionarios
	from tbl_funcionario as f inner join tbl_departamento as dep
	on f.idDepto = dep.idDepto
	group by dep.idDepto; 

/*Item 4*/
/*Mostrar todos os projetos de um determinado funcionário*/
select f.nomeF as Funcionario, p.descrP as Projeto
	from tbl_projeto as p inner join tbl_projfunc as pf on p.idProj = pf.idProj
	inner join tbl_funcionario as f on f.idFunc = pf.idfunc
	where f.idFunc = 5;

/*Item 5*/
/*Mostrar todos os funcionários que estão participando de projetos (e quais não estão)*/
select f.nomeF as Funcionario, p.descrP as Projeto
	from tbl_funcionario as f left outer join tbl_projfunc as pf on f.idFunc = pf.idFunc
	left outer join tbl_projeto as p on p.idProj = pf.idProj;