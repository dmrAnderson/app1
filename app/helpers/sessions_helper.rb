module SessionsHelper
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def log_in(user)
		session[:user_id] = user.id
	end

	def generate_token
    SecureRandom.urlsafe_base64
  end

	def remember(user)
		user.update(remember_token: "#{generate_token}")
		cookies[:remember_token] = generate_token
	end
end
