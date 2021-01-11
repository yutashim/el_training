require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) { FactoryBot.create(:task, title: 'task') }
    let!(:second_task) { FactoryBot.create(:second_task, title: "sample") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.title_search('task')).to include(task)
        expect(Task.title_search('task')).not_to include(second_task)
        expect(Task.title_search('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに内容を記載する
        FactoryBot.create(:task, status: '完了')
        search_tasks = Task.status_search('未着手')
        expect(search_tasks.count).to eq 2
        expect(search_tasks.status_search('完了').count).to eq 0
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        #　検索に合致する
        FactoryBot.create(:task, title:'task_title')
        #　検索に合致しない
        FactoryBot.create(:task, title:'task', status: '完了')
        FactoryBot.create(:task, title:'sample')
        search_tasks = Task.title_status_search('task', '未着手')
        expect(search_tasks.count).to eq 2
      end
    end
  end
end
