class CommentsController < ApplicationController
  skip_forgery_protection only: :create
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /posts/:post_id/comments
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = User.find_by(username: params.dig(:comment, :username))

    if @comment.user.nil?
      redirect_to_post(alert: "No such user")
    elsif @comment.save
      redirect_to_post(notice: "Comment was successfully created.")
    else
      redirect_to_post(alert: @comment.errors.full_messages.to_sentence)
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: "Comment was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy!
    redirect_to comments_path, notice: "Comment was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.fetch(:comment, {}).permit(:body, :parent_id)
    end

    def redirect_to_post(**_messages)
      self.location = post_url(@post)
      self.response_body = ""
      self.status = :found
    end
end
