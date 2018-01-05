class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.references :board, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.string :title
      t.datetime :closed_at

      t.timestamps
    end
  end
end
