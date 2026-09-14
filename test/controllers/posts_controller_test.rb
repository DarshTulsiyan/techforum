require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: { post: {} }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should create a comment on a post" do
    assert_difference("Comment.count") do
      post post_comments_url(@post), params: {
        comment: { username: users(:two).username, body: "Useful post" }
      }
    end

    assert_redirected_to post_url(@post)
    assert_equal @post, Comment.order(:created_at).last.post
  end

  test "should create a reply to a comment" do
    parent = comments(:one)

    assert_difference("Comment.count") do
      post post_comments_url(@post), params: {
        comment: { username: users(:two).username, body: "I agree", parent_id: parent.id }
      }
    end

    assert_equal parent, Comment.order(:created_at).last.parent
  end

  test "should upvote a post once per user" do
    assert_difference("PostUpvote.count") do
      post upvote_post_url(@post), params: { username: users(:two).username }
    end

    assert_no_difference("PostUpvote.count") do
      post upvote_post_url(@post), params: { username: users(:two).username }
    end

    assert_redirected_to post_url(@post)
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: {} }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
