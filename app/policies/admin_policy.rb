# app/policies/admin_policy.rb
class AdminPolicy < ApplicationPolicy
    def index?
      true # Allow admins to view all products and categories
    end
  
    def create?
      true # Allow admins to create new products or categories
    end
  
    def update?
      true # Allow admins to update existing products or categories
    end
  
    def destroy?
      true # Allow admins to delete products or categories
    end
  end
  