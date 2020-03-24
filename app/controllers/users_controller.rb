class UsersController < ApplicationController
	before_action :find_user,      only: [:show, :edit, :update, :destroy]
	before_action :unknown_users,  only: [:index, :edit, :update, :destroy]
	before_action :defended_users, only: [:edit, :update]
	before_action :admin_user,     only: [:destroy]

	def index
		@users = User.paginate(page: params[:page], per_page: 15)
	end

	def show; end

	def new
		@user = User.new
	end

	def edit; end

	def create
		@user = User.new(user_params)
		if @user.save
			UserMailer.account_activation(@user).deliver_now
			# log_in(@user)
			redirect_to :root, info: "Please check your email to activate your account." #success: "Hi, now you have a new account."
		else
			render :new, danger: "Ooops, something went wrong." 
		end
	end

	def update
		if @user.update(params.require(:user).permit(:name, :email, :password, :password_confirmation))
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

		def user_params
			params.require(:user).permit(:name, :email, :password)
		end

		def unknown_users
			redirect_to :signup, danger: "Please log in." if !current_user
		end

		def defended_users
			redirect_to @user if !current_user?(@user)
		end

		def admin_user
			redirect_to :root if !current_user.admin?
		end
end
