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


describe "PATCH /posts/:id" do
  let!(:user) do
    User.create!(
      username: "darsh",
      email: "darsh@example.com"
    )
  end

  let!(:post) do
    Post.create!(
      title: "Old Title",
      body: "Old Body",
      category: "Ruby",
      user: user
    )
  end

  it "updates a post with valid information" do
    patch post_path(post), params: {
      post: {
        title: "Updated Title",
        body: "Updated Body",
        category: "Rails"
      }
    }

    post.reload

    expect(post.title).to eq("Updated Title")
    expect(post.body).to eq("Updated Body")
    expect(post.category).to eq("Rails")
    expect(response).to redirect_to(post_path(post))
  end

  it "does not update a post with an empty title" do
    patch post_path(post), params: {
      post: {
        title: "",
        body: "Updated Body"
      }
    }

    post.reload

    expect(post.title).to eq("Old Title")
    expect(post.body).to eq("Old Body")
    expect(response).to have_http_status(:unprocessable_content)
  end

  it "does not update a post with an empty body" do
    patch post_path(post), params: {
      post: {
        title: "Updated Title",
        body: ""
      }
    }

    post.reload

    expect(post.title).to eq("Old Title")
    expect(post.body).to eq("Old Body")
    expect(response).to have_http_status(:unprocessable_content)
  end
end

describe "DELETE /posts/:id" do
  let!(:user) do
    User.create!(
      username: "darsh",
      email: "darsh@example.com"
    )
  end

  let!(:post) do
    Post.create!(
      title: "Test Post",
      body: "Test Body",
      category: "Ruby",
      user: user
    )
  end

  it "deletes an existing post" do
    expect {
      delete post_path(post)
    }.to change(Post, :count).by(-1)

    expect(response).to redirect_to(posts_path)
    expect(Post.exists?(post.id)).to be false
  end

  it "does not delete other posts" do
    another_post = Post.create!(
      title: "Another Post",
      body: "Another Body",
      category: "Python",
      user: user
    )

    delete post_path(post)

    expect(Post.exists?(post.id)).to be false
    expect(Post.exists?(another_post.id)).to be true
  end
end


end
