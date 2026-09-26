require "rails_helper"

RSpec.describe "Post upvotes", type: :request do
  let!(:author) { User.create!(username: "author", email: "author@example.com") }
  let!(:voter) { User.create!(username: "voter", email: "voter@example.com") }
  let!(:post_record) { Post.create!(title: "Useful post", body: "Helpful content", category: "Ruby", user: author) }

  describe "POST /posts/:id/upvote" do
    it "creates an upvote" do
      expect {
        post upvote_post_path(post_record), params: { username: voter.username }
      }.to change(PostUpvote, :count).by(1)
      expect(response).to redirect_to(post_path(post_record))
    end

    it "rejects an unknown user" do
      expect {
        post upvote_post_path(post_record), params: { username: "missing" }
      }.not_to change(PostUpvote, :count)
      expect(response).to redirect_to(post_path(post_record))
    end

    it "rejects a duplicate upvote" do
      post_record.post_upvotes.create!(user: voter)

      expect {
        post upvote_post_path(post_record), params: { username: voter.username }
      }.not_to change(PostUpvote, :count)
      expect(response).to redirect_to(post_path(post_record))
    end
  end
end
