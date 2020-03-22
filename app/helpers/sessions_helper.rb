module SessionsHelper
	def current_user
		if session[:user_id]
			current_user ||= User.find(session[:user_id])
		elsif user_through_the_cookies
			current_user ||= log_in(user_through_the_cookies)
		end
	end

	def log_in(user)
		session[:user_id] = user.id
	end

	def log_out(user)
		reset_session
		User.find(user.id).update_attribute(:remember_token, nil)
    cookies.delete(:remember_token)
  end

	def generate_token
    SecureRandom.urlsafe_base64
  end

	def remember(user)
		user.update_attribute(:remember_token, generate_token)
		cookies.signed[:remember_token] = generate_token
	end

	def user_through_the_cookies
		if (token = cookies.signed[:remember_token])
			User.find_by_remember_token("#{token}")
		end
	end

end
