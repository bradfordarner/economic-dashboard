class Update < ActiveRecord::Base
  attr_accessible :indicator_id, :observations

  belongs_to :indicator

  serialize :observations
end
