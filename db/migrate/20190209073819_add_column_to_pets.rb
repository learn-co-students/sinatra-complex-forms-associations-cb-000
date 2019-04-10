class AddColumnToPets < ActiveRecord::Migration
  def change
    add_column :pets, :owner_id, :integer
  end
end
