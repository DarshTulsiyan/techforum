require "rails_helper"

RSpec.describe PostUpvote, type: :model do
  describe "uniqueness" do
    it "allows only one upvote per user and post" do
      user = User.create!(username: "voter", email: "voter@example.com")
      post = Post.create!(title: "Useful post", body: "Helpful content", category: "Ruby", user: user)
      PostUpvote.create!(post: post, user: user)
      duplicate = PostUpvote.new(post: post, user: user)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:user_id]).to include("has already been taken")
    end
  end
end
