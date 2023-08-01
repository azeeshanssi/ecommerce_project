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
    const newCommentId = data.comment_id;
    const newContent = data.content;
    const newUserName = data.user_name;
    const commentElement = document.querySelector(`[data-comment-id="${newCommentId}"]`);

    if (commentElement) {
      // Append the new reply to the comment element
      console.log("also came here")
      const newReplyElement = document.createElement('div');
      newReplyElement.innerHTML = `
        <div>
          <pclass="user-name">${newUserName}</p> 
          <span>${newContent}</span>
        </div>
      `;
      commentElement.appendChild(newReplyElement);
    }
    // Called when there's incoming data on the websocket for this channel
  }
});
