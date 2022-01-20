use base_de_testes;

/* um exemplo de on update e on delete cascade */
create table tb_departamento(
 iddepto integer not null auto_increment primary key,
 nomedepto varchar(50) not null
 );
 
create table tb_funcionario(
  idfunc integer not null auto_increment primary key,
  nome   varchar(100) not null,
  salario double,
  depto  integer,
  constraint fk_depto foreign key (depto) references tb_departamento(iddepto)
	on delete cascade on update cascade
);
 
 /* especificando apenas 1 atributo */
 insert into tb_departamento (nome) values ('Presidencia')
 
 /* sem especificar atributos */
 insert into tb_departamento values (null, 'Financeiro');
 
 /* inserindo varios registros de uma única vez */
 insert into tb_departamento values 
 (null, 'Desenvolvimento'), 
 (null, 'Expedicao'), 
 (null,'Estoque');
 
 /* inserindo funcionarios */
 insert into tb_funcionario values 
 (null, 'Prof. Isidro', 5000, 1),
 (null, 'Joao Rodrigo', 3500, 2),
 (null, 'Maria Antonia', 3850, 3),
 (null, 'Joana Dark', 4200, 3),
 (null, 'Andre Jordao', 3210, 4),
 (null, 'Priscila Melo', 4200, 4),
 (null, 'Agnes Rhodes', 2100, 2),
 (null, 'Joao Marcelo', 2700, 3),
 (null, 'Pedro Oliveira', 3400, 4),
 (null, 'Jose Almeida', 4000, 5),
 (null, 'Carla Rodrigues', 3750, 5);
 