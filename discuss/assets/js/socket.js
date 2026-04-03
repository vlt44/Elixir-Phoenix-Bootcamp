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

    channel.on(`comments:${topicId}:new`, renderComment);

  document.querySelector('button').addEventListener('click', () => {
    const content = document.querySelector('textarea').value;
    channel.push("comment:add", { content: content });
  });
}

function renderComments(comments) {
  const list = document.querySelector('#comments-list')

  list.innerHTML = comments
    .map(comment => `<li class="collection-item">${comment.content}</li>`)
    .join('')
}

function renderComment(event) {
  const renderedComment = commentTemplate(event.comment);
  document.querySelector('.collection').innerHTML += renderedComment;
}

function commentTemplate(comment) {
  let userEmail = comment.user ? comment.user.email : "Anonymous";
  return `<li class="collection-item">${comment.content} (<em>${userEmail}</em>)</li>`;
}

window.createSocket = createSocket;