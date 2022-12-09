class RemoveNumberFromStudios < ActiveRecord::Migration[6.1]
  def change
    remove_column :studios, :number, :string
  end
end
