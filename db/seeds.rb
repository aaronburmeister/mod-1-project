DestinationActivity.destroy_all
Destination.destroy_all
MainMenuOption.destroy_all

Destination.create(name: "Denver", description: "The City and County of Denver, is the capital and most populous municipality of the U.S. state of Colorado.", latitude: 39.73915, longitude: -104.9847)

Destination.create(name:"Aspen", description: "Founded as a mining camp during the Colorado Silver Boom and later named Aspen because of the abundance of aspen trees in the area, the city boomed during the 1880s, its first decade of existence.", latitude: 39.1911, longitude: -106.81754)

Destination.create(name: "Palisade", description: "Palisade is a Statutory Town in Mesa County, Colorado, United States.", latitude: 39.1911, longitude: -106.81754)

Destination.create(name: "Rocky Mountain National Park", description: "Rocky Mountain National Park is an American national park located approximately 76 mi (122 km) northwest of Denver International Airport.", latitude: 39.613357, longitude: -105.286243)

Activity.destroy_all

Activity.create(name: "Skiing")
Activity.create(name: "Hiking")
Activity.create(name: "Shopping")
Activity.create(name: "Nightlife")
Activity.create(name: "Breweries")
Activity.create(name: "Museums")
Activity.create(name: "Wildlife Viewing")
Activity.create(name: "Wineries")



DestinationActivity.create(destination_id: Destination.find_by(name: "Denver").id, activity_id: Activity.find_by(name: "Shopping").id)
DestinationActivity.create(destination_id: Destination.find_by(name: "Denver").id, activity_id: Activity.find_by(name: "Nightlife").id)
DestinationActivity.create(destination_id: Destination.find_by(name: "Denver").id, activity_id: Activity.find_by(name: "Breweries").id)
DestinationActivity.create(destination_id: Destination.find_by(name: "Denver").id, activity_id: Activity.find_by(name: "Museums").id)

DestinationActivity.create(destination_id: Destination.find_by(name: "Aspen").id, activity_id: Activity.find_by(name: "Skiing").id)
DestinationActivity.create(destination_id: Destination.find_by(name: "Aspen").id, activity_id: Activity.find_by(name: "Hiking").id)
DestinationActivity.create(destination_id: Destination.find_by(name: "Aspen").id, activity_id: Activity.find_by(name: "Shopping").id)
DestinationActivity.create(destination_id: Destination.find_by(name: "Aspen").id, activity_id: Activity.find_by(name: "Nightlife").id)
DestinationActivity.create(destination_id: Destination.find_by(name: "Aspen").id, activity_id: Activity.find_by(name: "Wildlife Viewing").id)

DestinationActivity.create(destination_id: Destination.find_by(name: "Palisade").id, activity_id: Activity.find_by(name: "Hiking").id)
DestinationActivity.create(destination_id: Destination.find_by(name: "Palisade").id, activity_id: Activity.find_by(name: "Wineries").id)

DestinationActivity.create(destination_id: Destination.find_by(name: "Rocky Mountain National Park").id, activity_id: Activity.find_by(name: "Hiking").id)
DestinationActivity.create(destination_id: Destination.find_by(name: "Rocky Mountain National Park").id, activity_id: Activity.find_by(name: "Wildlife Viewing").id)

MainMenuOption.create(option_name: "See activities at my location", active: true)
MainMenuOption.create(option_name: "See destinations with a specific activity", active: true)
MainMenuOption.create(option_name: "See nearby destinations", active: true)
MainMenuOption.create(option_name: "Search destinations near me with an activity", active: true)
MainMenuOption.create(option_name: "Add a destination", active: true)
MainMenuOption.create(option_name: "Add an activity", active: true)
MainMenuOption.create(option_name: "Exit", active: true)
