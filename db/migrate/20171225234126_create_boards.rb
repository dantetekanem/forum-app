class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards do |t|
      t.string :name
      t.text :description
      t.boolean :private, default: false

      t.timestamps
    end
  end
end
