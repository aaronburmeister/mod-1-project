
require 'tty-prompt'

class Cli


    def greeting
        puts "Welcome to Colorado"  
        create_name 
    end
    
    def create_name
        # puts "What's your name?"
        # name = gets.chomp
        user = User.new("Alice")
        main_menu(user)
    end
    
    def main_menu(user)
        prompt = TTY::Prompt.new
        array = Destination.all.map do |destination|
            destination.name
        end
        user.location = prompt.select("Where are you?", array)
        activity_at_location(user.location)
        destination_with_activity("Hiking")
    end

    def activity_at_location(location)
        puts "Here is the list all you can do in #{location}:"
        activities = Destination.find_by(name: location).activities

        list = activities.map do |activity|
            activity.name
        end
        puts list
    end

    def destination_with_activity(activity)
        puts "Here is all the location with the following activity"
        destinations = Activity.find_by(name: activity).destinations

        list = destinations.map do |destination|
            destination.name
        end
        puts list  
    end
end