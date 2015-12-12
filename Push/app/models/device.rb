class Device < ActiveRecord::Base

    validates :uuid, presence: true, uniqueness: {scope: :app_id}
    validates :token, presence: true, uniqueness: {scope: :app_id}
	
	belongs_to :app, counter_cache: true

end
