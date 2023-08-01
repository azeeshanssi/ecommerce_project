class CommentsController < ApplicationController
  before_action :set_comment
  
  def create
    @comment = @product.comments.build(comment_params)
    # @product = Product.find(params[:product_id])
    if current_user
      authorize @comment
     
      @comment.user = current_user # Assuming you have set up user authentication
      product = Product.find(params[:product_id])
      
      if @comment.save
        # CommentChannel.broadcast_to("comment_channel", { product_id: @product.id, content: @comment.content })


        # CommentChannel.broadcast_to(product, content: @comment.content) #this was working
        # CommentChannel.broadcast_to("comment_channel", { product_id: @product.id, content: @comment.content })
        ActionCable.server.broadcast 'comment_channel', { product_id: product.id, content: @comment.content, method: "new" } #this aswell
        redirect_to category_product_path(@category, @product), notice: 'Comment was successfully added.'
        
      else
       
        redirect_to category_product_path(@category, @product), alert: 'Failed to add comment.'
      end
    else
      authorize @comment
    end
  end
  def show
  end
  def edit
    @category = Category.find(params[:category_id])
    @product = Product.find(params[:product_id])
    @comment = Comment.find(params[:id])
    if current_user
      authorize @comment
     
    else
      authorize @comment
    end
  end
  
  def update
    @category = Category.find(params[:category_id])
    @product = Product.find(params[:product_id])
    @comment = Comment.find(params[:id])
    if current_user
      authorize @comment
      product = Product.find(params[:product_id])
      if @comment.update(comment_params)
        
        ActionCable.server.broadcast 'comment_channel', { product_id: product.id, content: @comment.content,id:@comment.id, method: "update" }
        redirect_to category_product_path(@category, @product), notice: 'Comment was successfully updated.'
      else
        render :edit
      end
    else
      authorize @comment
    end
  end
  
  def destroy
   
    @comment=Comment.find(params[:id])
    product = Product.find(params[:product_id])
      
    if current_user
      authorize @comment
      @comment.destroy
      ActionCable.server.broadcast 'comment_channel', { product_id: product.id, content: @comment.content,id:@comment.id, method: "delete" } #this aswell
      redirect_to category_product_path(@category, @product), notice: 'Comment was successfully deleted.'
    else
      authorize @comment
    end
  end

  def create_reply
   
    @comment = Comment.find(params[:id]) 
  
    parent_comment = Comment.find(params[:id])
    @newcomment = parent_comment.replies.build(comment_params)
    @newcomment.product_id = params[:product_id]
    @newcomment.user = current_user # Assuming you have set up user authentication
    


    if @newcomment.save
      ActionCable.server.broadcast 'reply_channel', { comment_id: @comment.id, content: @newcomment.content, reply_id: @newcomment.id, user_name: @newcomment.user.name, method:"new" }
      redirect_to category_product_path(@category, @product), notice: 'Reply was successfully added.'
    else
      # Handle validation errors if needed
      
      puts @newcomment.errors.full_messages
      redirect_to category_product_path(@category, @product), alert: 'Failed to add reply.'
    end
  end

  def destroy_reply
    @comment = Comment.find(params[:id])
    @parentcomment=Comment.find(@comment.parent_comment_id)
    @comment.destroy
    ActionCable.server.broadcast 'reply_channel', { comment_id: @parentcomment.id, reply_id: @comment.id, method: 'delete' }
    redirect_to category_product_path(@comment.product.category, @comment.product), notice: 'Reply was successfully deleted.'
  end

  private

  def set_comment
    
    @category = Category.find(params[:category_id])
    @product = Product.find(params[:product_id])
   
  end
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end
