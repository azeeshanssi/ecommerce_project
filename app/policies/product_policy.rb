# app/policies/buyer_policy.rb
class ProductPolicy < ApplicationPolicy
    def index?
      true # Everybody is allowed to view
    end
  
    def create?
      user&&(user.admin?||user.seller?)
    end
  
    def update?
      user&&(user.admin? || (user.seller? && user.id == record.user_id))
    end
  
    def destroy?
        user&&(user.admin? || (user.seller? && user.id == record.user_id))
    end
    def show?
      true
    end
  end