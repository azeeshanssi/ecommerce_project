class User < ApplicationRecord
  has_one :cart, dependent: :destroy
  has_many :products
  has_many :comments, dependent: :destroy
  after_create :create_cart_for_user
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  USER_TYPES=['Admin','Buyer','Seller']
  def admin?
    user_type=='Admin'
  end
  def seller?
    user_type=='Seller'
  end
  private

  def create_cart_for_user
    create_cart
  end

  def create_cart
    build_cart.save
  end
end
