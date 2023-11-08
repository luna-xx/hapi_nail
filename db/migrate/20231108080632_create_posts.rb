class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.string :image
      t.text :text
      t.string :tag_list
      
      t.timestamps
    end
  end
end
