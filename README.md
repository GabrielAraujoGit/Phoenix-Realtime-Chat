# Phoenix Realtime Chat

Servidor de chat em tempo real desenvolvido com **Elixir** e **Phoenix**, utilizando **Phoenix Channels** e **WebSockets** para comunicação bidirecional de baixa latência.

A aplicação explora de forma prática os principais diferenciais do ecossistema **BEAM**, como **concorrência baseada em processos leves**, **isolamento de falhas** e **mensageria via PubSub**, garantindo escalabilidade e estabilidade mesmo com múltiplas salas e usuários conectados simultaneamente.

O sistema suporta **múltiplas salas de chat**, **identificação de usuários**, **presença em tempo real (online/offline)** e **autenticação no socket**, com arquitetura preparada para evolução futura, como persistência com Ecto, histórico de mensagens e autenticação por token.

O frontend foi construído com **Phoenix (HEEx / LiveView)** e **Tailwind CSS**, priorizando simplicidade e foco na experiência em tempo real, enquanto o backend mantém uma estrutura clara, modular e alinhada às boas práticas do Phoenix Framework.

---

## 🚀 Tecnologias Utilizadas

* **Elixir**
* **Erlang/OTP (BEAM VM)**
* **Phoenix Framework**
* **Phoenix Channels & PubSub**
* **Phoenix Presence**
* **WebSockets**
* **Tailwind CSS**
* **Ecto (preparado para persistência)**

---

## ✨ Funcionalidades

* Comunicação em tempo real via WebSockets
* Múltiplas salas de chat (`room:<id>`)
* Identificação de usuários
* Presença em tempo real (online / offline)
* Autenticação no socket
* Arquitetura preparada para persistência de mensagens

---

## 🧠 Objetivo do Projeto

Este projeto foi desenvolvido com foco em **demonstrar domínio prático do ecossistema Elixir/Phoenix**, especialmente no uso de concorrência, processos leves e comunicação distribuída.

Ele simula um cenário real de aplicação em tempo real, comum em sistemas como chats, dashboards colaborativos, notificações e sistemas de mensageria.

---

## 🛠️ Como Executar Localmente

### Pré-requisitos

* Elixir >= 1.15
* Erlang/OTP >= 26
* Node.js (para assets)

### Passos

```bash
# Instalar dependências
mix deps.get

# Instalar dependências de assets
cd assets && npm install

# Voltar para a raiz do projeto
cd ..

# Iniciar o servidor Phoenix
mix phx.server
```

A aplicação estará disponível em:

```
http://localhost:4000
```

---

## 📂 Estrutura Relevante do Projeto

```
lib/
 ├─ realtime_chat_web/
 │   ├─ channels/
 │   │   ├─ room_channel.ex
 │   │   └─ user_socket.ex
 │   ├─ presence.ex
 │   └─ endpoint.ex
```

---

## 🔮 Próximos Passos (Roadmap)

* Persistência de mensagens com Ecto
* Histórico de mensagens por sala
* Autenticação via JWT
* Escalonamento horizontal com Phoenix PubSub distribuído
* Testes de carga e concorrência

---

## 👤 Autor

**Gabriel Araujo**
Desenvolvedor Full Stack com foco em Backend, Elixir, IA e sistemas concorrentes.

---

## 📄 Licença

Este projeto é open-source e está disponível sob a licença MIT.
