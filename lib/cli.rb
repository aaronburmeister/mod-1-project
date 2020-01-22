class Cli
    def greeting
        puts "Welcome to Colorado"  
        create_name 
    end
    
    def create_name
        puts "What's your name?"
        name = gets.chomp
        User.new(name)
        main_menu
    end
    
    def main_menu
        puts "This is main menu"
    end
end