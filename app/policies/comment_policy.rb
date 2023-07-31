# app/policies/buyer_policy.rb
class CommentPolicy < ApplicationPolicy
    def index?
      true # Everybody is allowed to view
    end
  
    def create?
      user
    end
  
    def update?
      user&&(user.admin?||((user.id == record.user_id)))
    end
  
    def destroy?
      user&&(user.admin?||((user.id == record.user_id)))
    end
  end