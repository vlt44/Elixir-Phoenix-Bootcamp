import { Socket } from "phoenix"

let socket = new Socket("/socket", {})
socket.connect()

let channel = socket.channel("comments:1", {})
channel.join()
  .receive("ok", resp => console.log("joined", resp))
  .receive("error", resp => console.log("failed", resp))

document.querySelector('button').addEventListener("click", () => {
  channel.push("new_comment", {body: "hi"})
})

export default socket