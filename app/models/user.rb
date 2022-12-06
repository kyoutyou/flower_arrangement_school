class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.first_name="ゲスト"
      user.last_name="太郎"
      user.first_name_kana="ゲスト"
      user.last_name_kana="タロウ"
      user.postal_code="000000"
      user.address="日本"
      user.telephone_number="111111"
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
