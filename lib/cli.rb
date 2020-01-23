
# require 'tty-prompt'

class Cli

    attr_accessor :user

    Prompt = TTY::Prompt.new

    def greeting
        system("clear")
        puts "Welcome to Colorado"  
        create_name 
    end
    
    def create_name
        puts "What's your name?"
        name = gets.chomp
        @user = User.new(name)
        main_menu
    end
    
    def main_menu
        main_menu_options = MainMenuOption.all.map {|option| option.option_name}
        user_action = Prompt.select("What do you want to do?", main_menu_options)
        
        if user_action == "See activities at my location"
            puts activity_at_location
            main_menu
        elsif user_action == "See destinations with a specific activity"
            puts destination_with_activity
            main_menu
        elsif user_action == "See nearby destinations"
            puts nearby_destinations
            main_menu
        elsif user_action == "Search destinations near me with an activity"
            puts nearby_destination_activities
            main_menu
        elsif user_action == "Add a destination"
            add_destination
            main_menu
        elsif user_action == "Add an activity"
            add_activity
            main_menu
        elsif user_action == "Update destination description"
            update_description
            main_menu
        elsif user_action == "Remove record"
            destroy_record
            main_menu
        elsif user_action == "Exit"
            puts "See you later!!!"
        end     
    end

    ################### HELPER FUNCTIONS ####################

    def ask_user_location
        if !@user.location
            @user.location = Prompt.select("Where are you?", all_destinations)
        end
    end

    def all_activities
        Activity.all.map do |activity|
            activity.name
        end
    end

    def all_destinations
        Destination.all.map do |destination|
            destination.name
        end
    end

    def get_names list_of_objects
        list_of_objects.map do |object|
            object.name
        end
    end

    def get_activity_objects activity_list
        activity_list.map do |activity|
            Activity.find_by(name: activity)
        end
    end

    def get_destination_objects destination_list
        destination_list.map do |destination|
            Destination.find_by(name: destination)
        end
    end

    #############################################################################

    def activity_at_location
        ask_user_location
        puts "Here is the list all you can do in #{@user.location}:"
        activities = Destination.find_by(name: @user.location).activities
        get_names(activities)
    end

    def destination_with_activity
        user_activity = Prompt.select("What do you want to do?", all_activities)
        puts "Here are the locations with the following activity:"
        destinations = Activity.find_by(name: activity).destinations
        get_names(destinations)
    end

    def add_activity
        puts "What the name of activity you would like to add?"
        name1 = gets.chomp
        new_activity = Activity.create(name: name1)
        place = Prompt.multi_select("Where you can do this activity?", all_destinations)
        new_place = get_destination_objects(place)
        new_place.each do |place| 
            DestinationActivity.create(destination_id: place.id,activity_id: new_activity.id)
        end  
    end

    def add_destination
        puts "What is the name of the destination?"
        destination_name = gets.chomp
        
        location_data = Geocoder.search("#{destination_name}, CO")

        if location_data.length  == 0
            puts "This place doesn't exist. Try again"
            add_destination
        end

        puts "Give me a description of this place:"
        destination_description = gets.chomp
        
        destination_activities = prompt.multi_select("What can you do here?", all_activities)            
                
        destination_lat = location_data.first.data["lat"].to_f
        destination_long = location_data.first.data["lon"].to_f
    
        new_destination = Destination.create(name: destination_name, description: destination_description, latitude: destination_lat, longitude: destination_long)
        activities_objects = get_activity_objects(destination_activities)
        activities_objects.each do |activity| 
            DestinationActivity.create(destination_id: new_destination.id,activity_id: activity.id)
        end  

        puts "#{destination_name} has been added to the list of destinations"            
    end

    def nearby_destinations
        ask_user_location

        puts "How far away do you want to search (in miles)?"
        radius = gets.chomp.to_f

        home_base = Destination.find_by(name: @user.location)
        home = [home_base.latitude,
        home_base.longitude]
        
        destinations = Destination.select do |destination|
           Haversine.distance(home, [destination.latitude, destination.longitude]).to_miles <= radius
        end
        
        get_names(destinations)
    end
      
    def nearby_destination_activities
        activity = Prompt.select("What do you want to do?", all_activities)
        
        places = nearby_destinations
        
        places_objects = get_destination_objects(places)

        destinations = places_objects.select do |place|
            place.activities.include?(Activity.find_by(name: activity))
        end

        get_names(destinations)
    end

    def update_description
        destination = Prompt.select("Which destination description do you want to update?", all_destinations)

        find_destination = Destination.find_by(name: destination)
        puts "What do you want to change decription to?"
        new_destination = gets.chomp
        destination.update(description: new_destination)
    end

    def destroy_record
        record = Prompt.select("What would you like to remove?",["Destination", "Activity"])

        if record == "Destination"
            destroy_Destination

        elsif record == "Activity"
            destroy_Activity
        end
    end

    def destroy_Activity
        name_activity = Prompt.select("What activity do you want to remove?", all_activities)
            delete_activity = Activity.find_by(name: name_activity)
            delete_activity.destroy
    end

    def destroy_Destination
        city_name = Prompt.select("What destination do you want to remove?", all_destinations)
        city_object = Destination.find_by(name: city_name)
        city_object.destroy
    end
end