
[1mFrom:[0m /home/michael/Development/Flatiron/1Mod/mod-1-project/lib/cli.rb @ line 94 Cli#add_destination:

    [1;34m79[0m: [32mdef[0m [1;34madd_destination[0m
    [1;34m80[0m:     prompt = [1;34;4mTTY[0m::[1;34;4mPrompt[0m.new
    [1;34m81[0m:     options = [1;34;4mActivity[0m.all.map { |activity| activity.name}
    [1;34m82[0m: 
    [1;34m83[0m:     puts [31m[1;31m"[0m[31mWhat is the name of the destination?[1;31m"[0m[31m[0m
    [1;34m84[0m:     destination_name = gets.chomp
    [1;34m85[0m: 
    [1;34m86[0m:     puts [31m[1;31m"[0m[31mGive me a description of this place:[1;31m"[0m[31m[0m
    [1;34m87[0m:     destination_description = gets.chomp
    [1;34m88[0m: 
    [1;34m89[0m:     destination_activities = prompt.multi_select([31m[1;31m"[0m[31mWhat can you do here?[1;31m"[0m[31m[0m, options)
    [1;34m90[0m:         
    [1;34m91[0m:         location_data = [1;34;4mGeocoder[0m.search([31m[1;31m"[0m[31m#{destination_name}[0m[31m, CO[1;31m"[0m[31m[0m)
    [1;34m92[0m:         destination_lat = location_data.first.data[[31m[1;31m"[0m[31mlat[1;31m"[0m[31m[0m].to_f
    [1;34m93[0m:         destination_long = location_data.first.data[[31m[1;31m"[0m[31mlon[1;31m"[0m[31m[0m].to_f
 => [1;34m94[0m:         binding.pry
    [1;34m95[0m:         
    [1;34m96[0m:     [1;34m# Destination.create(name: destination_name, description: destination_description, latitude: nil, longitude: nil)[0m
    [1;34m97[0m: [32mend[0m

