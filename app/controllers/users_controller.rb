class UsersController < ApplicationController
	before_action :find_user, only: [:show, :edit, :update, :destroy]

	def index; end

	def show; end

	def new
		@user = User.new
	end
	
	def edit; end
	
	def create
		@user = User.new(user_params)
		if @user.save
			log_in
			redirect_to :root, success: "Hi, now you have a new account."
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
		reset_session
		redirect_to :root, warning: "Your profile has been successfully deleted."
	end
	
	private
	
		def find_user
			@user = User.find(params[:id])
		end
	
		def user_params
			params.require(:user).permit(:name, :email, :password)
		end
end
