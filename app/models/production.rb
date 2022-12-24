class Production < ApplicationRecord
  has_one_attached :image

  validates :image, presence: true
  validates :title, presence: true
  validates :introduction, presence: true
end
