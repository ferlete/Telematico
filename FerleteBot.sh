#!/bin/bash
# Script para envio de Alert Zabbix para Bot Telegram

#Parametros recebido do Zabbix
to=$1
subject=$2
body=$3


#Token do Bot API Telegram
TOKEN=""

CONTATOS=("<CHAT_ID1>" "<CHAT_ID2>") #Informe um ou mais ID CHAT aqui, separados por espaço. Para conseguir o CHAT ID pare o Telemático $telematico.sh kill e abra a seguinte URL https://api.telegram.org/bot<TOKEN>/getUpdates

MESSAGE="$1 $2 $3"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

# Envia a mensagem para cada CHAT ID
for i in "${CONTATOS[@]}"
do
	curl -s -X POST $URL -d chat_id=$i -d text="$MESSAGE"
done

# Salva log de envio
date | tr -d '\n'
printf %s "$(date)" >> /tmp/ferleteBot.log
echo " | $2" >> /tmp/ferleteBot.log
