class CreateDestinationsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :description
      t.float :latitude
      t.float :longitude
    end
  end
end
