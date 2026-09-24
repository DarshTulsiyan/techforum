class HomeController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).limit(5)
  end
end