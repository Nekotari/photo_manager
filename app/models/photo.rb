class Photo < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :image, presence: true
  validates :description, presence: true, length: { maximum: 30 }
end
