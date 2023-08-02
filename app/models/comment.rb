class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :product
  belongs_to :parent_comment, class_name: 'Comment', foreign_key: 'parent_comment_id', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_comment_id', dependent: :destroy
end
