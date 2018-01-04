#!/bin/bash
#
# Script para envio de Alert Zabbix para Bot Telegram
# Telemático - Escrito por ferlete@gmail.com
# Este script recebe alertas do Zabbix e envia para Bot Telegram
# Para pegar o CHAT ID pare o bot "./telematico kill" e envie mensagem para o bot através do grupo criado
# e acesse este endereço -> https://api.telegram.org/bot<TOKEN>/getUpdates sera mostrado um XML com esta
# informação. É possível também utilizar o CHAT ID de um contato específico
#
# Este script deve estar na pasta /usr/local/share/zabbix/alertscripts/ 
#

#Parametros recebido do Zabbix
to=$1
subject=$2
body=$3

#Token do Bot API Telegram
TOKEN="<INFORME_TOKEN>"

#Informe o ID CHAT aqui, é possível colocar mais de um CHAT ID
CONTATOS=("<CHAT_ID1>" "<CHAT_ID2")
MESSAGE="$1 $2 $3"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

# Envia a mensagem para cada chat ID Bot
for i in "${CONTATOS[@]}"
do
	curl -s -X POST $URL -d chat_id=$i -d text="$MESSAGE"
done

# Salva log de envio
date | tr -d '\n'
printf %s "$(date)" >> /tmp/zabbixBot.log
echo " | $2" >> /tmp/zabbixBot.log

