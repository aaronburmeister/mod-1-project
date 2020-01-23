
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
            puts activity_at_location(user.location)
        end

        if user_action == "See destinations with a specific activity"
            options = Activity.all.map do |activity|
                activity.name
            end
            user_activity = prompt.select("What do you want to do?", options)
            puts "Here are the locations with the following activity:"
            puts destination_with_activity(user_activity)
        end

        if user_action == "See nearby destinations"
            puts "There aren't any. Sorry."
        end
        
        if user_action == "Search destinations near me with an activity"
            puts "Who are you kidding? You're not getting off the couch."
        end

        if user_action == "Add a destination"
            add_destination
        end
        
        if user_action == "Add an activity"
            puts "This is the add an activity method."
        end        
    end

    def activity_at_location(location)
        # puts "Here is the list all you can do in #{location}:"
        activities = Destination.find_by(name: location).activities

        list = activities.map do |activity|
            activity.name
        end
        return list
    end

    def destination_with_activity(activity)
        # puts "Here is all the location with the following activity"
        destinations = Activity.find_by(name: activity).destinations

        list = destinations.map do |destination|
            destination.name
        end
        return list  
    end

    def add_destination
        prompt = TTY::Prompt.new
        options = Activity.all.map { |activity| activity.name}

        puts "What is the name of the destination?"
        destination_name = gets.chomp

        puts "Give me a description of this place:"
        destination_description = gets.chomp
        
        destination_activities = prompt.multi_select("What can you do here?", options)
            
            location_data = Geocoder.search("#{destination_name}, CO")
            destination_lat = location_data.first.data["lat"].to_f
            destination_long = location_data.first.data["lon"].to_f
            Destination.create(name: destination_name, description: destination_description, latitude: destination_lat, longitude: destination_long)
            puts "#{destination_name} has been added to the list of destinations"            
    end
end