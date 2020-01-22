class Destination < ActiveRecord::Base
    has_many :destination_activities
    has_many :activities, through: :destination_activities
end