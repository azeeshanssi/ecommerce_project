import consumer from "channels/consumer"

consumer.subscriptions.create("ReplyChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const newCommentId = data.comment_id;
    const newContent = data.content;
    const commentElement = document.querySelector(`[data-comment-id="${newCommentId}"]`);

    if (commentElement) {
      // Append the new reply to the comment element
      const newReplyElement = document.createElement('div');
      newReplyElement.innerHTML = `<div>${newContent}</div>`;
      commentElement.appendChild(newReplyElement);
    }
    // Called when there's incoming data on the websocket for this channel
  }
});
