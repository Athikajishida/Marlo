class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :set_comment, only: [:destroy, :edit]

  def create
    puts "Params received: #{params.inspect}"
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: "Comment added successfully."
    else
      @comments = @post.comments.includes(:user)
      flash.now[:alert] = "Failed to add comment."
      render "posts/show"
    end
  end

  def edit
    authorize_comment_action("edit")
    if @comment.update(comment_params)
      redirect_to @post, notice: "Comment updated successfully."
    else
      redirect_to @post, alert: "Failed to update comment."
    end
  end

  def destroy
    authorize_comment_action("delete")
    if @comment.destroy
      redirect_to @post, notice: "Comment deleted successfully."
    else
      redirect_to @post, alert: "Failed to delete comment."
    end
  end

  private

  def find_post
    @post = Post.friendly.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: "Post not found."
  end
  def set_comment
    @comment = @post.comments.find_by(id: params[:id])
    redirect_to @post, alert: "Comment not found." unless @comment
  end

  def authorize_comment_action(action)
    unless @comment.user == current_user
      redirect_to @post, alert: "You are not authorized to #{action} this comment."
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
