class Post < ApplicationRecord
	belongs_to :user, dependent: :destroy

	validates :user_id, presence: true # Is this walidation need?
	validates :content, presence: true, length: { maximum: 140 }
	default_scope -> { order(created_at: :desc) }
end
