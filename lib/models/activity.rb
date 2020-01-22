class Activity < ActiveRecord::Base
    has_many :destination_activities
    has_many :destinations, through: :destination_activities
end