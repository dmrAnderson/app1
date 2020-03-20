class SessionsController < ApplicationController
  def new; end
	
	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			log_in(user)
			redirect_to :root, success: "Welcome back, you Log In."
		else
			flash.now[:danger] = "Incorrect username or password."
			render :new
		end
	end

	def destroy
		reset_session
		redirect_to :root, info: "Bay-bay, it was nice to see you."
	end
end
