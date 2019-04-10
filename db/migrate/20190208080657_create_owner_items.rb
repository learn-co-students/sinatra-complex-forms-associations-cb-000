class CreateOwnerItems < ActiveRecord::Migration
  def change
    create_table :owner_pets do |t|
      t.integer :owner_id
      t.integer :pet_id
    end
  end
end
