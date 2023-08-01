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
      
      const newReplyElement = document.createElement('div');
      newReplyElement.setAttribute('data-reply-id', data.reply_id);
      newReplyElement.innerHTML = `
        <div>
          <p class="user-name">${newUserName}</p> 
          <span>${newContent}</span>
          ${
            
               `<a href="/categories/${data.category_id}/products/${data.product_id}/comments/${data.id}/edit" class="text-blue-500 font-bold mr-2">Edit</a>
                <a href="/categories/${data.category_id}/products/${data.product_id}/comments/${data.id}" data-turbo-method="delete" class="text-red-500 font-bold">Delete</a>`
              
          }
        </div>
      `;
      commentElement.appendChild(newReplyElement);
    }}
    // Called when there's incoming data on the websocket for this channel
  }
});
