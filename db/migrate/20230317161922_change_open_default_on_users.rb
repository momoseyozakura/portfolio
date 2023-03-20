class ChangeOpenDefaultOnUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :open, from: false, to: true
  end
end
