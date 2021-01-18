require 'rails_helper'
RSpec.describe 'ラベル機能のテスト', type: :system do
  before do
    DatabaseCleaner.clean
    @task = FactoryBot.create(:task_with_user, title: 'first_task')
    FactoryBot.create(:label)
    FactoryBot.create(:label, title: 'ラベル2')
    FactoryBot.create(:label, title: 'ラベル3')
  end
  let!(:login) {
    visit new_session_path
    fill_in 'Email', with: 'user_a@email.com'
    fill_in 'Password', with: 'password'
    click_on 'login'
  }
    it '作成したタスクにラベルを付けられる' do
      visit edit_task_path(@task.id)
      check 'ラベル2'
      click_on '更新する'
      visit task_path(@task.id)
      expect(page).to have_content('ラベル2')
    end
    before do
      label = FactoryBot.create(:label, title: 'search_task')
      FactoryBot.create(:labeling, label: label, task: @task)
    end
    it 'ラベルからタスクを検索できる' do
      visit tasks_path
      select 'search_task', from: 'ラベル名'
      click_on 'ラベル名で検索'
      expect(page).to have_content('first_task')
    end
end
