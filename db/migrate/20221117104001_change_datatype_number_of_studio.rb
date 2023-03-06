class ChangeDatatypeNumberOfStudio < ActiveRecord::Migration[6.1]
  def change
    change_column :studios, :number, :string
  end
end
