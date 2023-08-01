class CartItemsController < ApplicationController
    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        redirect_to carts_path, notice: 'Cart item was successfully removed.'
    end
    def new
        
    end
end
