class CreateDestinationActivitiesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :destination_activities do |t|
      t.references :destination
      t.references :activity
    end
  end
end
