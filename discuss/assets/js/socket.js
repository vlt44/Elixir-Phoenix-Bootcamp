import { Socket } from "phoenix"

let socket = new Socket("/socket", {})
socket.connect()

const createSocket = (topicId) => {
  let channel = socket.channel(`comments:${topicId}`, {})
  
  channel.join()
    .receive("ok", resp => {
      renderComments(resp.comments);
    })
    .receive("error", resp => console.log("failed", resp))

  document.querySelector('button').addEventListener('click', () => {
    const content = document.querySelector('textarea').value;
    channel.push("comment:add", { content: content });
  });
}

function renderComments(comments) {
  const renderedComments = comments.map(comment => {
    return `<li class="collection-item">${comment.content}</li>`
  });

   list.innerHTML = comments
    .map(comment => `<li class="collection-item">${comment.content}</li>`)
    .join('');
}

window.createSocket = createSocket;