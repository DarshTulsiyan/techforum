class User < ApplicationRecord
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :post_upvotes, dependent: :destroy

	validates :username, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true
end
