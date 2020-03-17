class ApplicationController < ActionController::Base

	add_flash_types :success, :danger, :info

	private

		def current_user
			@current_user ||= User.find(session[:user_id]) if session[:user_id]
		end

		helper_method :current_user

		def log_in
			session[:user_id] = @user.id
		end

end
