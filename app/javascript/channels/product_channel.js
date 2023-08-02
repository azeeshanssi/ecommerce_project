import consumer from "channels/consumer"

consumer.subscriptions.create("ProductChannel", {
  connected() {
    console.log("connected to this channel")
    // Called when the subscription is ready for use on the server

  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const productId = data.product_id;
    console.log(productId)
    const productElement = document.querySelector(`[data-myproduct-id="${productId}"]`);
    console.log(productElement)
    productElement.innerHTML=data.price
    // Called when there's incoming data on the websocket for this channel
  }
});
