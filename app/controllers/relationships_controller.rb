# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed # CHECK
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def relationship_params
    params.require(:relationships).permit(:fo)
  end
end
