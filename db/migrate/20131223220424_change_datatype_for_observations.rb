class ChangeDatatypeForObservations < ActiveRecord::Migration
  def up
  	change_table :indicators do |t|
  		t.change :observations, :text, :limit => nil
  	end

  	change_table :updates do |t|
  		t.change :observations, :text, :limit => nil
  	end
  end

  def down
  	change_table :indicators do |t|
  		t.change :observations, :string
  	end

  	change_table :updates do |t|
  		t.change :observations, :string
  	end
  end
end
