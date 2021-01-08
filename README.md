# README

### テーブルスキーマの記載

- users:  
  - name: string  
  - email: string
  - password_digest: string

- tasks:  
  - title: string  
  - detail: text
  - limit: date
  - order: integer  
  - status: string  
  - user_id: integer     

- labels:
  - name: string  

- labelings
  - task_id: integer  
  - label_id: integer

### Herokuへのデプロイ手順

- Herokuに新規アプリケーションを作成

    `$ heroku create`

- デプロイする前にアセットプリコンパイルする

    `$ rails assets:precompile RAILS_ENV=production`

- デプロイするファイルをcommitする

  `$ git add ~ `

  `$ git commit -m "commit messageを入力"`

- Heroku buildpackの追加

  `$ heroku buildpacks:set heroku/ruby`

- Herokuへpushする

  `$ git push heroku master`

  - Herokuのデータベースを更新する

    `$ heroku run rails db:migrate`
