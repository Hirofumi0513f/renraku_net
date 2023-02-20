class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.references :department, null: false, foreign_key: true
      t.references :division, null: false, foreign_key: true
      t.timestamps
    end
  end
end
