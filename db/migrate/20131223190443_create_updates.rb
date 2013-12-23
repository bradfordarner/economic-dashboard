class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :indicator_id
      t.string :observations

      t.timestamps
    end
  end
end
