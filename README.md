#Telemático
Um bot do telegram escrito em shell script.

Depende de [tmux](http://github.com/tmux/tmux).
Usa [JSON.sh](http://github.com/dominictarr/JSON.sh).
Baseado em [telegram-bot-bash](https://github.com/topkecleon/telegram-bot-bash).


## Instruções
### Primeiro crie o Bot

1. Envie uma mensagem para @botfather https://telegram.me/botfather com o seguinte texto: `/newbot`
   
   ![botfather conversa inicial](http://i.imgur.com/aI26ixR.png)

2. @botfather responde com `Alright, a new bot. How are we going to
call it? Please choose a name for your bot.`

3. Digite o nome do seu bot.

4. @botfather responde com `Good. Now let's choose a username for your
bot. It must end in bot. Like this, for example: TetrisBot or
tetris_bot.`

5. Digite o nome do usuario que você deseja para seu, no minimo 5 caracteres,
e deve terminar com a palavra `bot`. Por Exemplo: `Telematico_bot`

6. @botfather responde com:

    Done! Congratulations on your new bot. You will find it at
telegram.me/telesample_bot. You can now add a description, about
section and profile picture for your bot, see /help for a list of
commands.

    Use este token para acessar HTTP API:
    <b>123456789:AAG90e14-0f8-40183D-18491dDE</b>

    A descrição da API do Bot, veja esta página:
https://core.telegram.org/bots/api

7. Observe o 'token' mencionado acima.

8. Digite `/setprivacy` para @botfather.

   ![botfather conversa posterior](https://ibb.co/ermBUb)

9. @botfather responde com `Choose a bot to change group messages settings.`

10. Digite `@telesample_bot` (mude para o nome de usuário que você definiu no passo 5
acima, mas comece com `@`)

11. @botfather responde com

    'Enable' - your bot will only receive messages that either start
with the '/' symbol or mention the bot by username.
    'Disable' - your bot will receive all messages that people send to groups.
    Current status is: ENABLED

12. Digite `Disable` para permitir que seu bot receba todas as mensagens enviadas para um grupo. Esta etapa depende de você na verdade.

13. @botfather responde com `Success! The new status is: DISABLED. /help`

### Instalando o Telemático
Clone o repositorio:
```
cd /opt
git clone --recursive https://github.com/ferlete/Telematico
```

Crie um arquivo chamado token e cole o token la.

### Integrando com OTRS

Edit o arquivo config.cnf com as informações de conexão de seu banco de dados do OTRS. 
OBS> Crie um usuário somente com permissão de consulta a base de dados o OTRS

Edite o arquivo commands.sh e informe os comando

### Integrando com ZABBIX

Copie o arquivo ferleteBot.sh para /usr/local/share/zabbix/alertscripts e realize a configuração do Zabbix

