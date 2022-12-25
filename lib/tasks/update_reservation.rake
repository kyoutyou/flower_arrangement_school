namespace :update_reservation do
  desc '実行する処理の説明'
    task :check => :environment do
      include DateTask
      User.create_lesson_date
  end
end

module DateTask
  require 'active_support/all'
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