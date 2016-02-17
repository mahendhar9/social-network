class FriendshipsController < ApplicationController

  before_action :find_user, only: [:create, :update, :destroy]
  before_action :find_friendship, only: [:update, :destroy]

  def create
    current_user.request_friendship(@user)
    flash.notice = "Friend Request sent to #{@user.username}"
    redirect_to users_path
  end

  def destroy
    @friendship.destroy
    unless params[:cancel_request]
      flash.notice = "You are no longer friends with #{@user.username}"
    else
      flash.notice = "Request to #{@user.username} cancelled"
    end
    redirect_to users_path
  end

  def update
    @friendship.accept_friendship
    flash.notice = "You are now friends with #{@user.username}"
    redirect_to users_path

  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end

  def find_friendship
    @friendship = Friendship.find(params[:id])
  end
end
