create table tbl_professor(
  func      integer not null auto_increment primary key,
  nome      varchar(100) not null,
  email     varchar(100) not null unique,
  telefone  varchar(15)
);

create table tbl_disciplina(
  cod_disc  integer not null auto_increment primary key,
  nome	    varchar(100) not null,
  carga_h   integer,
  ementa    text,
  biblio    text,
  conteudo  text,
  justific  text,
  prof_resp integer not null,
  
  constraint fk_resp FOREIGN key (prof_resp) references tbl_professor(func)
);

create table tbl_curso(
  codigo     integer not null auto_increment primary key,
  nome	     varchar(100) not null,
  duracao    integer,
  autoriza   varchar(50),
  prof_coord integer not null,
  constraint fk_coord foreign key (prof_coord) references tbl_professor(func)
);

create table tbl_grade(
  num_seq 	integer not null auto_increment primary key,
  ano_ini   integer,
  sem_ini   integer,
  cod_curso integer,
  constraint fk_curso foreign key (cod_curso) references tbl_curso(codigo)
);

create table tbl_gradedisc(
  codigo_curso integer not null,
  num_seq	   integer not null,
  constraint pk_gradedisc primary key (codigo_curso, num_seq),
  constraint fk_cursogr   foreign key (codigo_curso) references tbl_curso (codigo),
  constraint fk_gradegr   foreign key (num_seq) references tbl_grade (num_seq) 
);

create table tbl_ministra(
  func_prof	  integer not null,
  codigo_disc integer not null,
  ano_minist  integer not null,
  sem_minist  integer not null,
  constraint pk_ministra primary key (func_prof, codigo_disc, ano_minist, sem_minist),
  constraint fk_profdisc foreign key (func_prof) REFERENCES tbl_professor(func),
  constraint fk_discmin  foreign key (codigo_disc) REFERENCES tbl_disciplina(cod_disc)
);








