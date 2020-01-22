
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
        main_menu_options = MainMenuOption.all.map {|option| option.option_name}
        user_action = prompt.select("What do you want to do?", main_menu_options)
        
        if user_action == "See activities at my location"
            options = Destination.all.map do |destination|
                destination.name
            end
            user.location = prompt.select("Where are you?", options)
            puts "Here is the list all you can do in #{user.location}:"
            activity_at_location(user.location)
        end

        if user_action == "See destinations with a specific activity"
            options = Activity.all.map do |activity|
                activity.name
            end
            user_activity = prompt.select("What do you want to do?", options)
            puts "Here are the locations with the following activity:"
            destination_with_activity(user_activity)
        end
        
    end

    def activity_at_location(location)
        # puts "Here is the list all you can do in #{location}:"
        activities = Destination.find_by(name: location).activities

        list = activities.map do |activity|
            activity.name
        end
        puts list
    end

    def destination_with_activity(activity)
        # puts "Here is all the location with the following activity"
        destinations = Activity.find_by(name: activity).destinations

        list = destinations.map do |destination|
            destination.name
        end
        puts list  
    end
end