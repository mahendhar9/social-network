class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy]

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      @post.create_activity key: "post.created", owner: @post.user
      flash.notice = "Post created"
    else
      flash.notice = "Something went wrong"
    end
    redirect_to user_path(@post.user.username)
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to user_path(@post.user.username)
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash.notice = "Post deleted"
    redirect_to(:back)
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
