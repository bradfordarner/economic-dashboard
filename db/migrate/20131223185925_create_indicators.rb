class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.string :name
      t.string :series
      t.string :observations
      t.time :next_release

      t.timestamps
    end
  end
end
