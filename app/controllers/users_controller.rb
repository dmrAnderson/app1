class UsersController < ApplicationController
	
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to :root, notice: 'Eeeh, now you have a new account!'
		else
			render :new, notice: 'Ooops, something wrong!' 
		end
	end
	
	private
	
		def user_params
			params.require(:user).permit(:name, :email, :password)
		end
	
end
