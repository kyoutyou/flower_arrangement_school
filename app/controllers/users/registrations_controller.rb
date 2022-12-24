# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    # ユーザーの登録
    build_resource(sign_up_params)
    resource.save!

    user = User.find_by(email: params.require(:user)[:email])
    if user.present?
      # frequency = params.require(:user)[:frequency]
      frequency = Course.find(params.require(:user)[:frequency]).number
      date = Date.today
      case frequency
      when 1 then
          # 登録時には「月1回コース」の場合には来週の土曜日が予約として入るようにする
        user.reservations.create(lesson_id: params.require(:user)[:course_id],
          lesson_datetime: saturday_of_weeks(date)
        )
      when 2 then
          # 登録時には「月2回コース」の場合には来週の土曜日、その２週間後の土曜日が予約として入るようにする
        user.reservations.create(lesson_id: params.require(:user)[:course_id],
          lesson_datetime: saturday_of_weeks(date)
        )
        user.reservations.create(lesson_id: params.require(:user)[:course_id],
          lesson_datetime: saturday_of_weeks(saturday_of_weeks(date))
        )
      when 3 then
          # 登録時には「月3回コース」の場合にはその週の土曜日、１週間後の土曜日、２週間後の土曜日が予約として入るようにする
        user.reservations.create(lesson_id: params.require(:user)[:course_id],
          lesson_datetime: saturday_of_weeks(date)
        )
        user.reservations.create(lesson_id: params.require(:user)[:course_id],
          lesson_datetime: saturday_of_weeks(saturday_of_weeks(date))
        )
        user.reservations.create(lesson_id: params.require(:user)[:course_id],
          lesson_datetime: saturday_of_weeks(saturday_of_weeks(saturday_of_weeks(date)))
        )
      end
    end
    sign_in user
    redirect_to public_customer_path(:id)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  before_action :ensure_normal_user, only: %i[update destroy]
  def ensure_normal_user
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません。'
    end
  end

  def saturday_of_weeks(date)
    beginning_of_month = date.beginning_of_month # 月初
    end_of_month = date.end_of_month # 月末
    diff = (end_of_month - beginning_of_month).to_i # 月初と月末の差分

    # 月初から月末までの土曜日のみ配列にする
    saturday_array = []
    (0..diff).each do |v|
      saturday_array << beginning_of_month + v.days if (beginning_of_month + v.days).wday == 6
    end

    # 引数の日から翌週の土曜日日付
    next_saturday = date.next_week(:saturday)

    # 引数の翌週土曜日が何周目かindexで取得(※1)
    saturday_index = saturday_array.index(next_saturday)

    # ※1がnil(翌月またぎ)または、1～3週目かの条件分岐
    if saturday_index.nil? || saturday_index >= 3
      # 該当日付の年間週番号と指定日月末の年間週番号が同じかまたは、指定日月末が土曜日の場合の条件分岐
      if date.cweek == end_of_month.cweek || end_of_month.wday == 6
        # 翌月の基準日から+7日した翌週の土曜日
        date.beginning_of_month.next_month.next_week(:saturday)
      else
        # 翌月の基準日から-7日した土曜日
        date.beginning_of_month.next_month.next_occurring(:saturday)
      end
    else
      # 単純に翌週土曜日
      next_saturday
    end
  end
end

