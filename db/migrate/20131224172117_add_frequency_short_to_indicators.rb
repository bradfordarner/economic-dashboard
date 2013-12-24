class AddFrequencyShortToIndicators < ActiveRecord::Migration
  def change
    add_column :indicators, :frequency_short, :string
  end
end
