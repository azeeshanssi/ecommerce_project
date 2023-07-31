# app/policies/buyer_policy.rb
class BuyerPolicy < ApplicationPolicy
    def index?
      true # Allow buyers to view all products and categories
    end
  
    def create?
      false # Buyers are not allowed to create new products or categories
    end
  
    def update?
      false # Buyers are not allowed to update existing products or categories
    end
  
    def destroy?
      false # Buyers are not allowed to delete products or categories
    end
  end
  