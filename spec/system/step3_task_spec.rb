require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    DatabaseCleaner.clean
    # 必要に応じて、テストデータの内容を変更して構わない
    FactoryBot.create(:task, title: "task", priority: 2 )
    FactoryBot.create(:second_task, title: "sample", status: "着手中")
  end
  describe '検索機能' do
    before do
      DatabaseCleaner.clean
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:task, title: "task", )
      FactoryBot.create(:second_task, title: "sample", status: "着手中")
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'search_word', with: 'tas'
        # 検索ボタンを押す
        click_on '検索する'
        p Task.count
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        FactoryBot.create(:task, status:'着手中')
        visit tasks_path
        # プルダウンを選択する「select」について調べてみること
        select '着手中', from: 'search_status'
        click_on '検索する'
        p Task.count
        expect(all('.task').size).to eq 2
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに実装する
        FactoryBot.create(:task, title:'sam', status:'着手中')
        FactoryBot.create(:task, title:'sample', status:'完了')
        visit tasks_path
        fill_in 'search_word', with: 'sam'
        select '着手中', from: 'search_status'
        click_on '検索する'
        p Task.count
        expect(all('.task').size).to eq 2
      end
    end
  end

  describe '優先順位でのソート' do
    it '優先度が高い順にソートされる' do
      FactoryBot.create(:task, title:'優先度：高', priority: 0)
      visit tasks_path
      click_on '優先順位'
      sleep(0.5)
      expect(all('.task')[0].text).to have_content '優先度：高'
      expect(all('.task')[-1].text).to have_content 'task'
    end
  end
end
