require "rails_helper"

RSpec.describe Post, type: :model do
  let(:user) { User.create!(username: "darsh", email: "darsh@example.com") }

  it "is valid with a title, body, category, and user" do
    post = Post.new(title: "Ruby Question", body: "How do Rails validations work?",
                    category: "Ruby", user: user)
    expect(post).to be_valid
  end

  it "is invalid without a title" do
    post = Post.new(title: "", body: "This post has a body.", category: "Ruby", user: user)
    expect(post).not_to be_valid
    expect(post.errors[:title]).to include("can't be blank")
  end

  it "is invalid without a body" do
    post = Post.new(title: "Ruby Question", body: "", category: "Ruby", user: user)
    expect(post).not_to be_valid
    expect(post.errors[:body]).to include("can't be blank")
  end

  it "belongs to a user" do
    post = Post.create!(title: "Ruby Question", body: "How do Rails validations work?",
                        category: "Ruby", user: user)
    expect(post.user).to eq(user)
  end

  it "returns the number of upvotes" do
    post = Post.create!(title: "Useful post", body: "Helpful content", category: "Ruby", user: user)
    expect(post.upvotes_count).to eq(0)
    post.post_upvotes.create!(user: user)
    expect(post.upvotes_count).to eq(1)
  end

  it "creates an upvote for a user" do
    post = Post.create!(title: "Useful post", body: "Helpful content", category: "Ruby", user: user)
    expect { post.upvote!(user) }.to change(PostUpvote, :count).by(1)
    expect(post.post_upvotes.last.user).to eq(user)
  end
end
