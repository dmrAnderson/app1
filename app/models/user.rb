class User < ApplicationRecord
	before_save :downcase_email
	before_create :create_activation_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	private

		def downcase_email
			self.email = email.downcase
		end

		def create_activation_token
			self.activation_token = SecureRandom.urlsafe_base64
		end
end
