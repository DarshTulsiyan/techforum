require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "replies" do
    it "belongs to a parent comment" do
      user = User.create!(username: "commenter", email: "commenter@example.com")
      post = Post.create!(title: "Ruby discussion", body: "Discuss Ruby", category: "Ruby", user: user)
      parent = Comment.create!(post: post, user: user, body: "Original comment")
      reply = Comment.create!(post: post, user: user, body: "Helpful reply", parent: parent)

      expect(reply.parent).to eq(parent)
      expect(parent.replies).to include(reply)
    end
  end
end
