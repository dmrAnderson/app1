# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  private

  def picture_size
    errors.add(:picture, 'should be less than 5MB') if picture
                                                       .size > 5.megabytes
  end
end
