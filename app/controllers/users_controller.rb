class UsersController < ApplicationController
	
	def index; end

	def new
		@user = User.new
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to :root_path, notice: 'Eeeh, now you have a new account!'
		else
			render :users_new_path, notice: 'Ooops, something wrong!' 
		end
	end
	
	private
	
		def user_params
			params.require(:users).permit(:name, :email, :password_digest)
		end
	
end