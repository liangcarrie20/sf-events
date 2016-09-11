require 'open-uri'

class Event < ActiveRecord::Base
	validates :title, :description, :address, :event_date, :event_time, presence: true

end


