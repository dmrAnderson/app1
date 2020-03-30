class UsersController < ApplicationController
	before_action :find_user,             only: [:show, :edit, :update, :destroy]
	before_action :logged_in_user,        only: [:index, :edit, :update, :destroy]
	before_action :frendly_redirect,      only: [:edit, :update]
	before_action :redirect_current_user, only: [:new, :create]
	before_action :admin_user,            only: [:destroy]
	before_action :show_activated_user,   only: [:show]

	def index
		@users = User.where(activated: true).paginate(page: params[:page], per_page: 9)
	end

	def show
		@posts = @user.posts.paginate(page: params[:page], per_page: 8)
	end

	def new
		@user = User.new
	end

	def edit; end

	def create
		@user = User.new(user_params(:name, :email, :password))
		if @user.save
			@user.send_activation_email
			redirect_to :root, info: "Please check your email to activate your account."
		else
			render :new
		end
	end

	def update
		if @user.update(user_params(:name, :email, :password, :password_confirmation))
			redirect_to @user, success: "Your profile has been successfully updated."
		else
			render :edit
		end
	end

	def destroy
		@user.destroy
		redirect_to :users, warning: "User deleted."
	end

	private

		def find_user
			@user = User.find(params[:id])
		end

		def user_params(atr1, atr2=nil, atr3=nil, atr4=nil)
			params.require(:user).permit(atr1, atr2, atr3, atr4)
		end
# Filters -- redirect
		def show_activated_user
			redirect_to :root, warning: "This user not activated." if !@user.activated?
		end

		def frendly_redirect
			redirect_to @user if !current_user?(@user)
		end

		def admin_user
			redirect_to :root if !current_user.admin?
		end
end
