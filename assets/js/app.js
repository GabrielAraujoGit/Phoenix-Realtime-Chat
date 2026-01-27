import { Socket } from "phoenix"

const username = prompt("Seu nome") || "guest"
const roomId = "lobby"

let socket = new Socket("/socket")
socket.connect()

let channel = socket.channel(`room:${roomId}`, { username })

const messages = document.getElementById("messages")
const users = document.getElementById("users")
const input = document.getElementById("message-input")

channel.join()

channel.on("new_msg", payload => {
  let li = document.createElement("li")
  li.innerHTML = `<strong>${payload.user}</strong>: ${payload.body}`
  messages.appendChild(li)
  messages.scrollTop = messages.scrollHeight
})

channel.on("presence_state", state => {
  users.innerHTML = ""
  Object.values(state).forEach(p => {
    let li = document.createElement("li")
    li.innerText = p.metas[0].username
    users.appendChild(li)
  })
})

window.sendMessage = () => {
  if (input.value.trim() !== "") {
    channel.push("new_msg", { body: input.value })
    input.value = ""
  }
}

input.addEventListener("keydown", e => {
  if (e.key === "Enter") sendMessage()
})
