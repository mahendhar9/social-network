class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :get_counts, only: [:index]

  def index
    case params[:show] 
    when "friends"
      @users = current_user.active_friends
    when "requested"
      @users = current_user.pending_sent_requests.map(&:friend)
    when "pending"
      @users = current_user.pending_received_requests.map(&:user)
    else
      @users = User.where.not(id: current_user.id)
    end
  end

  def show
    @activities = PublicActivity::Activity.where(owner: @user) + PublicActivity::Activity.where(recipient: @user)
  end

  private

  def find_user
    @user = User.find_by(username: params[:id])
  end

  def get_counts
    @friends_count = current_user.active_friends.size
    @pending_sent_requests_count = current_user.pending_sent_requests.map(&:friend).size
  end
end
