class CreateDivisions < ActiveRecord::Migration[6.1]
  def change
    create_table :divisions do |t|
      t.integer :department_id, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
