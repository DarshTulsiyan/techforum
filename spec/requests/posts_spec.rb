describe "GET /posts/:id" do
  let!(:user) do
    User.create!(
      username: "darsh",
      email: "darsh@example.com"
    )
  end

  let!(:ruby_tag) { Tag.create!(name: "Ruby") }
  let!(:rails_tag) { Tag.create!(name: "Rails") }

  let!(:post) do
    Post.create!(
      title: "Ruby Question",
      body: "How does Ruby work?",
      category: "Ruby",
      user: user
    )
  end

  it "shows related posts based on shared tags" do
    post.tags << [ruby_tag, rails_tag]

    related_post = Post.create!(
      title: "Rails Associations",
      body: "How do Rails associations work?",
      category: "Rails",
      user: user
    )

    related_post.tags << rails_tag

    get post_path(post)

    expect(response).to have_http_status(:success)
    expect(response.body).to include("Related Posts")
    expect(response.body).to include("Rails Associations")
  end

  it "does not show posts without shared tags as related posts" do
    post.tags << ruby_tag

    unrelated_post = Post.create!(
      title: "Python Question",
      body: "How does Python work?",
      category: "Python",
      user: user
    )

    python_tag = Tag.create!(name: "Python")
    unrelated_post.tags << python_tag

    get post_path(post)

    expect(response).to have_http_status(:success)
    expect(response.body).not_to include("Python Question")
  end

  it "does not show the current post as a related post" do
    post.tags << ruby_tag

    get post_path(post)

    expect(response).to have_http_status(:success)

    # The title can appear once as the main post heading,
    # but the related-post section should not contain it.
    expect(response.body.scan("Ruby Question").length).to eq(1)
  end

  it "does not show the related posts section when there are no matches" do
    get post_path(post)

    expect(response).to have_http_status(:success)
    expect(response.body).not_to include("Related Posts")
  end
end