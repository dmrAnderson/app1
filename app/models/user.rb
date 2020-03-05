class User < ApplicationRecord
	has_secure_password
	validates :name, presence: true, length: { in: 2..20}
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true, length: { in: 5..20}
end
