class Indicator < ActiveRecord::Base
  attr_accessible :name, :next_release, :observations, :series

  has_many :updates

  serialize :observations

  def chart_values
  	values = {}
  	self.observations.observations.each { |o| values[Time.parse(o.date)] = o.value.to_f }
  	return values
  end
end
