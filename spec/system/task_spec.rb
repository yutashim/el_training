# テスト項目
# タスクを新規作成したとき、作成したタスクが画面に表示される
# 一覧画面では、作成済みのタスクが表示される
# 任意のタスク詳細画面に遷移したとき、該当タスクの内容が表示される
require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'Title', with: 'test_title'
      fill_in 'Detail', with: 'test_detail'
      click_on 'Create Task'
      expect(page).to have_content 'test_title'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧表示画面に遷移した場合' do
      before do
        FactoryBot.create(:task, title: 'task_1')
        FactoryBot.create(:task, title: 'task_2')
        FactoryBot.create(:task, title: 'task_3')
      end
      it '作成済みの全てのタスク一覧が表示される' do
        visit tasks_path
        expect(all('.task').size).to eq 3
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit task_path(task.id)
        expect(page).to have_content 'test_title'
      end
    end
  end

end
