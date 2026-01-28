# Agents

Este documento descreve os **agentes lógicos** e responsabilidades internas do projeto **Phoenix Realtime Chat**. Aqui, "agent" não significa um processo Elixir específico (`Agent`), mas sim **papéis funcionais** claros dentro da arquitetura para facilitar entendimento, manutenção e evolução do sistema.

## Visão Geral

O sistema é composto por agentes bem definidos que colaboram via **Phoenix Channels**, **PubSub** e **processos BEAM**, garantindo concorrência segura, isolamento de falhas e comunicação em tempo real.

```
Client (Browser)
   │
   ▼
UserSocket ──► RoomChannel ──► PubSub
                    │
                    ├─► Presence
                    └─► Persistence (Ecto)
```

---

## 1. Client Agent (Frontend)

**Responsabilidade:**

* Conectar ao WebSocket
* Enviar mensagens para uma sala (`room:*`)
* Receber mensagens e eventos de presença

**Tecnologias:**

* Phoenix JS Client
* WebSocket

**Eventos principais:**

* `phx_join`
* `new_msg`
* `presence_state`
* `presence_diff`

---

## 2. Socket Agent (`UserSocket`)

**Responsabilidade:**

* Autenticar a conexão WebSocket
* Identificar o usuário
* Autorizar o acesso aos canais

**Pontos-chave:**

* Executa antes de qualquer `Channel`
* Injeta informações do usuário em `socket.assigns`

**Exemplo de assigns:**

```elixir
%{user: %{id: "uuid", username: "gabriel"}}
```

---

## 3. Channel Agent (`RoomChannel`)

**Responsabilidade:**

* Gerenciar o ciclo de vida da sala de chat
* Receber e retransmitir mensagens
* Integrar presença e persistência

**Eventos tratados:**

* `join/3`
* `handle_in("new_msg", ...)`
* `handle_info(:after_join, ...)`

**Características importantes:**

* Cada sala é isolada (`room:lobby`, `room:123`)
* Cada conexão roda em um processo BEAM independente

---

## 4. Presence Agent (`Presence`)

**Responsabilidade:**

* Rastrear usuários online/offline
* Sincronizar estado entre nós (cluster-ready)

**Baseado em:**

* `Phoenix.Presence`
* ETS + PubSub

**Eventos emitidos:**

* `presence_state`
* `presence_diff`

---

## 5. PubSub Agent

**Responsabilidade:**

* Distribuir eventos entre processos e nós
* Garantir comunicação desacoplada

**Usado para:**

* Mensagens de chat
* Eventos de presença

**Benefício:**

* Permite escalar horizontalmente sem alterar código

---

## 6. Persistence Agent (Ecto)

**Responsabilidade:**

* Persistir mensagens
* Consultar histórico de salas

**Tecnologias:**

* Ecto
* PostgreSQL (planejado)

**Estado atual:**

* Estrutura preparada
* Implementação completa prevista no roadmap

---

## 7. Supervisor Tree

Todos os agentes são gerenciados por uma **árvore de supervisão**, garantindo:

* Reinício automático em falhas
* Isolamento de erros
* Alta disponibilidade

---

## Objetivo deste Documento

Este arquivo existe para:

* Facilitar onboarding de novos desenvolvedores
* Ajudar entrevistadores a entender rapidamente a arquitetura
* Servir como base para evolução futura (auth, cluster, persistência)

---

## Próximos Passos

* [ ] JWT no `UserSocket`
* [ ] Histórico por sala
* [ ] Rate limiting por usuário
* [ ] Cluster com libcluster

---

**Autor:** Gabriel Araujo
