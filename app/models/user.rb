class User < ApplicationRecord
	has_many :posts

	before_save :downcase_email
	before_create :create_activation_token

	validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	def activate
		update_columns(activated: true, activation_token: nil)
	end

	def create_reset_token
		update_columns(
			reset_token: SecureRandom.urlsafe_base64, # FIX DRY
			reset_sent_at: Time.zone.now
		)
	end

	def send_reset_token
		UserMailer.password_reset(self).deliver_now
	end

	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	private

		def downcase_email
			self.email = email.downcase
		end

		def create_activation_token
			self.activation_token = SecureRandom.urlsafe_base64	# FIX DRY
		end
end
