class CreatePositions < ActiveRecord::Migration[6.1]
  def change
    create_table :positions do |t|
      t.integer :staff_id, null: false
      t.integer :position_name_id, null: false
      t.timestamps
    end
  end
end
