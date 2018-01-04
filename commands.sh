#!/bin/bash
# Telemático - Escrito por ferlete@gmail.com
# Edit seus comando neste arquivo

if [ "$1" = "source" ];then
	# Place the token in the token file
	TOKEN=$(cat token)
	# Set INLINE to 1 in order to receive inline queries.
	# To enable this option in your bot, send the /setinline command to @BotFather.
	INLINE=1
	# Set to .* to allow sending files from all locations
	FILE_REGEX='/home/ferlete/allowed/.*'
else
	if ! tmux ls | grep -v send | grep -q $copname; then
		[ ! -z ${URLS[*]} ] && {
			curl -s ${URLS[*]} -o $NAME
			send_file "${CHAT[ID]}" "$NAME" "$CAPTION"
			rm "$NAME"
		}
		[ ! -z ${LOCATION[*]} ] && send_location "${CHAT[ID]}" "${LOCATION[LATITUDE]}" "${LOCATION[LONGITUDE]}"

		# Inline
		if [ $INLINE == 1 ]; then
			# inline query data
			iUSER[FIRST_NAME]=$(echo "$res" | sed 's/^.*\(first_name.*\)/\1/g' | cut -d '"' -f3 | tail -1)
			iUSER[LAST_NAME]=$(echo "$res" | sed 's/^.*\(last_name.*\)/\1/g' | cut -d '"' -f3)
			iUSER[USERNAME]=$(echo "$res" | sed 's/^.*\(username.*\)/\1/g' | cut -d '"' -f3 | tail -1)
			iQUERY_ID=$(echo "$res" | sed 's/^.*\(inline_query.*\)/\1/g' | cut -d '"' -f5 | tail -1)
			iQUERY_MSG=$(echo "$res" | sed 's/^.*\(inline_query.*\)/\1/g' | cut -d '"' -f5 | tail -6 | head -1)

			# Inline examples
			if [[ $iQUERY_MSG == photo ]]; then
				answer_inline_query "$iQUERY_ID" "photo" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg"
			fi

			if [[ $iQUERY_MSG == sticker ]]; then
				answer_inline_query "$iQUERY_ID" "cached_sticker" "BQADBAAD_QEAAiSFLwABWSYyiuj-g4AC"
			fi

			if [[ $iQUERY_MSG == gif ]]; then
				answer_inline_query "$iQUERY_ID" "cached_gif" "BQADBAADIwYAAmwsDAABlIia56QGP0YC"
			fi
			if [[ $iQUERY_MSG == web ]]; then
				answer_inline_query "$iQUERY_ID" "article" "GitHub" "http://github.com/ferlete/Telematico"
			fi
		fi &
	fi
	case $MESSAGE in
		# Aqui ocorre a integração com OTRS o script chamado.sh realizado a consulta a base de dados do OTRS
		'/chamado')
			startproc "./chamado.sh"
			;;
		'/info')
			send_markdown_message "${CHAT[ID]}" "Ola, eu sou o mascote do 6CTA - <EMAIL> - RITEx <RITEX>"
			;;
		'/servicos')
			# Aqui você pode implementar uma rotina para verificar a infra
			send_markdown_message "${CHAT[ID]}" "Todos os serviços estão normais"
			;;
		'/catalogo')
			send_markdown_message "${CHAT[ID]}" "Nossos principais serviços são:

*Hospedagem de Sistemas Especificos*
*Hospedagem de Página*
*Acesso a Rede Corporativa(VPN)*
*Acesso a Internet*
*Correio Eletrônico Regional*
*Telefonia*
*Consultoria Técnica*
*Perícia Computacional*
*Suporte a Videoconferência*

Maiores detalhes visite nossa Intranet!"
			;;

		'/start')

			send_action "${CHAT[ID]}" "typing"
			send_markdown_message "${CHAT[ID]}" "Eu sou mascote do 6º CTA. Atualmente eu posso enviar informaçõe sobre chamados em atendimento pela Central de Serviços e alerta para equipe de TI sobre ativos de rede.

*Comandos Disponíveis*:
*• /start*: _Inicia o mascote e le as mensagens_.
*• /info*: _Mostra informações sobre este mascote_.
*• /chamado*: _Inicia uma consulta de chamados aberto na CS [chat privado]_.
*• /servicos*: _Informa o Status dos serviços prestados pelo 6CTA_.
*• /catalogo*: _Informa os serviços prestado pelo 6CTA_.
*• /cancel*: _Cancela uma consulta em andamento_.

Se preferir um resposta humana, ligue no RITEx <RITEX> ou Fixo <TELEFONE FIXO>
"
			;;
			
		'/enviar')
			#send_markdown_message "${CHAT[ID]}" "*Saindo do CHAT...*"
   			#leave_chat "${CHAT[ID]}"
			send_message "${CHAT[ferlete]}" "lol"
     			;;
     			
     		#'/kickme')
     		#	kick_chat_member "${CHAT[ID]}" "${USER[ID]}"
     		#	unban_chat_member "${CHAT[ID]}" "${USER[ID]}"
     		#	;;
     			
		'/cancel')
			if tmux ls | grep -q $copname; then killproc && send_message "${CHAT[ID]}" "Comando Cancelado.";else send_message "${CHAT[ID]}" "Não existe nenhum comando executando.";fi
			;;
		*)
			if tmux ls | grep -v send | grep -q $copname;then inproc; else send_message "${CHAT[ID]}" "$MESSAGE" "safe";fi
			;;
	esac
fi
