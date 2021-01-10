require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task, title: 'task_1', deadline: Time.new(2021,02,10,00,00))
    FactoryBot.create(:task, title: 'task_2', deadline: Time.new(2021,01,10,00,00))
    FactoryBot.create(:task, title: 'task_3', deadline: Time.new(2021,01,20,00,00))
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

  describe 'タスクが終了期限で昇順に並んでいる場合' do
    it '上からtask_2, task_3, task_1の順で表示される' do
      visit tasks_path
      click_on '終了期限でソートする'
      sleep(2)
      tasks = all('.task')
      p current_path
      expect(tasks[0].text).to have_content 'task_2'
      expect(tasks[-1].text).to have_content 'task_1'
    end
    it '新規作成したタスクが上から2番目に表示される' do
      time = Time.new(2021,01,15,00,00)
      visit new_task_path
      fill_in 'タスクの名前', with: '新しいタスク'
      fill_in 'タスクの詳細', with: '上から2番目に来る'
      select time.strftime("%Y"), from: 'task_deadline_1i'
      select time.strftime("%m"), from: 'task_deadline_2i'
      select time.strftime("%d"), from: 'task_deadline_3i'
      click_on '登録する'
      visit tasks_path
      click_link '終了期限でソートする'
      sleep(2)
      new_task = all('.task')[1]
      p current_path
      expect(new_task.text).to have_content '上から2番目に来る'
    end
  end
end
