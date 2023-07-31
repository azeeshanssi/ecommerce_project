# app/policies/buyer_policy.rb
class ProductPolicy < ApplicationPolicy
    def index?
      true # Everybody is allowed to view
    end
  
    def create?
        user_sign_in?
    end
  
    def update?
        user_sign_in?
    end
  
    def destroy?
        user_sign_in?
    end
end