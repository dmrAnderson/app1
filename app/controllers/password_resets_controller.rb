class PasswordResetsController < ApplicationController
	before_action :find_user,        only: [:edit, :update]
	before_action :valid_user,       only: [:edit, :update]
	before_action :check_expiration, only: [:edit, :update]
	before_action :redirect_current_user

	def new; end

	def create
		@user = User.find_by_email(params[:password_reset][:email].downcase)
		if @user
			@user.create_reset_token
			@user.send_reset_token
			redirect_to :root, info: "Email sent with password reset instructions"
		else
			flash.now[:danger] = "Email address not found"
			render :new
		end
	end

	def edit; end

	def update
		if params[:user][:password].empty?
			@user.errors.add(:password, "can't be empty")
			render :edit
		elsif @user.update( password: password_params, # Is it normal spelling?
												reset_token: nil, reset_sent_at: nil ) 
			log_in(@user)
			redirect_to @user, success: "Password has been reset."
		else
			render :edit
		end
	end

	private

		def password_params
			params.require(:user).permit(:password, :password_confirmation)
		end

		def find_user
			@user = User.find_by_email(params[:email])
		end

		def valid_user
			if !(@user && @user.activated? && (@user.reset_token == params[:id]))
				redirect_to :root, warning: "Something went wrong."
			end
		end

		def check_expiration
			if @user.password_reset_expired?
				redirect_to new_password_reset_url, danger: "Password reset has expired."
			end
		end
end
