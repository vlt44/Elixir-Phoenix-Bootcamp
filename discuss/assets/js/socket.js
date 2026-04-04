import { Socket } from "phoenix"

let socket = new Socket("/socket", {params: { token: window.userToken }})
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
    .map(comment => commentTemplate(comment))
    .join('')
}

function renderComment(event) {
  const renderedComment = commentTemplate(event.comment);
  document.querySelector('#comments-list').innerHTML += renderedComment;
}

function commentTemplate(comment) {
  let content = comment.content;
  let userInfo = comment.user_email ? `(${comment.user_email})` : "Anonymous";
  return `<li class="collection-item">${content} ${userInfo}</li>`;
}

window.createSocket = createSocket;