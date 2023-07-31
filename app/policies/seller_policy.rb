# app/policies/buyer_policy.rb
class BuyerPolicy < ApplicationPolicy
    def index?
      true # Allow buyers to view all products and categories
    end
  
    def create?
      true # Buyers are not allowed to create new products or categories
    end
  
    def update?
      true # Buyers are not allowed to update existing products or categories
    end
  
    def destroy?
      true # Buyers are not allowed to delete products or categories
    end
  end
  