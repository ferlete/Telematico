#!/bin/bash
# Telemático - Escrito por ferlete@gmail.com
# Script que realiza consulta a base de dados do OTRS e pesquisa informações do chamado
# Altere as SQL de acordo com sua base de dados

echo "Informe o numero do chamado:"
read num

if ! [[ $num = ?(+|-)+([0-9]) ]] ; then 
	echo "Informe SOMENTE numeros!"
else
	# Total de chamados que não estao 2-fechado com sucesso, 3-Fechado sem sucesso, 5-Cancelado pelo Cliente, 11-Serviços não suportado pela CS
	total=$(mysql --defaults-extra-file=/opt/Telematico/config.cnf -s -N -D otrs -e "select count(*) from ticket t where t.ticket_state_id not in(2,3,5,11) and t.tn=$num;")

	if [ "$total" -ge 1 ]; then

		# Busca o Nome do Cliente
		cliente=$(mysql --defaults-extra-file=/opt/Telematico/config.cnf -s -N -D otrs -e "select CONCAT(c.title, ' ' , c.first_name, ' ', c.last_name) as Cliente from ticket t inner join customer_user c on c.email=t.customer_user_id inner join queue q on q.id=t.queue_id inner join ticket_state ts on ts.id=t.ticket_state_id where t.ticket_state_id not in(2,3,5,11) and t.tn=$num;")

		# Busca o Estado do Chamado
		estado=$(mysql --defaults-extra-file=/opt/Telematico/config.cnf -s -N -D otrs -e "select ts.name as estado from ticket t inner join customer_user c on c.email=t.customer_user_id inner join queue q on q.id=t.queue_id inner join ticket_state ts on ts.id=t.ticket_state_id where t.ticket_state_id not in(2,3,5,11) and t.tn=$num;")
		# Busca o Titulo do Chamado
		titulo=$(mysql --defaults-extra-file=/opt/Telematico/config.cnf -s -N -D otrs -e "select t.title as titulo from ticket t inner join customer_user c on c.email=t.customer_user_id inner join queue q on q.id=t.queue_id inner join ticket_state ts on ts.id=t.ticket_state_id where t.ticket_state_id not in(2,3,5,11) and t.tn=$num;")

		# Busca o Fila em que questa o Chamado
		fila=$(mysql --defaults-extra-file=/opt/Telematico/config.cnf -s -N -D otrs -e "select q.name as fila from ticket t inner join customer_user c on c.email=t.customer_user_id join queue q on q.id=t.queue_id inner join ticket_state ts on ts.id=t.ticket_state_id where t.ticket_state_id not in(2,3,5,11) and t.tn=$num;")

		# Informação enviada para API Telegram	
		echo "$cliente, o chamado $titulo esta $estado na Sessão $fila"
	else
		echo "Chamado $num, não existe!!"
	fi
fi
exit
