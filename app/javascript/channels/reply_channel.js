import consumer from "channels/consumer"

consumer.subscriptions.create("ReplyChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("came here")
    if (data.method === 'delete') {
      console.log("Came into delete")
      const replyId = data.reply_id;
      console.log("My reply id is",replyId)
      const replyElement = document.querySelector(`[data-reply-id="${replyId}"]`);
      console.log(replyElement)
      if (replyElement) {
        replyElement.remove();
      }
    }
    if(data.method==="new")
    {
    const newCommentId = data.comment_id;
    const newContent = data.content;
    const newUserName = data.user_name;
    const commentElement = document.querySelector(`[data-comment-id="${newCommentId}"]`);

    if (commentElement) {
      // Append the new reply to the comment element
      console.log("also came here")
      newReplyElement.setAttribute('data-reply-id', data.reply_id);
      const newReplyElement = document.createElement('div');
      newReplyElement.innerHTML = `
        <div>
          <p class="user-name">${newUserName}</p> 
          <span>${newContent}</span>
        </div>
      `;
      commentElement.appendChild(newReplyElement);
    }}
    // Called when there's incoming data on the websocket for this channel
  }
});
