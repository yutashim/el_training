FactoryBot.define do
  factory :task do
    title {'test_title'}
    detail {'test_detail'}
    status {'未着手'}
    user { User.first }
  end

  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title {'second_title'}
    detail {'second_detail'}
    user { User.first }
  end

  factory :task_with_user, class: Task do
    title {'with_user'}
    detail {'foo'}
    user
  end
end
