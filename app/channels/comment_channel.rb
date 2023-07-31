class CommentChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # stream_from "comment_channel"
    
    product_id = params[:product_id]
    
    @product = Product.find_by(id: product_id)
    if @product
      stream_for @product
    else
      reject
    end


  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # Comment.create! content: data['comment']
  end
end
