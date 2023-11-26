class CreatePosttags < ActiveRecord::Migration[6.1]
  def change
    create_table :posttags do |t|
      t.bigint :post_id, null: false
      t.bigint :tag_id, null: false

      t.timestamps
    end

    add_index :posttags, [:post_id, :tag_id], unique: true
    add_foreign_key :posttags, :posts
    add_foreign_key :posttags, :tags

  end
end
