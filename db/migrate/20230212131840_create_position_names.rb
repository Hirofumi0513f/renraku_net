class CreatePositionNames < ActiveRecord::Migration[6.1]
  def change
    create_table :position_names do |t|
      t.string :name
      t.timestamps
    end
  end
end
