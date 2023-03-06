class CreateStudioUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :studio_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :studio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
