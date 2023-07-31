# app/policies/buyer_policy.rb
class CategoryPolicy < ApplicationPolicy
    def index?
      true # Everybody is allowed to view
    end
  
    def create?
      user&&(user.admin?)
    end
  
    def update?
      
      
      user&&(user.admin?)
    end
  
    def destroy?
      user&&(user.admin?)
    end
  end