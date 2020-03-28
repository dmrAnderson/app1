class UsersController < ApplicationController
	before_action :find_user,             only: [:show, :edit, :update, :destroy]
	before_action :unknown_users,         only: [:index, :edit, :update, :destroy]
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
		@user = User.new(user_params(:name, :email, :password)) # T	est
		if @user.save
			@user.send_activation_email
			redirect_to :root, info: "Please check your email to activate your account."
		else
			render :new, danger: "Something went wrong."
		end
	end

	def update
		if @user.update(user_params(:name, :email, :password, :password_confirmation)) # Test
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

		def user_params(atr1="", atr2="", atr3="", atr4="")
			params.require(:user).permit(atr1, atr2, atr3, atr4)
		end
# Filters -- redirect
		def show_activated_user
			redirect_to :root, warning: "This user not activated." if !@user.activated?
		end

		def unknown_users
			redirect_to :signup, danger: "Please log in." if !current_user
		end

		def frendly_redirect
			redirect_to @user if !current_user?(@user)
		end

		def admin_user
			redirect_to :root if !current_user.admin?
		end
end
