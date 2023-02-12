class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.integer :staff_id, null: false
      t.integer :department_name_id, null: false
      t.integer :division_name_id, null: false
      t.timestamps
    end
  end
end
