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
