
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
        puts "Here is the list all you can do in #{user.location}:"
        activities = Destination.find_by(name: user.location).activities

        list = activities.map do |activity|
            activity.name
        end
        puts list
        binding.pry
    end
end