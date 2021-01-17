require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  before do
    DatabaseCleaner.clean
  end
  describe 'ユーザ登録のテスト' do
    it 'ユーザの新規登録ができる' do
      visit new_user_path
      fill_in 'Name', with: 'user_name'
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on '登録する'
      expect(User.first.name).to eq 'user_name'
    end
    it 'ユーザがログインせずタスク一覧画面に跳ぼうとすると、ログイン画面に遷移する' do
      visit tasks_path
      expect(page).to have_current_path new_session_path
    end
  end
  describe 'セッション機能のテスト' do
    before do
      @user = FactoryBot.create(:user)
      @user_b = FactoryBot.create(:user, email: "user_b@email.com" )
    end
    let!(:login) {
      visit new_session_path
      fill_in 'Email', with: 'user_a@email.com'
      fill_in 'Password', with: 'password'
      click_on 'login'
    }
    it 'ログインができる' do
      expect(page).to have_content 'お帰りなさい'
    end
    it '自分の詳細ページに飛べる' do
      visit user_path(@user.id)
      expect(page).to have_current_path user_path(@user.id)
    end
    it '一般ユーザが他人の詳細ページへ飛ぶと、タスク一覧ページに遷移する' do
      visit user_path(@user_b.id)
      expect(page).to have_current_path tasks_path
    end
    it 'ログアウトができる' do
      click_on 'ログアウト'
      visit user_path(@user.id)
      expect(page).to have_current_path new_session_path
    end
  end
  describe '管理画面のテスト' do
    before do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
    end
    let(:admin_login) do
      visit new_session_path
      fill_in 'Email', with: 'admin@email.com'
      fill_in 'Password', with: 'password'
      click_on 'login'
    end
    let(:login) do
      visit new_session_path
      fill_in 'Email', with: 'user_a@email.com'
      fill_in 'Password', with: 'password'
      click_on 'login'
    end
    it '管理ユーザは管理画面にアクセスできる' do
      admin_login
      visit admin_users_path
      expect(page).to have_current_path admin_users_path
    end
    it '一般ユーザは管理画面にアクセスできない' do
      login
      visit admin_users_path
      expect(page).to have_current_path user_path(@user.id)
    end
    it '管理ユーザはユーザの新規登録ができる' do
      admin_login
      visit new_user_path
      fill_in 'Name', with: 'create_name'
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on '登録する'
      expect(page).to have_content 'はじめまして！'
      expect(User.find_by(name: 'create_name').present?).to eq true
    end
    it '管理ユーザはユーザの詳細画面にアクセスできる' do
      admin_login
      visit user_path(@user.id)
      expect(page).to have_current_path user_path(@user.id)
    end
    it '管理者ユーザはユーザの編集画面からユーザの編集ができる' do
      admin_login
      visit edit_user_path(@user.id)
      fill_in 'Name', with: 'edited_name'
      click_on '更新する'
      expect(page).to have_content "edited_name"
    end
    it '管理ユーザはユーザの削除ができる' do
      admin_login
      num = @user.id
      visit admin_users_path
      click_link "delete_#{num}"
      expect(page).to have_content 'ユーザを削除しました'
      expect(User.find_by(email: 'user_a@email.com')).to eq nil
    end
  end
end
