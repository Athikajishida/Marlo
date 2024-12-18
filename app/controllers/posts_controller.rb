# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :find_post, only: %i[like unlike]

  def index
    @posts = Post.page(params[:page]).per(10)
  end

  def show
    
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      redirect_to @post, notice: 'Post created successfully.'
    else
      render :new
    end
  end

  def search
    @query = params[:query]
    @posts = Post.search(@query).page(params[:page]).per(10)
    render :index
  end
 
  def like
    puts "Like action triggered for post #{params[:id]}"
    @post = Post.find(params[:id])
    @post.likes.create(user: current_user)
    render json: { likes_count: @post.likes.count }
  rescue => e
    Rails.logger.error("Error in like action: #{e.message}")
    render json: { error: "Something went wrong" }, status: :unprocessable_entity
  end

  # Optional AJAX-like action for unliking a post
  def unlike
    @post.likes.find_by(user: current_user)&.destroy
    render json: { likes_count: @post.likes.count }
  end

  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end


  def find_post
    @post = Post.find(params[:id])
  end
end