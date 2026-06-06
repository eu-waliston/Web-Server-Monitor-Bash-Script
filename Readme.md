# Web Server Monitor Bash Script

Um script em Bash leve e eficiente para monitorar a disponibilidade de sites e servidores web. Ele valida o status do servidor e envia alertas por e-mail apenas quando ocorrem mudanças de estado (queda ou recuperação), evitando o envio de spam na sua caixa de entrada.

## 📋 Como Funciona

O script utiliza a ferramenta `wget` em modo spider para testar a conexão com o servidor de destino sem baixar arquivos. Para gerenciar os alertas sem inundar o administrador com e-mails repetitivos, o script utiliza um mecanismo de **Lock File (Arquivo de Trava)** que serve como memória interna.

Existem 4 cenários possíveis a cada execução:

1. **O site acabou de cair:** Se o servidor falhar e o arquivo de trava não existir, um e-mail de alerta é enviado e o arquivo de trava é criado.
2. **O site continua fora do ar:** Se o servidor falhar e o arquivo de trava já existir, o script entende que você já foi notificado. Nenhum e-mail novo é enviado.
3. **O site voltou a funcionar:** Se o servidor responder com sucesso e o arquivo de trava existir, um e-mail de recuperação é enviado e o arquivo de trava é deletado.
4. **Tudo funcionando normalmente:** Se o servidor responder com sucesso e não houver arquivo de trava, o script apenas valida que está tudo online e encerra sem nenhuma ação adicional.

## 🛠️ Pré-requisitos

O script utiliza ferramentas nativas do ecossistema Linux. Certifique-se de ter instalado:
* **Bash** (geralmente padrão em `/bin/bash`)
* **Wget** (utilizado para os testes de conexão)
* **mail / mailx** (serviço de e-mail local configurado para disparar mensagens externas)

## ⚙️ Configuração

Antes de rodar, abra o script e edite as seguintes variáveis no topo do arquivo com as suas informações:

```bash
WEBSERVER="https://exemplo.com"       # URL do site que deseja monitorar
SEND_ID="remetente@seu-dominio.com"   # O e-mail que vai constar como remetente
TO_ID="seu-email@gmail.com"           # O e-mail que receberá os alertas
MEMFILE="lock-file"                   # Nome do arquivo de trava temporário
```

## 🚀 Como Usar

### 1. Dar permissão de execução
Antes de rodar pela primeira vez, você precisa dar permissão para o sistema operacional executar o arquivo:
```bash
chmod +x monitor.sh
```

### 2. Execução Manual
Para testar o funcionamento direto no terminal:
```bash
./monitor.sh
```

## ⏰ Automação com Cron (Recomendado)

Para que o monitoramento seja eficiente, o ideal é que ele execute de forma automática a cada período de tempo. Você pode fazer isso utilizando o agendador nativo do Linux (`cron`).

1. Abra o editor do crontab:
   ```bash
   crontab -e
   ```

2. Adicione a linha abaixo ao final do arquivo para rodar o monitor **a cada 5 minutos** (lembre-se de ajustar o caminho absoluto de onde o seu script está salvo):
   ```cron
   */5 * * * * /home/usuario/scripts/monitor.sh > /dev/null 2>&1
   ```

3. Salve e feche o arquivo. O monitor agora rodará em segundo plano indefinidamente.

