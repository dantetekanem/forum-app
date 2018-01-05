class CreateModerators < ActiveRecord::Migration[5.1]
  def change
    create_table :moderators do |t|
      t.references :user, foreign_key: true, index: true
      t.references :board, foreign_key: true, index: true

      t.timestamps
    end
  end
end
