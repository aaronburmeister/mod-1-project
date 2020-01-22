
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
        binding.pry
    end
end