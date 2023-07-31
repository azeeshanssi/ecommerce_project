    # app/controllers/categories_controller.rb
class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy]
    before_action :authorize_category, except:[:create, :new, :index]
  
    def index
      @categories = Category.all
      if current_user
        if current_user.admin?||current_user.seller?
          authorize @categories
        else
          authorize @categories
        end
      else
        authorize @categories
      end
    end
  
    def new
      @category = Category.new
      if current_user
        if current_user.admin?||current_user.seller?
          authorize @category
        else
        # If not an admin, assume the user is a buyer
          authorize @category
        end
      else
        authorize @category
      end
    end
  
    def create
      @category = Category.new(category_params)
      if current_user
        if current_user.admin?||current_user.seller?
          authorize @category
          if @category.save
            redirect_to categories_path, notice: 'Category was successfully created.'
          else
            render :new
          end

        else
          # If not an admin, assume the user is a buyer
          authorize @category
        end
      else
        authorize @category
      end

      
    end
  
    def edit
      # if current_user
      #   if current_user.admin?||current_user.seller?
      #     authorize @category
      #   else
      #     # If not an admin, assume the user is a buyer
      #     authorize @category
      #   end
      # else
      #   authorize @category
      # end
    end
  
    def update
      
      @category = Category.find(params[:id])
      if current_user
        if current_user.admin?||(current_user.seller?)
          # authorize @category
          if @category.update(category_params)
            redirect_to categories_path, notice: 'Category was successfully updated.'
          else
            render :edit
          end
        # else
          # If not an admin, assume the user is a buyer
          # authorize @category
        end
      # else
      #   authorize @category
      end
      # ...
    end
  
    def destroy
      if current_user
        if current_user.admin?||(current_user.seller?)
          # authorize @category
          @category.destroy
          redirect_to categories_url, notice: 'Category was successfully deleted.'
        # else
        #   # If not an admin, assume the user is a buyer
        #   authorize @category
        end
      # else
      #   authorize @category
      end
      
    end
  

  
    private
  
    def set_category
      @category = Category.find(params[:id])
    end
    def category_params
      params.require(:category).permit(:name, :description)
    end
    def authorize_category
    
      authorize @category
      
    end
end
  

