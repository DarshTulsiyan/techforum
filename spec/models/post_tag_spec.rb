require "rails_helper"

RSpec.describe PostTag, type: :model do
  it "belongs to a post and a tag" do
    user = User.create!(username: "tagger", email: "tagger@example.com")
    post = Post.create!(title: "Tagged post", body: "Body", category: "Ruby", user: user)
    tag = Tag.create!(name: "Ruby")
    post_tag = PostTag.create!(post: post, tag: tag)

    expect(post_tag.post).to eq(post)
    expect(post_tag.tag).to eq(tag)
  end
end
