class User < ApplicationRecord
  belongs_to :course
  has_many :reservations
  validates :course_id,presence: true
  validates :frequency,presence: true
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
      user.course_id = 1
      user.frequency = 1
    end
  end

  def self.create_lesson_date
    puts "sample method start! #{DateTime.current}"
    users_last_reservation_lesson_datetime = Reservation.select('id,user_id, lesson_datetime').group('user_id').from(Reservation.order('lesson_datetime DESC'), :reservation)

    users_last_reservation_lesson_datetime.each do |reservation|
      user = User.find(reservation.user_id)
      date = reservation.lesson_datetime
      if reservation.lesson_datetime < DateTime.current
      case user.frequency
      when 1 then
          # 登録時には「月1回コース」の場合には来週の土曜日が予約として入るようにする
        user.reservations.create(lesson_id: user.course_id,
          lesson_datetime: saturday_of_weeks(date)
        )
      when 2 then
          # 登録時には「月2回コース」の場合には来週の土曜日、その２週間後の土曜日が予約として入るようにする
        user.reservations.create(lesson_id: user.course_id,
          lesson_datetime: saturday_of_weeks(date)
        )
        user.reservations.create(lesson_id: user.course_id,
          lesson_datetime: saturday_of_weeks(saturday_of_weeks(date))
        )
      when 3 then
          # 登録時には「月3回コース」の場合にはその週の土曜日、１週間後の土曜日、２週間後の土曜日が予約として入るようにする
        user.reservations.create(lesson_id: user.course_id,
          lesson_datetime: saturday_of_weeks(date)
        )
        user.reservations.create(lesson_id: user.course_id,
          lesson_datetime: saturday_of_weeks(saturday_of_weeks(date))
        )
        user.reservations.create(lesson_id: user.course_id,
          lesson_datetime: saturday_of_weeks(saturday_of_weeks(saturday_of_weeks(date)))
        )
      end
      end
    end
    puts 'sample method end'
  end

end
