class Feed < ActiveRecord::Base

	  belongs_to :app

	  before_create do
      self.push_date = DateTime.now
	end
end
