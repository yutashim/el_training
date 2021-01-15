FactoryBot.define do
  factory :task do
    title {'test_title'}
    detail {'test_detail'}
    status {'未着手'}
    user
  end

  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title {'second_title'}
    detail {'second_detail'}
  end
end
