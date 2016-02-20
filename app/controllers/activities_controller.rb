class ActivitiesController < ApplicationController
  def index
    @users = current_user.active_friends
    @users.push(current_user)
    @activities = PublicActivity::Activity.where(owner: @users).order('created_at DESC')
  end
end
