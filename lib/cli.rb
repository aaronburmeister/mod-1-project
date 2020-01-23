
# require 'tty-prompt'

class Cli
    def greeting
        puts "Welcome to Colorado"  
        create_name 
    end
    
    def create_name
        puts "What's your name?"
        name = gets.chomp
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

        if user_action == "Add a destination"
            add_destination
        end
        
        if user_action == "Add an activity"
            add_activity
        end
        
        if user_action == "Update destination description"
            update_description
        end    

        if user_action == "Remove record"
            destroy_record
        end
        
        if user_action == "Exit"
            puts "See you later!!!"
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

    def add_activity
        prompt = TTY::Prompt.new
        puts "What the name of activity you would like to add?"
        name1 = gets.chomp
        new_activity = Activity.create(name: name1)
        options = Destination.all.map do |destination|
            destination.name
        end
        place = prompt.multi_select("Where you can do this activity?", options)
        new_place = place.map do |place|
            Destination.find_by(name: place)
        end
        new_place.each do |place| DestinationActivity.create(destination_id: place.id,activity_id: new_activity.id)
        end  
    end

    def add_destination
        prompt = TTY::Prompt.new
        options = Activity.all.map { |activity| activity.name}

        puts "What is the name of the destination?"
        destination_name = gets.chomp
        
        location_data = Geocoder.search("#{destination_name}, CO")

        if location_data.length  == 0
            puts "This place doesn't exist. Try again"
            add_destination
        end

        puts "Give me a description of this place:"
        destination_description = gets.chomp
        
        destination_activities = prompt.multi_select("What can you do here?", options)            

        destination_lat = location_data.first.data["lat"].to_f
        destination_long = location_data.first.data["lon"].to_f
        Destination.create(name: destination_name, description: destination_description, latitude: destination_lat, longitude: destination_long)
        puts "#{destination_name} has been added to the list of destinations"            
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

    def update_description
        prompt = TTY::Prompt.new
        options = Destination.all.map do |destination|
            destination.name
        end
        destination = prompt.select("Which destination description do you want to update?", options)

            find_destination = Destination.find_by(name: destination)
            puts "What do you want to change decription to?"
                new_destination = gets.chomp
                destination.update(description: new_destination)
    end

    def destroy_record
        prompt = TTY::Prompt.new
        record = prompt.select("What would you like to remove?",["Destination", "Activity"])

        if record == "Destination"
            destroy_Destination

        elsif record == "Activity"
            destroy_Activity
        end
    end

    def destroy_Activity
        prompt = TTY::Prompt.new
        options = Activity.all.map do |activity|
            activity.name
        end
        name_activity = prompt.select("What activity do you want to remove?", options)
            delete_activity = Activity.find_by(name: name_activity)
            delete_activity.destroy
        end

    def destroy_Destination
        prompt = TTY::Prompt.new
        options = Destination.all.map do |destination|
            destionation.name
        end
        city_name = Destination.find_by(name: city_name)
        city_object.destroy
    end
end