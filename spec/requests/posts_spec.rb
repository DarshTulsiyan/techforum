require "rails_helper"

RSpec.describe "Posts", type: :request do
  describe "POST /posts" do
    it "creates a post for an existing user" do
      user = User.create!(
        username: "darsh",
        email: "darsh@example.com"
      )

      expect {
        post posts_path, params: {
          post: {
            username: "darsh",
            title: "My First Post",
            body: "This is my first TechForum post.",
            category: "Ruby"
          }
        }
      }.to change(Post, :count).by(1)

      post_created = Post.last

      expect(post_created.title).to eq("My First Post")
      expect(post_created.body).to eq("This is my first TechForum post.")
      expect(post_created.category).to eq("Ruby")
      expect(post_created.user).to eq(user)

      expect(response).to redirect_to(post_path(post_created))
    end

    it "does not create a post when the username does not exist" do
      expect {
        post posts_path, params: {
          post: {
            username: "unknown_user",
            title: "Test Post",
            body: "Some content",
            category: "Ruby"
          }
        }
      }.not_to change(Post, :count)

      expect(response).to have_http_status(:unprocessable_entity)

    end

    it "does not create a post with an empty title" do
        User.create!(
            username: "darsh",
            email: "darsh@example.com"
        )

        expect {
            post posts_path, params: {
            post: {
                username: "darsh",
                title: "",
                body: "This has a body.",
                category: "Ruby"
            }
            }
        }.not_to change(Post, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        end
  end


describe "PATCH /posts/:id" do
  it "updates the post" do
    user = User.create!(
      username: "darsh",
      email: "darsh@example.com"
    )

    post = Post.create!(
      title: "Old Title",
      body: "Old Body",
      category: "Ruby",
      user: user
    )

    patch post_path(post), params: {
      post: {
        title: "Updated Title",
        body: "Updated Body"
      }
    }

    post.reload

    expect(post.title).to eq("Updated Title")
    expect(post.body).to eq("Updated Body")
    expect(response).to redirect_to(post_path(post))
  end
end

describe "DELETE /posts/:id" do
  it "deletes the post" do
    user = User.create!(
      username: "darsh",
      email: "darsh@example.com"
    )

    post = Post.create!(
      title: "Test Post",
      body: "Test Body",
      category: "Ruby",
      user: user
    )

    expect {
      delete post_path(post)
    }.to change(Post, :count).by(-1)

    expect(response).to redirect_to(posts_path)
  end
end
end