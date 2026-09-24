require "rails_helper"

RSpec.describe Post, type: :model do
  let!(:user) do
    User.create!(
      username: "darsh",
      email: "darsh@example.com"
    )
  end

  let!(:ruby_tag) { Tag.create!(name: "Ruby") }
  let!(:rails_tag) { Tag.create!(name: "Rails") }
  let!(:database_tag) { Tag.create!(name: "Database") }
  let!(:python_tag) { Tag.create!(name: "Python") }

  let!(:post) do
    Post.create!(
      title: "Ruby and Rails",
      body: "Learning Ruby and Rails",
      category: "Programming",
      user: user
    )
  end

  describe "#related_posts" do
    it "returns posts that share at least one tag" do
      post.tags << [ruby_tag, rails_tag]

      related_post = Post.create!(
        title: "Rails Associations",
        body: "Understanding Rails associations",
        category: "Programming",
        user: user
      )

      related_post.tags << rails_tag

      expect(post.related_posts).to include(related_post)
    end

    it "does not return posts that have no shared tags" do
      post.tags << ruby_tag

      unrelated_post = Post.create!(
        title: "Python Machine Learning",
        body: "Introduction to Python",
        category: "AI",
        user: user
      )

      unrelated_post.tags << python_tag

      expect(post.related_posts).not_to include(unrelated_post)
    end

    it "does not include the current post" do
      post.tags << ruby_tag

      expect(post.related_posts).not_to include(post)
    end

    it "prioritizes posts with more shared tags" do
      post.tags << [ruby_tag, rails_tag, database_tag]

      one_shared_tag = Post.create!(
        title: "Ruby Basics",
        body: "Ruby fundamentals",
        category: "Programming",
        user: user
      )
      one_shared_tag.tags << ruby_tag

      two_shared_tags = Post.create!(
        title: "Rails and Ruby",
        body: "Building Rails applications",
        category: "Programming",
        user: user
      )
      two_shared_tags.tags << [ruby_tag, rails_tag]

      related_posts = post.related_posts.to_a

      expect(related_posts.index(two_shared_tags))
        .to be < related_posts.index(one_shared_tag)
    end

    it "returns no related posts when the post has no tags" do
      expect(post.related_posts).to be_empty
    end
  end
end