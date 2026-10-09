create database if not exists clinic_blend;
use clinic_blend;

create table if not exists medico(
medico_id int primary key auto_increment,
nome varchar(100) not null,
email varchar(100) not null,
senha varchar(255) not null,
cpf varchar(14) not null unique
);

create table if not exists paciente(
paciente_id int primary key auto_increment,
nome varchar(100) not null,
email varchar(100) not null,
senha varchar(255) not null,
cpf varchar(14) not null unique
);

create table if not exists funcionario(
funcionario_id int primary key auto_increment,
nome varchar(100) not null,
email varchar(100) not null,
senha varchar(255) not null,
cpf varchar(14) not null unique
);

create table if not exists prontuario(
funcionario_id int primary key auto_increment,
fk_paciente int not null,

constraint fk_pront_pac 	-- regra de contrato para funcionamento correto da fk
foreign key (fk_paciente)
references paciente(paciente_id)
on update cascade	 -- se o id do paciente mudar, atualiza nos prontuários
);

create table if not exists consulta(
consulta_id int primary key auto_increment,
data_consulta date not null,
fk_medico int not null,
fk_paciente int not null,
descricao varchar(200) not null,

constraint fk_cons_med
foreign key (fk_medico)
references medico(medico_id)
on update cascade,

constraint fk_cons_pac
foreign key (fk_paciente)
references paciente(paciente_id)
on update cascade
);