class AddNameToStudios < ActiveRecord::Migration[6.1]
  def change
    add_column :studios, :name, :string
  end
end
