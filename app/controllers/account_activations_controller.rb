class AccountActivationsController < ApplicationController

	def edit
		user = User.find_by_email(params[:email])
		if user && !user.activated?	&& (user.activation_token == params[:id])
			user.activate
			log_in(user)
			redirect_to user, success: "Account activated!"
		else
			redirect_to :root, danger: "Invalid activation link"
		end
	end
end
