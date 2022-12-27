class AddOpenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :open, :boolean, default: false
  end
end
