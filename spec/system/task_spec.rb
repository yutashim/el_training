# テスト項目
# タスクを新規作成したとき、作成したタスクが画面に表示される
# 一覧画面では、作成済みのタスクが表示される
# 任意のタスク詳細画面に遷移したとき、該当タスクの内容が表示される
require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task, title: 'task_1')
    FactoryBot.create(:task, title: 'task_2')
    FactoryBot.create(:task, title: 'task_3')
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'タスクの名前', with: 'test_title'
      fill_in 'タスクの詳細', with: 'test_detail'
      click_on '登録する'
      expect(page).to have_content 'test_title'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧表示画面に遷移した場合' do
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

  describe 'タスクが作成日時の降順に並んでいる場合' do
    it '新しいタスクが一番上に表示される' do
      task = FactoryBot.create(:task, title: 'new_title')
      visit tasks_path
      expect(all('.task')[0].text).to have_content 'new_title'
    end
    it '最初に作成したタスクが一番下に表示される' do
      visit tasks_path
      expect(all('.task')[-1].text).to have_content 'task_1'
    end
  end

end
