class User < ApplicationRecord
	has_many :posts, dependent: :destroy
	has_many :active_relationships,		class_name: "Relationship",
																		foreign_key: "follower_id",
																		dependent: :destroy
	has_many :passive_relationships,	class_name: "Relationship",
																		foreign_key: "followed_id",
																		dependent: :destroy
	has_many :following, through: :active_relationships,	source: :followed
	has_many :followers, through: :passive_relationships, source: :follower

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

	def get_posts
		Post.where("user_id = ?", id)
	end

	def follow(user)
		active_relationships.create(followed_id: user.id)
	end

	def unfollow(user)
		active_relationships.find_by(followed_id: user.id).destroy
	end

	def following?(user)
		following.include?(user	)
	end

	private

		def downcase_email
			self.email = email.downcase
		end

		def create_activation_token
			self.activation_token = SecureRandom.urlsafe_base64	# FIX DRY
		end
end
