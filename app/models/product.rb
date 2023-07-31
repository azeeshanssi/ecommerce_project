class Product < ApplicationRecord
    belongs_to :category
    belongs_to :user
    has_many :cart_items, dependent: :destroy
    has_many :carts, through: :cart_items
    has_many :comments, dependent: :destroy
end
