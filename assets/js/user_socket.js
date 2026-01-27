import { Socket } from "phoenix"

let socket = new Socket("/socket", {})
socket.connect()

let channel = socket.channel("room:lobby", {})

channel.join()
  .receive("ok", () => console.log("Joined room:lobby"))
  .receive("error", resp => console.error("Join error", resp))

channel.on("message", payload => {
  console.log("New message:", payload)
})

window.sendMessage = function (msg) {
  channel.push("message", { body: msg })
}

export default socket
