class CommentChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "comment_channel"
    
    # product_id = params[:product_id]
    
    # @product = Product.find_by(id: product_id)
    # if @product
    #   stream_for @product
    # else
    #   reject
    # end



  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # Comment.create! content: data['comment']
  end
  #new added might be removed later
  # def broadcast_comment(data)
  #   # Process the data as needed
  #   product_id = data["product_id"]
  #   content = data["content"]

  #   # Broadcast the comment to the stream "comment_channel"
  #   ActionCable.server.broadcast("comment_channel", { product_id: product_id, content: content })
  # end
end
