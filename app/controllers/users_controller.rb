# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user,             only: %i[show edit update destroy
                                                 followers following]
  before_action :logged_in_user,        only: %i[index edit update destroy
                                                 followers following]
  before_action :frendly_redirect,      only: %i[edit update]
  before_action :redirect_current_user, only: %i[new create]
  before_action :admin_user,            only: [:destroy]
  before_action :show_activated_user,   only: [:show]

  def index
    @title = 'All users'
    @users = User.where(activated: true).paginate(page: params[:page],
                                                  per_page: 9)
  end

  def show
    @posts = @user.posts.paginate(page: params[:page],
                                  per_page: 9)
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      redirect_to :root, info: 'Please check your email.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, success: 'Your profile has been successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to :users, warning: 'User deleted.'
  end

  def followers
    @title = 'Followers'
    @users = @user.followers.paginate(page: params[:page],
                                      per_page: 9)
    render :index
  end

  def following
    @title = 'Following'
    @users = @user.following.paginate(page: params[:page],
                                      per_page: 9)
    render :index
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def show_activated_user
    unless @user.activated?
      redirect_to :root,
                  warning: 'This user not activated.'
    end
  end

  def frendly_redirect
    redirect_to @user unless current_user?(@user)
  end

  def admin_user
    redirect_to :root unless current_user.admin?
  end
end
