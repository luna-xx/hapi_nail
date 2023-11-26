class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.bigint :post_id
      t.bigint :user_id
      t.string :comment, null: false

      t.timestamps
    end
  end
end
