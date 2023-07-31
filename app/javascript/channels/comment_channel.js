import consumer from "channels/consumer"


// const divElement = document.getElementById('comments');

// // Check the value of the data-product-id attribute
// const productId = divElement?.getAttribute('data-product-id');

// // Now you have the productId, and you can use it as needed
// console.log(productId); // Output: "456"


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
      console.log("I came to create comment",data.product_id)
      const productId=data.product_id;
    // console.log("my product id is is",productId);

    // const commentContainer = document.getElementById("comments"); //here I get all the comments div
    const commentContainer = document.querySelector(`[data-product-id="${productId}"]`);
    const commentContent = data.content; // Here I save the content

    // Create a new element to display the comment
    const commentElement = document.createElement("div"); //here I make a new element 
    commentElement.classList.add("comment"); //here I add the class
    commentElement.innerHTML = `<p>${commentContent}</p>`; //here I make the element but do I add the user?

    // Add the comment element to the comments container
    commentContainer.appendChild(commentElement);
    // console.log("I also came here")

    }
    else if(data.method==="update"){
      console.log("I came to edit comment",data.product_id)
     
      const commentId = data.id;
      console.log("comment id is",commentId)
      const updatedContent = data.content;
      console.log("my updated comment is",updatedContent)
      // const myTimeout = setTimeout(updateContent(commentId,updatedContent), 100000);
      setTimeout(() => {
        updateContent(commentId, updatedContent);
      }, 1000);
      // const commentElement = document.querySelector(`[data-comment-id="${commentId}"]`);
      
      // // const commentElement = document.querySelector(`[data-comment-id="${commentId}"]`);
      // console.log("commentElemeent is",commentElement)
      // if (commentElement) {
      //   console.log("here")
      //   commentElement.querySelector("p").innerText = updatedContent;
      // }



    }
    
    // if(data.id){
    //   console.log('i came here',data.id)
    //   const commentId = data.id;
    //   const commentElement = document.querySelector(`[data-comment-id="${commentId}"]`);
    //   if (commentElement) {
    //     commentElement.remove();
    //   }
    // }
    // else{
    // console.log("I came here",data.product_id);
    // const productId=data.product_id;
    // // console.log("my product id is is",productId);

    // // const commentContainer = document.getElementById("comments"); //here I get all the comments div
    // const commentContainer = document.querySelector(`[data-product-id="${productId}"]`);
    // const commentContent = data.content; // Here I save the content

    // // Create a new element to display the comment
    // const commentElement = document.createElement("div"); //here I make a new element 
    // commentElement.classList.add("comment"); //here I add the class
    // commentElement.innerHTML = `<p>${commentContent}</p>`; //here I make the element but do I add the user?

    // // Add the comment element to the comments container
    // commentContainer.appendChild(commentElement);
    // // console.log("I also came here")
    // // Called when there's incoming data on the websocket for this channel
    // }
  },
  

  speak: function(comment) {
    // return this.perform('speak',{message:comment});
  }
});
