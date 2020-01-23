
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

        if user_action == "See nearby destinations"
            options = Destination.all.map do |destination|
                destination.name
            end
            user.location = prompt.select("Where are you?", options)

            puts "How far away do you want to search?"
            radius = gets.chomp.to_f
            puts nearby_destinations(user, radius)
        end
        
        if user_action == "Search destinations near me with an activity"
            options = Destination.all.map do |destination|
                destination.name
            end
            user.location = prompt.select("Where are you?", options)

            puts "How far away do you want to search (in miles)?"
            radius = gets.chomp.to_f
            
            activities = Activity.all.map do |activity|
                activity.name
            end
            user_activity = prompt.select("What do you want to do?", activities)
            
            puts nearby_destination_activities(user, radius, user_activity)
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

    def nearby_destinations(user, radius)
        
        home_base = Destination.find_by(name: user.location)
        home = [home_base.latitude,
        home_base.longitude]
        
        destinations = Destination.select do |destination|
           Haversine.distance(home, [destination.latitude, destination.longitude]).to_miles <= radius
        end
        
        list = destinations.map do |destination|
            destination.name
        end  
    end
      
    def nearby_destination_activities(user, radius, activity)
        places = nearby_destinations(user, radius)
        
        places_objects = places.map do |place|
            Destination.find_by(name: place)
        end

        destinations = places_objects.select do |place|
            place.activities.include?(Activity.find_by(name: activity))
        end

        list = destinations.map do |destination|
            destination.name
        end  
    end
end