require "rails_helper"

RSpec.describe Post, type: :model do
  let(:user) do
    User.create!(
      username: "darsh",
      email: "darsh@example.com"
    )
  end

  it "is valid with a title, body, category, and user" do
    post = Post.new(
      title: "Ruby Question",
      body: "How do Rails validations work?",
      category: "Ruby",
      user: user
    )

    expect(post).to be_valid
  end

  it "is invalid without a title" do
    post = Post.new(
      title: "",
      body: "This post has a body.",
      category: "Ruby",
      user: user
    )

    expect(post).not_to be_valid
    expect(post.errors[:title]).to include("can't be blank")
  end

  it "is invalid without a body" do
    post = Post.new(
      title: "Ruby Question",
      body: "",
      category: "Ruby",
      user: user
    )

    expect(post).not_to be_valid
    expect(post.errors[:body]).to include("can't be blank")
  end

  it "belongs to a user" do
    post = Post.create!(
      title: "Ruby Question",
      body: "How do Rails validations work?",
      category: "Ruby",
      user: user
    )

    expect(post.user).to eq(user)
  end
end