class AddLottelyToStudioUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :studio_users, :lottely, :integer
  end
end
