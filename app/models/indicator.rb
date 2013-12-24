class Indicator < ActiveRecord::Base
  attr_accessible :name, :next_release, :observations, :series, :frequency_short

  has_many :updates

  serialize :observations

  def chart_values
  	case self.frequency_short
  	when "M"
  		count = self.observations.observations.count - 72
  	when "A"
  		count = self.observations.observations.count - 10
  	when "D"
  		count = self.observations.observations.count - 90
  	when "Q"
  		count = self.observations.observations.count - 12
  	else
  		count = self.observations.observations.count - 90
  	end
  	values = {}
  	self.observations.observations[count..-1].each { |o| values[Time.parse(o.date)] = o.value.to_f }
  	return values
  end

  def percentage_change
  	last_two = self.observations.observations.last(2)
  	percentage_change = (last_two[1].value.to_f - last_two[0].value.to_f)/last_two[0].value.to_f * 100
  	return percentage_change.round(2)
  end

  def current_value
  	value = self.observations.observations.last.value
  	return value
  end

  def last_observation
  	last = self.observations.observations.last.date
  	return Date.parse(last).strftime("%b %d, %Y")
  end
end
