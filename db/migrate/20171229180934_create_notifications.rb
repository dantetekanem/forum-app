class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.string :visit_path
      t.text :message
      t.datetime :readed_at, default: nil

      t.timestamps
    end
  end
end
