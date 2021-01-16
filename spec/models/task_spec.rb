require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  before do
    DatabaseCleaner.clean
    FactoryBot.create(:user)
  end
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', detail: '失敗テスト')
        expect(task).not_to be_valid
      end
    end

    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', detail: '')
        # task.valid?
        # expect(task.errors[:detail]).to include("can't be blank")
        expect(task).not_to be_valid
      end
    end

    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = FactoryBot.create(:task)
        expect(task).to be_valid
      end
    end
  end
end
