import { Socket } from "phoenix"

let socket = new Socket("/socket", {})
socket.connect()

const createSocket = (topicId) => {
  let channel = socket.channel(`comments:${topicId}`, {})
  
  channel.join()
    .receive("ok", resp => console.log("joined", resp))
    .receive("error", resp => console.log("failed", resp))
}

window.createSocket = createSocket;