class ChangeDatatypeIdOfStudioUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :studio_users, :id, :string
  end
end
