class ProductsController < ApplicationController
  before_action :set_category
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize_product, except:[:create, :new, :index, :show]

  def index
    @products = @category.products
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = @category.products.new
  end

  def create
    @product = @category.products.new(product_params)
    @product.user_id=current_user.id
    if current_user
      if current_user.admin?||current_user.seller?
        authorize @product
        if @product.save
          redirect_to category_product_path(@category, @product), notice: 'Product was successfully created.'
        else
          render :new
        end
      else
        authorize @product
      end
    else
      authorize @product
    end


  end

  def edit
  end

  def update
    if current_user
      if current_user.admin?||(current_user.seller?)
        # authorize @product
        if @product.update(product_params)
        redirect_to category_product_path(@category, @product), notice: 'Product was successfully updated.'
        else
        render :edit
        end
    #   else
    #     authorize @product
       end
    # else
    #   authorize @product
     end

  end

  def destroy
    if current_user
      if current_user.admin?||(current_user.seller?)
        # authorize @product
        @product.destroy
        redirect_to category_products_path(@category), notice: 'Product was successfully deleted.'
      # else
      #   authorize @product
      end
    # else
    #   authorize @product
    end
  end


  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_product
    @product = @category.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
  def authorize_product
    authorize @product
  end
end
