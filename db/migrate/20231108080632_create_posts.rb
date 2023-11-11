class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :title,    null: false
      t.string :image,    null: false
      t.text :text,       null: false
      t.string :tag_list
      
      t.timestamps
    end
  end
end
