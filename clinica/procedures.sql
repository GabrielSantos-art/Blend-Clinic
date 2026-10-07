-- Procedure para realizar login de usuários já cadastrados
 
DELIMITER $$

create procedure proc_login(
IN cpf_entrada varchar(14),
IN senha_entrada varchar(255), 
OUT login int
)

BEGIN
	select count(*) into login
    from paciente 
    where cpf_entrada = cpf 
    and senha_entrada = senha;
    
		if login > 0 then 
			set login = 1;
        else
			set login = 0;
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

)
BEGIN

