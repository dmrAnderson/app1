class SessionsController < ApplicationController
  def new
	end
	
	def create
		@user = User.find_by_email(params[:session][:email])
		if @user && @user.authenticate(params[:session][:password])
			session[:user_id] = @user.id
			redirect_to root_path, notice: 'OFFFFFFFFFFFFFFFFFFFFkkkkk'
		else
			render 'new'
		end
	end

	def destroy
		reset_session
		redirect_to root_path
	end
end
