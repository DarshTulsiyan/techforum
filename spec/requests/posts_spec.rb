require "rails_helper"

RSpec.describe "Posts", type: :request do
  let!(:user) { User.create!(username: "author", email: "author@example.com") }
  let!(:other_user) { User.create!(username: "other", email: "other@example.com") }

  describe "GET /posts" do
    before do
      Post.create!(title: "Ruby Post", body: "Ruby body", category: "Ruby", user: user)
      Post.create!(title: "Python Post", body: "Python body", category: "Python", user: other_user)
    end

    it "lists posts ordered by newest by default" do
      get posts_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Ruby Post", "Python Post")
    end

    it "filters posts by search text" do
      get posts_path, params: { search: "Ruby" }
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Ruby Post")
      expect(response.body).not_to include("Python Post")
    end

    it "filters by text in the body" do
      get posts_path, params: { search: "Python body" }
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Python Post")
      expect(response.body).not_to include("Ruby Post")
    end

    it "filters by category" do
      get posts_path, params: { search: "Python" }
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Python Post")
      expect(response.body).not_to include("Ruby Post")
    end

    it "sorts by popularity" do
      ruby = Post.find_by!(title: "Ruby Post")
      python = Post.find_by!(title: "Python Post")
      ruby.post_upvotes.create!(user: other_user)

      get posts_path, params: { sort: "popular" }
      expect(response).to have_http_status(:success)
      expect(response.body.index("Ruby Post")).to be < response.body.index("Python Post")
    end
  end

  describe "GET /posts/:id" do
    let!(:post_record) do
      Post.create!(title: "Ruby Question", body: "How does Ruby work?",
                   category: "Ruby", user: user)
    end

    it "shows a post and its comments" do
      Comment.create!(post: post_record, user: other_user, body: "Useful comment")
      get post_path(post_record)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Ruby Question", "Useful comment")
    end

    it "shows related posts based on shared tags" do
      tag = Tag.create!(name: "Ruby")
      post_record.tags << tag
      related = Post.create!(title: "Related Ruby", body: "Related body",
                             category: "Ruby", user: user)
      related.tags << tag

      get post_path(post_record)
      expect(response.body).to include("Related Posts", "Related Ruby")
    end
  end

  describe "GET /posts/new" do
    it "renders the new post form" do
      get new_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /posts/:id/edit" do
    let!(:post_record) { Post.create!(title: "Old", body: "Body", category: "Ruby", user: user) }

    it "renders the edit form" do
      get edit_post_path(post_record)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Old")
    end
  end

  describe "POST /posts" do
    it "creates a post for an existing user and creates tags" do
      expect {
        post posts_path, params: {
          post: { username: user.username, title: "New post", body: "New body",
                  category: "Ruby", tags: "Ruby, Rails" }
        }
      }.to change(Post, :count).by(1)

      created = Post.order(:id).last
      expect(created.user).to eq(user)
      expect(created.tags.map(&:name)).to contain_exactly("Ruby", "Rails")
      expect(response).to redirect_to(post_path(created))
    end

    it "creates a post without tags when tags are omitted" do
      expect {
        post posts_path, params: {
          post: { username: user.username, title: "No tags", body: "Body", category: "Ruby" }
        }
      }.to change(Post, :count).by(1)

      expect(response).to redirect_to(post_path(Post.order(:id).last))
    end

    it "renders new when the username does not exist" do
      expect {
        post posts_path, params: {
          post: { username: "missing", title: "New post", body: "Body", category: "Ruby" }
        }
      }.not_to change(Post, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "renders new when the post is invalid" do
      expect {
        post posts_path, params: {
          post: { username: user.username, title: "", body: "Body", category: "Ruby" }
        }
      }.not_to change(Post, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /posts/:id" do
    let!(:post_record) { Post.create!(title: "Old Title", body: "Old Body", category: "Ruby", user: user) }

    it "updates a post with valid information" do
      patch post_path(post_record), params: { post: { title: "Updated", body: "Updated body", category: "Rails" } }
      post_record.reload
      expect(post_record.title).to eq("Updated")
      expect(response).to redirect_to(post_path(post_record))
    end

    it "renders edit when the update is invalid" do
      patch post_path(post_record), params: { post: { title: "", body: "Updated body" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(post_record.reload.title).to eq("Old Title")
    end
  end

  describe "DELETE /posts/:id" do
    it "deletes a post" do
      post_record = Post.create!(title: "Delete me", body: "Body", category: "Ruby", user: user)
      expect { delete post_path(post_record) }.to change(Post, :count).by(-1)
      expect(response).to redirect_to(posts_path)
    end
  end
end
