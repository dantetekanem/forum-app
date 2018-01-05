class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, index: true
      t.references :topic, foreign_key: true, index: true
      t.text :content, null: false
      t.integer :reply_id, default: nil

      t.timestamps
    end
  end
end
