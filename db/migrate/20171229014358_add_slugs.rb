class AddSlugs < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :slug, :string
    add_column :boards, :slug, :string
    add_column :topics, :slug, :string
  end
end
