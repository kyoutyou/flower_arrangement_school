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
      frequency = params.require(:user)[:frequency]
      case frequency
      when "1" then
          # 登録時には「月1回コース」の場合には来週の土曜日が予約として入るようにする
        user.reservations.create(lesson_id: params.require(:user)[:course_id], lesson_datetime: Date.today.next_week(:saturday) )
      when "2" then
          # 登録時には「月2回コース」の場合には来週の土曜日、その２週間後の土曜日が予約として入るようにする
      　user.reservations.create(lesson_id: params.require(:user)[:course_id], lesson_datetime: Date.today.next_week(:saturday) )
        user.reservations.create(lesson_id: params.require(:user)[:course_id], lesson_datetime: Date.today.next_week(:saturday) + 2.weeks )
      when "3" then
          # 登録時には「月3回コース」の場合にはその週の土曜日、１週間後の土曜日、２週間後の土曜日が予約として入るようにする
        user.reservations.create(lesson_id: params.require(:user)[:course_id], lesson_datetime: Date.today.end_of_week - 1.day)
        user.reservations.create(lesson_id: params.require(:user)[:course_id], lesson_datetime: Date.today.end_of_week - 1.day + 1.weeks )
        user.reservations.create(lesson_id: params.require(:user)[:course_id], lesson_datetime: Date.today.end_of_week - 1.day + 2.weeks )
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

  def saturday_of_month(date)
    bom = date.beginning_of_month
    eom = date.end_of_month
    diff = (eom - bom).to_i

    saturday_array = []
    (0..diff).each do |v|
      saturday_array << bom + v.day if (bom + v.day).wday == 6
    end

    pp saturday_array

    next_saturday = date.next_week(:saturday)

    if saturday_array.index(next_saturday).nil? || saturday_array.index(next_saturday) >= 3

      # 月始まりが日曜日以外の場合は、前月の週を引き継ぐ
      if (date + 1.month).beginning_of_month.wday != 0
        ((date + 1.month).beginning_of_month - 1.weeks).next_week(:saturday)
      else
        (date + 1.month).beginning_of_month.next_week(:saturday)
      end
      # case saturday_array.index(next_saturday)
      #   when 3 then
      #     (date + 2.week).next_week(:saturday)
      #   when 4 then
      #     (date + 1.week).next_week(:saturday)
      #   else
      #     date.beginning_of_month.next_week(:saturday)
      # end
      # 1-3週目
      # return true
    else
      date.next_week(:saturday)
      # 4週目
      # return false
    end
  end
end

