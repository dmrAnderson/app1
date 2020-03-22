class SessionsController < ApplicationController
  def new; end
	
	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			remember(user) if params[:session][:remember_me] == "1"
			log_in(user)
			redirect_to :root, success: "Welcome back, you Log In."
		else
			flash.now[:danger] = "Incorrect username or password."
			render :new
		end
	end

	def destroy
		log_out(current_user)
		redirect_to :root, info: "Bay-bay, it was nice to see you."
	end
end
