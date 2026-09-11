class Post < ApplicationRecord
  belongs_to :user

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_upvotes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def upvotes_count = post_upvotes.count
end
