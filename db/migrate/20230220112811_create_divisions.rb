class CreateDivisions < ActiveRecord::Migration[6.1]
  def change
    create_table :divisions do |t|
      t.string :name, null: false
      
      t.references :organization, foreign_key: true
      t.timestamps
    end
  end
end
