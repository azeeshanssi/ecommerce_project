import consumer from "channels/consumer"





const updateContent = (commentId, updatedContent) => {
  console.log(commentId)
  const commentElement = document.querySelector(`[data-comment-id="${commentId}"] .comment-content`);
  console.log("commentElement is", commentElement);
  console.log(updatedContent)

  if (commentElement) {
    console.log("here");
    commentElement.innerText = updatedContent;
  }
};

function addReplyForm(commentContainer, commentId, categoryId, productId) {
  const replyFormContainer = document.createElement("div");
  replyFormContainer.classList.add("reply-form");

  const replyForm = document.createElement("form");
  replyForm.action = `/categories/${categoryId}/products/${productId}/comments/${commentId}/create_reply`;
  replyForm.method = "post";

  const replyTextArea = document.createElement("textarea");
  replyTextArea.name = "content";
  replyTextArea.classList.add("form-textarea");

  replyForm.appendChild(replyTextArea);
  replyFormContainer.appendChild(replyForm);

  const submitButton = document.createElement("input");
  submitButton.type = "submit";
  submitButton.value = "Add Reply";
  submitButton.classList.add("bg-blue-500", "text-white", "font-bold", "px-4", "py-2", "rounded");
  replyFormContainer.appendChild(submitButton);

  commentContainer.appendChild(replyFormContainer);
}



consumer.subscriptions.create("CommentChannel" ,{
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connection made")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },
 
  received(data) {
    console.log("I came here with method",data.method)
    if(data.method==="delete"){
      console.log('i came here',data.id)
      const commentId = data.id;
      const commentElement = document.querySelector(`[data-comment-id="${commentId}"]`);
      console.log("my comment ELement is",commentElement)
      if (commentElement) {
        commentElement.remove();
      }
    }
    else if(data.method==="new"){
      const UserName=data.user_name
      console.log("I came to create comment",data.product_id)
      const productId=data.product_id;
    

   
    const commentContainer = document.querySelector(`[data-product-id="${productId}"]`);
    const commentContent = data.content; // Here I save the content

    // Create a new element to display the comment
    const commentElement = document.createElement("div"); //here I make a new element 
    commentElement.classList.add("comment"); //here I add the class
  
    commentElement.innerHTML = `
    <div>
      <p class="user-name">${UserName}</p> 
      <span>${commentContent}</span>
      ${
        
           `<a href="/categories/${data.category_id}/products/${data.product_id}/comments/${data.id}/edit" class="text-blue-500 font-bold mr-2">Edit</a>
            <a href="/categories/${data.category_id}/products/${data.product_id}/comments/${data.id}" data-turbo-method="delete" class="text-red-500 font-bold">Delete</a>`
          
      }
    </div>
  `;
   
    commentContainer.appendChild(commentElement);
    addReplyForm(commentContainer, data.id, data.category_id, data.product_id);
  
    }
    else if(data.method==="update"){
      console.log("I came to edit comment",data.product_id)
     
      const commentId = data.id;
      console.log("comment id is",commentId)
      const updatedContent = data.content;
      console.log("my updated comment is",updatedContent)
      
      setTimeout(() => {
        updateContent(commentId, updatedContent);
      }, 1000);
      



    }
    
   
  },
  

  speak: function(comment) {
    
  }
});
