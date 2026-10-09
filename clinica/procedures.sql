-- Procedure para realizar login de usuários já cadastrados
 
DELIMITER $$

create procedure proc_login(
IN cpf_entrada varchar(14),
IN senha_entrada varchar(255), 
OUT verify int,
OUT id_login int
)

BEGIN
	select count(*), paciente_id into verify, id_login 
    from paciente 
    where cpf_entrada = cpf 
    and senha_entrada = senha;
    
		if verify > 0 then 
			set verify = 1;
        else
			set verify = 0;
        end if;
END $$
DELIMITER ;

-- Procedure para cadastrar novos usuários

DELIMITER $$ 

create procedure proc_cadastro(
IN nome_cadastro varchar(100),
IN email_cadastro varchar(100),
IN senha_cadastro varchar(255),
IN cpf_cadastro varchar(255),
OUT usuario int
)

BEGIN 

	DECLARE EXIT HANDLER FOR sqlexception
	BEGIN
		ROLLBACK; -- Desfaz qualquer alteração pendente
		set usuario = 0;
	END ;
    
	insert into paciente (nome, email, senha, cpf) 
    values (nome_cadastro, email_cadastro, senha_cadastro, cpf_cadastro);
	
    set usuario = 1;
END $$

DELIMITER $$

-- Procedure para marcar uma consulta

DELIMITER $$ 

create procedure proc_consulta(
IN e_paciente int,
IN data_entrada date,
IN sintomas_consulta varchar(200),
OUT resultado int
)

BEGIN
	
    DECLARE e_medico int;
	DECLARE EXIT HANDLER FOR sqlexception
		
	BEGIN
        set resultado = 0;
	END ;
    
    select medico_id into e_medico from medico ORDER BY RAND( ) LIMIT 1;
    insert into consulta (fk_paciente, fk_medico, data_consulta, descricao) values (e_paciente, e_medico, data_entrada, sintomas_consulta);
    set resultado = 1;
    
END $$
    
DELIMITER $$