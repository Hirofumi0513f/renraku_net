class AddForeinKeyToStaff < ActiveRecord::Migration[6.1]
  def change
    add_reference :staffs, :organization, foreign_key: true
    add_reference :staffs, :position, foreign_key: true
  end
end
