class AddMemberToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :member, :text
  end
end
