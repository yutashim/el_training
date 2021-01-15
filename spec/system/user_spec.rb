require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe 'ユーザ登録のテスト' do
    it 'ユーザの新規登録ができる' do
      visit new_user_path
      fill_in 'Name', with: 'user_name'
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on '登録する'
      p User.count
      expect(User.first.name).to eq 'user_name'
    end

    it 'ユーザがログインせずタスク一覧画面に跳ぼうとすると、ログイン画面に遷移する' do

    end
  end
end
