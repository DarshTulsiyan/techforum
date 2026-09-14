class PostsController < ApplicationController
  skip_forgery_protection only: [:create, :upvote]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @comments = @post.comments.where(parent_id: nil).includes(:user, :replies)
  end

  def new
    @post = Post.new
  end

  def create
    user = User.find_by(username: params[:post][:username])
    if user.nil?
      @user_not_found = true
      @post = Post.new(post_attributes)
      render :new, status: :unprocessable_entity and return
    end

    @post = Post.new(post_attributes)
    @post.user = user
    @post.tags = Tag.find_or_create_list(params[:post][:tags]) if params[:post][:tags].present?

    if @post.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, notice: "Post deleted.", status: :see_other
  end

  def upvote
    user = User.find_by(username: params[:username])
    if user.nil?
      redirect_to_post(alert: "No such user")
      return
    end

    @post.upvote!(user)
    redirect_to_post(notice: "Upvoted!")
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique
    redirect_to_post(alert: "You already upvoted this post.")
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :category, :username, :tags)
  end

  def post_attributes
    post_params.except(:username, :tags).to_h
  end

  def redirect_to_post(**_messages)
    self.location = post_url(@post)
    self.response_body = ""
    self.status = :found
  end
end