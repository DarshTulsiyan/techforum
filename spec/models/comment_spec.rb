require "rails_helper"

RSpec.describe Comment, type: :model do
  let!(:user) do
    User.create!(
      username: "commenter",
      email: "commenter@example.com"
    )
  end

  let!(:post_record) do
    Post.create!(
      title: "Ruby discussion",
      body: "Discuss Ruby",
      category: "Ruby",
      user: user
    )
  end

  describe "associations" do
    it "belongs to a post" do
      comment = Comment.new(
        post: post_record,
        user: user,
        body: "Test comment"
      )

      expect(comment.post).to eq(post_record)
    end

    it "belongs to a user" do
      comment = Comment.new(
        post: post_record,
        user: user,
        body: "Test comment"
      )

      expect(comment.user).to eq(user)
    end

    it "can have a parent comment" do
      parent = Comment.create!(
        post: post_record,
        user: user,
        body: "Original comment"
      )

      reply = Comment.create!(
        post: post_record,
        user: user,
        parent: parent,
        body: "This is a reply"
      )

      expect(reply.parent).to eq(parent)
    end

    it "can have replies" do
      parent = Comment.create!(
        post: post_record,
        user: user,
        body: "Original comment"
      )

      reply = Comment.create!(
        post: post_record,
        user: user,
        parent: parent,
        body: "This is a reply"
      )

      expect(parent.replies).to include(reply)
    end
  end

  describe "validations" do
    it "is valid with a body" do
      comment = Comment.new(
        post: post_record,
        user: user,
        body: "This is a comment"
      )

      expect(comment).to be_valid
    end

    it "is invalid when the comment body is empty" do
      comment = Comment.new(
        post: post_record,
        user: user,
        body: ""
      )

      expect(comment).not_to be_valid
      expect(comment.errors[:body]).to include("can't be blank")
    end

    it "is invalid when the reply body is empty" do
      parent = Comment.create!(
        post: post_record,
        user: user,
        body: "Original comment"
      )

      reply = Comment.new(
        post: post_record,
        user: user,
        parent: parent,
        body: ""
      )

      expect(reply).not_to be_valid
      expect(reply.errors[:body]).to include("can't be blank")
    end
  end

  describe "reply relationships" do
    it "allows multiple replies to a comment" do
      parent = Comment.create!(
        post: post_record,
        user: user,
        body: "Original comment"
      )

      reply1 = Comment.create!(
        post: post_record,
        user: user,
        parent: parent,
        body: "First reply"
      )

      reply2 = Comment.create!(
        post: post_record,
        user: user,
        parent: parent,
        body: "Second reply"
      )

      expect(parent.replies).to contain_exactly(reply1, reply2)
    end
  end
end