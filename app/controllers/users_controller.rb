class UsersController < ApplicationController
	before_action :find_user, only: [:show]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			log_in
			redirect_to :root, success: 'Hi, now you have a new account.'
		else
			render :new, danger: 'Ooops, something went wrong.' 
		end
	end

	def show
	end
	
	private
		def find_user
			@user = User.find(params[:id])
		end
	
		def user_params
			params.require(:user).permit(:name, :email, :password)
		end
	
end
