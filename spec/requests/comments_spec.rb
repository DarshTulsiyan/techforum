require "rails_helper"

RSpec.describe "Comments", type: :request do
  let!(:author) { User.create!(username: "author", email: "author@example.com") }
  let!(:commenter) { User.create!(username: "commenter", email: "commenter@example.com") }
  let!(:post_record) { Post.create!(title: "Ruby discussion", body: "Discuss Ruby", category: "Ruby", user: author) }

  describe "POST /posts/:post_id/comments" do
    it "creates a comment" do
      expect {
        post post_comments_path(post_record), params: {
          comment: { username: commenter.username, body: "Useful comment" }
        }
      }.to change(Comment, :count).by(1)
      expect(response).to redirect_to(post_path(post_record))
    end

    it "creates a reply" do
      parent = Comment.create!(post: post_record, user: author, body: "Original")
      expect {
        post post_comments_path(post_record), params: {
          comment: { username: commenter.username, body: "Reply", parent_id: parent.id }
        }
      }.to change(Comment, :count).by(1)
      expect(Comment.order(:id).last.parent).to eq(parent)
    end

    it "redirects when the user does not exist" do
      expect {
        post post_comments_path(post_record), params: {
          comment: { username: "missing", body: "Comment" }
        }
      }.not_to change(Comment, :count)
      expect(response).to redirect_to(post_path(post_record))
    end

    it "redirects when the comment is invalid" do
      expect {
        post post_comments_path(post_record), params: {
          comment: { username: commenter.username, body: "" }
        }
      }.not_to change(Comment, :count)
      expect(response).to redirect_to(post_path(post_record))
    end
  end

  describe "GET /comments" do
  it "lists comments" do
    get comments_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Comments")
    expect(response.body).to include("Show this comment")
  end
end

describe "GET /comments/:id" do
  it "shows a comment" do
    user = User.create!(
      username: "showuser",
      email: "showuser@example.com"
    )

    post = Post.create!(
      title: "Show comment post",
      body: "Post body",
      category: "Ruby",
      user: user
    )

    comment = Comment.create!(
      post: post,
      user: user,
      body: "Shown comment"
    )

    get comment_path(comment)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Edit this comment")
    expect(response.body).to include("Destroy this comment")
    expect(response.body).to include("Back to comments")
  end
end

  describe "GET /comments/new" do
    it "renders the new comment form" do
      get new_comment_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /comments/:id/edit" do
    it "renders the edit comment form" do
      comment = Comment.create!(post: post_record, user: commenter, body: "Editable comment")
      get edit_comment_path(comment)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /comments/:id" do
    it "updates a comment" do
      comment = Comment.create!(post: post_record, user: commenter, body: "Old comment")
      patch comment_path(comment), params: { comment: { body: "Updated comment" } }
      expect(response).to redirect_to(comment_path(comment))
      expect(comment.reload.body).to eq("Updated comment")
    end

    it "renders edit when the comment is invalid" do
      comment = Comment.create!(post: post_record, user: commenter, body: "Old comment")
      patch comment_path(comment), params: { comment: { body: "" } }
      expect(response).to have_http_status(:unprocessable_content)
      expect(comment.reload.body).to eq("Old comment")
    end
  end

  describe "DELETE /comments/:id" do
    it "deletes a comment" do
      comment = Comment.create!(post: post_record, user: commenter, body: "Delete me")
      expect { delete comment_path(comment) }.to change(Comment, :count).by(-1)
      expect(response).to redirect_to(comments_path)
    end
  end
end
