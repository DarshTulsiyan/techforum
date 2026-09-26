require "rails_helper"

RSpec.describe "Home", type: :request do
  it "shows the five newest posts" do
    user = User.create!(username: "homeuser", email: "home@example.com")
    6.times do |i|
      Post.create!(title: "Post #{i}", body: "Body #{i}", category: "Ruby", user: user)
    end

    get root_path

    expect(response).to have_http_status(:success)
    expect(response.body).to include("Post 5")
    expect(response.body).not_to include("Post 0")
  end
end
