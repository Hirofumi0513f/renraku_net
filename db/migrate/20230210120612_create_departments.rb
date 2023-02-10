class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.integer :staff_id, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
