# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    UserMailer.account_activation(User.first)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
	def password_reset
		user = User.first
		user.reset_token = 1 # SecureRandom.urlsafe_base64
    UserMailer.password_reset(user)
  end

end
