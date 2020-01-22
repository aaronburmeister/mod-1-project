class CreateMainMenuOptionsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :main_menu_options do |t|
      t.string :option_name
      t.boolean :active
    end
  end
end
