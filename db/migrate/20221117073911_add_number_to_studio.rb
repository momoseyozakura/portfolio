class AddNumberToStudio < ActiveRecord::Migration[6.1]
  def change
    add_column :studios, :number, :integer
  end
end
