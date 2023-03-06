class ChangeDatatypeIdOfStudioUsers < ActiveRecord::Migration[6.1]
  def up
    change_column :studio_users, :id, :integer, using: "id::integer"
  end

  def down
    change_column :studio_users, :id, :string
  end
end
