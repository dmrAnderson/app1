class SessionsController < ApplicationController
  def new
	end
	
	def create
		@user = User.find_by_email(params[:session][:email])
		if @user && @user.authenticate(params[:session][:password])
			log_in
			redirect_to root_path, success: 'Welcome back, you Log In.'
		else
			render 'new', danger: 'Incorrect username or password.'
		end
	end

	def destroy
		reset_session
		redirect_to root_path, success: 'Bay-bay, it was nice to see you.'
	end
end
