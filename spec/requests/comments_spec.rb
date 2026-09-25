require "rails_helper"

RSpec.describe "Comments", type: :request do
  let!(:author) { User.create!(username: "author", email: "author@example.com") }
  let!(:commenter) { User.create!(username: "commenter", email: "commenter@example.com") }
  let!(:post_record) do
    Post.create!(
      title: "Ruby discussion",
      body: "Discuss Ruby",
      category: "Ruby",
      user: author
    )
  end

  describe "POST /posts/:post_id/comments" do

        it "does not create a comment when the body is empty" do
      expect {
        post post_comments_path(post_record), params: {
          comment: {
            username: commenter.username,
            body: ""
          }
        }
      }.not_to change(Comment, :count)

      expect(response).to redirect_to(post_path(post_record))
    end

    it "does not create a reply when the body is empty" do
      parent = Comment.create!(
        post: post_record,
        user: author,
        body: "Original comment"
      )

      expect {
        post post_comments_path(post_record), params: {
          comment: {
            username: commenter.username,
            body: "",
            parent_id: parent.id
          }
        }
      }.not_to change(Comment, :count)

      expect(response).to redirect_to(post_path(post_record))
    end

    it "creates a comment on a post" do
      expect {
        post post_comments_path(post_record), params: {
          comment: { username: commenter.username, body: "Useful comment" }
        }
      }.to change(Comment, :count).by(1)

      created_comment = Comment.order(:created_at).last

      expect(created_comment.post).to eq(post_record)
      expect(created_comment.user).to eq(commenter)
      expect(created_comment.body).to eq("Useful comment")
      expect(created_comment.parent).to be_nil
      expect(response).to redirect_to(post_path(post_record))
    end

    it "creates a reply to an existing comment" do
      parent = Comment.create!(post: post_record, user: author, body: "Original comment")

      expect {
        post post_comments_path(post_record), params: {
          comment: {
            username: commenter.username,
            body: "Helpful reply",
            parent_id: parent.id
          }
        }
      }.to change(Comment, :count).by(1)

      reply = Comment.order(:created_at).last

      expect(reply.parent).to eq(parent)
      expect(parent.replies).to include(reply)
      expect(response).to redirect_to(post_path(post_record))
    end
  end
end
