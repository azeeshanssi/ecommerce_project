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
        debugger
        CommentChannel.broadcast_to(product, content: @comment.content)
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
      

      if @comment.update(comment_params)
        
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
    if current_user
      authorize @comment
      @comment.destroy
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
      CommentChannel.broadcast_to("comment_channel", comment: @newcomment)
      redirect_to category_product_path(@category, @product), notice: 'Reply was successfully added.'
    else
      # Handle validation errors if needed
      
      puts @newcomment.errors.full_messages
      redirect_to category_product_path(@category, @product), alert: 'Failed to add reply.'
    end
  end

  def destroy_reply
    @comment = Comment.find(params[:id])
    @comment.destroy
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
