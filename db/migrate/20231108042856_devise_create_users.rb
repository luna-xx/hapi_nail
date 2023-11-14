# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      # ニックネーム
      t.string :nick_name,          null: false
      # 名前
      t.string :name,               null: false
      # ナマエ
      t.string :furigana_name,      null: false
      # 性別
      t.string :sex,                null: false
      # プロフィール画像
      t.string :top_image,          default: "no_image.jpg"
      # メールアドレス
      t.string :email,              null: false, default: ""
      # 暗号化されたパスワード
      t.string :encrypted_password, null: false, default: ""
      # プロフィール文
      t.string :introduction
      # 会員ステータス
      t.boolean :is_active,         null: false, default: true

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      # 日時
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
