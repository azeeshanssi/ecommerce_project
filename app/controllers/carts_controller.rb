class CartsController < ApplicationController
    def index
        if current_user
            @cart = current_user.cart
            @cart_items = @cart.cart_items.includes(:product)
        else
            flash[:alert] = "Please log in first to view your cart."
            redirect_to new_user_session_path
        end
    end
    def show
        if current_user
            @cart = current_user.cart
            @cart_items = @cart.cart_items.includes(:product)
        else
            flash[:alert] = "Please log in first to view your cart."
            redirect_to new_user_session_path
        end
    end
    def new
        @cart = Cart.new
        @products = Product.all
    end
    
    def create
        @cart = Cart.new(cart_params)
        # Additional code to handle cart creation and validation
    end
    def add_selected_products
        if user_signed_in?
            @cart = current_user.cart
            # selected_product_ids = params[:product_ids] || []
            selected_product_ids = params[:product_ids]
    selected_products_with_quantity = selected_product_ids.map { |id| [id, params["quantity_#{id}"].to_i] }
    
    selected_products_with_quantity.each do |product_id|
                product = Product.find_by(id: product_id) #this I feel is not n+1 as we are only querying for each in the array and not they are not two seperate database queries
                next unless product
                quantity_key = "quantity_#{product.id}"
                quantity = params[quantity_key].to_i
    
                cart_item = CartItem.new(cart: @cart, product: product, quantity: quantity)
                cart_item.save
            end
            redirect_to cart_path(@cart), notice: 'Selected products have been added to the cart.'
        else
    
            redirect_to cart_path(@cart), notice: 'Not added product.'
        end
    end
    def destroy
        @cart.destroy
        redirect_to carts_url, notice: 'Carts was successfully deleted.'
    end
    
    
      
    
     
end
